/****** Object:  Procedure [dbo].[S_readRequest_Ack_ResetDetails]    Committed by VersionSQL https://www.versionsql.com ******/

--ER0502 - Swathi - 16/03/2021 :: AAAPL : Altered Proc to include Remarks for each Action
--[dbo].[S_readRequest_Ack_ResetDetails] '2020-09-10','2020-09-30','','Win Chennai - SCP','','','AvgCalltype'

CREATE  proc [dbo].[S_readRequest_Ack_ResetDetails]
@starttime datetime,
@endtime datetime,
@Shift nvarchar(250)='',
@PlantID nvarchar(500)='',
@Machineid nvarchar(4000)='',
@calltype nvarchar(500)='',
@param nvarchar(50) =''
As 
Begin

Declare @strsql as nvarchar(4000)
Declare @strplant as nvarchar(4000)
Declare @strmachine as nvarchar(2000)
Declare @Strcalltype as nvarchar(2000)

select @strplant=''
select @strmachine=''
select @Strcalltype=''

create table #ACK_request
(
Pinterface nvarchar(50),
Minterface nvarchar(50),
Eventinterface nvarchar(50),
PlantID nvarchar(50),
Machineid nvarchar(50),
[ShiftDate] datetime,
[ShiftName] nvarchar(50),
[From time] datetime,
[To Time] datetime,
Eventid nvarchar(50),
RequestedTime datetime,
AcknowledgeTime datetime,
ResetTime datetime,
Completedtime datetime,
ACKTime float,
FIXTime float ,
CMPTime float,
AvgAcktime float,
AvgFixTime float,
AvgCMPTime float,
RaisedRemarks nvarchar(500),
AckRemarks nvarchar(500),
ResetRemarks nvarchar(500),
CloseRemarks nvarchar(500)
)

create table #ACK_requestMaster
(
Pinterface nvarchar(50),
Minterface nvarchar(50),
Eventinterface nvarchar(50),
PlantID nvarchar(50),
Machineid nvarchar(50),
[ShiftDate] datetime,
[ShiftName] nvarchar(50),
[From time] datetime,
[To Time] datetime,
Eventid nvarchar(50)
)


CREATE TABLE #ShiftDetails 
(
	PDate datetime,
	Shiftid nvarchar(20),
	ShiftStart datetime,
	ShiftEnd datetime
)


if isnull(@PlantID,'')<>''
begin
set @strplant=' AND Plantinformation.Plantid=N'''+@PlantID+''''	
end

If isnull(@Machineid,'')<>''
begin
set @strmachine=' AND Machineinformation.MachineID  in ( ' +  @machineid + ') '
end

If isnull(@calltype,'')<>''
begin
set @strcalltype=' And Helpcodemaster.[help_description] in (' + @Calltype + ')'
end

Declare @CurStrtTime as datetime,@CurEndTime as datetime
Declare @shiftstart as datetime,@shiftend as datetime
select @CurStrtTime = @starttime
Select @CurEndTime =@endtime


while @CurStrtTime<=@CurEndTime
BEGIN
	INSERT #ShiftDetails(Pdate, Shiftid, ShiftStart, ShiftEnd)
	EXEC s_GetShiftTime @CurStrtTime,''
	SELECT @CurStrtTime=DATEADD(DAY,1,@CurStrtTime)
END

if isnull(@Shift,'') <> ''
Begin
	select @strsql =''
	Select @strsql = @strsql +  'Delete from #ShiftDetails where shiftid not in ( ' +  @Shift + ') '
	exec(@strsql)
End

select @shiftstart = Min(ShiftStart) from #ShiftDetails 
Select @shiftend = Max(Shiftend) from #ShiftDetails 

select @strsql =''
select @strsql = @strsql + 'Insert into #ACK_requestMaster (PInterface,Plantid,MInterface,Machineid,EventInterface,Eventid,ShiftDate,[From time],[To Time],ShiftName)
SELECT distinct plantinformation.Plantcode,plantinformation.Plantid,Machineinformation.interfaceid,Machineinformation.machineid,Helpcodemaster.[Help_code], Helpcodemaster.[help_description],S.PDate,S.shiftstart,S.shiftend,S.Shiftid FROM Machineinformation
inner join Plantmachine on Machineinformation.machineid=Plantmachine.machineid
inner join plantinformation on plantinformation.plantid=Plantmachine.plantid
Cross join #ShiftDetails S,helpcodemaster where 1=1'
Select @strsql = @strsql + @strmachine + @StrPlant  + @strcalltype
print @strsql
Exec (@strsql) 

Insert into #ACK_request (PInterface,Plantid,MInterface,Machineid,EventInterface,Eventid,ShiftDate,[From time],[To Time],ShiftName,RequestedTime,ACKTime,FIXTime,CMPTime,
AvgAcktime,AvgFixTime,AvgCMPTime)
select H.plantid,AK.Plantid,H.machineid,AK.machineid,H.helpcode,AK.eventid,AK.Shiftdate,AK.[From time],AK.[To Time],AK.Shiftname,min(H.Starttime) as RequestedTime,0,0,0,0,0,0 from helpcodedetails H
 inner join #ACK_requestMaster AK on H.plantid=AK.PInterface and H.machineid=AK.MInterface and H.helpcode=AK.EventInterface
 where (H.action1='01') and H.Starttime>=AK.[From time] and H.starttime<=AK.[To Time]
group by H.plantid,AK.Plantid,H.machineid,AK.machineid,H.helpcode,AK.eventid,AK.Shiftdate,AK.[From time],AK.[To Time],AK.Shiftname,H.Starttime


Update #ACK_request set AcknowledgeTime = T2.AcknowledgeTime, ACKTime = T2.ACKTime from
(select T1.plantid,T1.machineid,T1.helpcode,T1.RequestedTime,T1.AcknowledgeTime as AcknowledgeTime,Datediff(s,T1.RequestedTime,T1.AcknowledgeTime) as ACKTime  from
(select V.plantid,V.machineid,V.helpcode,V.Starttime as RequestedTime,Max(V.Endtime) as AcknowledgeTime from helpcodedetails v
inner join #ACK_request AK on v.plantid=AK.Pinterface and v.Machineid=AK.Minterface and v.HelpCode=AK.Eventinterface and V.StartTime=AK.RequestedTime
where isnull(V.Endtime,'1900-01-01')<>'1900-01-01' and (V.action1='01' and v.action2='02') and v.Starttime>=@shiftstart and v.Endtime<=@shiftend
group by V.plantid,V.machineid,V.helpcode,V.Starttime)T1) as T2 inner join #ACK_request r on T2.plantid=r.Pinterface and T2.Machineid=r.Minterface and T2.HelpCode=r.Eventinterface
and r.RequestedTime = t2.RequestedTime

Update #ACK_request set ResetTime = T2.Resettime, FIXTime = T2.FIXTime from
(select T1.plantid,T1.machineid,T1.helpcode,T1.RequestedTime,T1.Resettime as Resettime,Datediff(s,T1.RequestedTime,T1.ResetTime) as FIXTime  from
(select V.plantid,V.machineid,V.helpcode,V.Starttime as RequestedTime,Max(V.Endtime) as ResetTime from helpcodedetails v
inner join #ACK_request AK on v.plantid=AK.Pinterface and v.Machineid=AK.Minterface and v.HelpCode=AK.Eventinterface and V.StartTime=AK.RequestedTime
where isnull(V.Endtime,'1900-01-01')<>'1900-01-01' and (V.action1='01' and v.action2='03') and v.Starttime>=@shiftstart and v.Endtime<=@shiftend
group by V.plantid,V.machineid,V.helpcode,V.Starttime)T1) as T2 inner join #ACK_request r on T2.plantid=r.Pinterface and T2.Machineid=r.Minterface and T2.HelpCode=r.Eventinterface
and r.RequestedTime = t2.RequestedTime

Update #ACK_request set Completedtime = T2.Completedtime, CMPTime = T2.CMPTime from
(select T1.plantid,T1.machineid,T1.helpcode,T1.RequestedTime,T1.Completedtime as Completedtime,Datediff(s,T1.RequestedTime,T1.Completedtime) as CMPTime  from
(select V.plantid,V.machineid,V.helpcode,V.Starttime as RequestedTime,Max(V.Endtime) as Completedtime from helpcodedetails v
inner join #ACK_request AK on v.plantid=AK.Pinterface and v.Machineid=AK.Minterface and v.HelpCode=AK.Eventinterface and V.StartTime=AK.RequestedTime
where isnull(V.Endtime,'1900-01-01')<>'1900-01-01' and (V.action1='01' and v.action2='04') and v.Starttime>=@shiftstart and v.Endtime<=@shiftend
group by V.plantid,V.machineid,V.helpcode,V.Starttime)T1) as T2 inner join #ACK_request r on T2.plantid=r.Pinterface and T2.Machineid=r.Minterface and T2.HelpCode=r.Eventinterface
and r.RequestedTime = t2.RequestedTime



Update #ACK_request set RaisedRemarks = T2.Remarks from
(select V.plantid,V.machineid,V.helpcode,V.Starttime as RequestedTime,v.Remarks from helpcodedetails v
inner join #ACK_request AK on v.plantid=AK.Pinterface and v.Machineid=AK.Minterface and v.HelpCode=AK.Eventinterface and V.StartTime=AK.RequestedTime
where V.action1='01' and isnull(V.Endtime,'1900-01-01')='1900-01-01' and v.Starttime>=@shiftstart and v.StartTime<=@shiftend
)as T2 inner join #ACK_request r on T2.plantid=r.Pinterface and T2.Machineid=r.Minterface and T2.HelpCode=r.Eventinterface
and r.RequestedTime = t2.RequestedTime

Update #ACK_request set AckRemarks = T2.Remarks from
(select V.plantid,V.machineid,V.helpcode,V.Starttime as RequestedTime,v.Remarks from helpcodedetails v
inner join #ACK_request AK on v.plantid=AK.Pinterface and v.Machineid=AK.Minterface and v.HelpCode=AK.Eventinterface and V.StartTime=AK.RequestedTime
where isnull(V.Endtime,'1900-01-01')<>'1900-01-01' and (V.action1='01' and v.action2='02') and v.Starttime>=@shiftstart and v.Endtime<=@shiftend
)as T2 inner join #ACK_request r on T2.plantid=r.Pinterface and T2.Machineid=r.Minterface and T2.HelpCode=r.Eventinterface
and r.RequestedTime = t2.RequestedTime

Update #ACK_request set ResetRemarks = T2.Remarks from
(select V.plantid,V.machineid,V.helpcode,V.Starttime as RequestedTime,v.Remarks from helpcodedetails v
inner join #ACK_request AK on v.plantid=AK.Pinterface and v.Machineid=AK.Minterface and v.HelpCode=AK.Eventinterface and V.StartTime=AK.RequestedTime
where isnull(V.Endtime,'1900-01-01')<>'1900-01-01' and (V.action1='01' and v.action2='03') and v.Starttime>=@shiftstart and v.Endtime<=@shiftend
)as T2 inner join #ACK_request r on T2.plantid=r.Pinterface and T2.Machineid=r.Minterface and T2.HelpCode=r.Eventinterface
and r.RequestedTime = t2.RequestedTime

Update #ACK_request set CloseRemarks = T2.Remarks from
(select V.plantid,V.machineid,V.helpcode,V.Starttime as RequestedTime,v.Remarks from helpcodedetails v
inner join #ACK_request AK on v.plantid=AK.Pinterface and v.Machineid=AK.Minterface and v.HelpCode=AK.Eventinterface and V.StartTime=AK.RequestedTime
where isnull(V.Endtime,'1900-01-01')<>'1900-01-01' and (V.action1='01' and v.action2='04') and v.Starttime>=@shiftstart and v.Endtime<=@shiftend
)as T2 inner join #ACK_request r on T2.plantid=r.Pinterface and T2.Machineid=r.Minterface and T2.HelpCode=r.Eventinterface
and r.RequestedTime = t2.RequestedTime	

If @param = ''
BEGIN
  Select Plantid,Machineid,Eventid,ShiftDate,ShiftName,RequestedTime,AcknowledgeTime,ResetTime,Completedtime,round((ACKTime/60),2) as ACKTime,Round((FIXTime/60),2) as FIXTime,Round((CMPTime/60),2) as CMPTime
  ,RaisedRemarks,AckRemarks,ResetRemarks,CloseRemarks from #ACK_request Order by ShiftDate,ShiftName,Plantid,Machineid,Eventinterface,RequestedTime
END

If @Param = 'AvgCalltype'
Begin
	set @strsql=''
	set @strsql='update #ACK_request set AvgAcktime=k.AvgAcktime,AvgFixTime=k.AvgFixTime,AvgCMPTime=k.AvgCMPTime from
    (select eventid, avg(acktime) as AvgAcktime,avg(fixtime) as AvgFixTime,avg(CMPTime) as AvgCMPTime from #ACK_request
	where (acktime>0 or fixtime>0 or cmptime>0) group by eventid)k inner join #ACK_request r on r.eventid=k.eventid '
	exec(@strsql)


    select  H.Help_Description,Isnull(round((T1.AvgAcktime/60),1),0) as AvgAcktime,Isnull(round((T1.AvgFixTime/60),1),0) as AvgFixTime,Isnull(round((T1.AvgCMPTime/60),1),0) as AvgCMPTime from
	(select distinct A.eventid,A.AvgAcktime,A.AvgFixTime,A.AvgCMPTime from #ACK_request A )T1 
	 right outer join helpcodemaster H on H.Help_Description=T1.Eventid
	 order by H.Help_Code

END


end
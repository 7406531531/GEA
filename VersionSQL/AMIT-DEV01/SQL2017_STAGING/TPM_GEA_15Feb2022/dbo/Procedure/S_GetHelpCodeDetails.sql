/****** Object:  Procedure [dbo].[S_GetHelpCodeDetails]    Committed by VersionSQL https://www.versionsql.com ******/

/*******************************************************************************************************************
---NR0095 - 2013-Oct-31 - SwathiKS :: Created New Procedure to log HelpCode Details into Message History Table based on
-- rules in Helprequestrule table.
--ER0377 - 11/Mar/2014 - SwathiKS :: To introduce with(NOLOCK) in Select Statements for Performance Optimization.
--ER0458 - 02/Feb/2018 - SwathiKS - To handle 2nd Level escalation for Raised and To enable Escalation for Ack.
--ER0502 : 19/Mar/2021 : SwathiKS :: TO Include Remarks For every Raised,Ack & Reset.
ER0506 : SwathiKS : 25/Jun/2021::To change MessageFormat for GEA

*******************************************************************************************************************/
CREATE Procedure [dbo].[S_GetHelpCodeDetails]
AS
BEGIN

Create table #HelpCode
(
	Plantid nvarchar(50),
	Machineid nvarchar(50),
	HelpDescription nvarchar(50),
	ActionInfo nvarchar(50),
	LastCallTime Datetime,
	MobileNo nvarchar(500),
	Level2MobNo nvarchar(500),
	MessageInfo nvarchar(500),
	Level2Threshold int,
	CountofRows int,
	Helpcode nvarchar(50),
	ActionNo nvarchar(10),
	Level3MobNo nvarchar(500), ----ER0458
	Level3Threshold int, ----ER0458
	Raisedtime datetime, ----ER0458
	Remarks nvarchar(500) --ER0502
)

Create table #FinalHelpCode
(
	slno bigint identity(1,1),
	Plantid nvarchar(50),
	Machineid nvarchar(50),
	HelpDescription nvarchar(50),
	ActionInfo nvarchar(50),
	LastCallTime Datetime,
	MobileNo nvarchar(500),
	Level2MobNo nvarchar(500),
	MessageInfo nvarchar(500),
	ActionNo nvarchar(10),
	HelpCode nvarchar(10),
	ShiftID int,
	Raisedtime datetime, ----ER0458
	Remarks nvarchar(500) --ER0502
)

create table #CurrentShift
(
	Startdate datetime,
	shiftname nvarchar(10),
	Starttime datetime,
	Endtime datetime,
	shiftid int
)


Declare @Reqtime as datetime
Declare @i as integer,@j as integer
Declare @logicalstartdate datetime

Declare @curtime as datetime
Select @curtime = convert(Nvarchar(20),Getdate(),120)


Insert into #HelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,MobileNo,Level2MobNo,MessageInfo,Level2Threshold,Helpcode,ActionNo,Level3MobNo,Level3Threshold,Raisedtime) ----ER0458
select P.Plantid,M.Machineid,HM.Help_Description,HA.Action,
Max(HD.Starttime),HR.MobileNo,HR.Level2MobNo,HR.[Message],HR.Level2Threshold,HM.Help_Code,HA.ActionNo,HR.Level3MobNo,HR.Level3Threshold,Max(HD.Starttime) ----ER0458
from HelpCodeDetails HD with (NOLOCK) --ER0377
inner join HelpRequestRule HR on HD.Plantid=HR.Plantid and HD.Machineid=HR.Machineid and HD.HelpCode=HR.HelpCode and HD.Action1=HR.Action
inner join Machineinformation M on HD.Machineid=M.interfaceid
inner join HelpCodeMaster HM on HM.Help_Code=HD.HelpCode
inner join HelpCodeActionInfo HA on HA.ActionNo=HD.Action1
inner join Plantmachine PM on PM.machineid=M.machineid
inner join Plantinformation P on P.Plantid=PM.Plantid
where HD.Action1='01' 
group by P.Plantid,M.Machineid,HM.Help_Description,HA.Action,
HR.MobileNo,HR.Level2MobNo,HR.[Message],HR.Level2Threshold,HM.Help_Code,HA.ActionNo,HR.Level3MobNo,HR.Level3Threshold ----ER0458

--ER0502 From Here
Update #HelpCode set Remarks = T1.AckRemarks from 
(select H.Plantid,H.Machineid,H.LastCallTime,HD.Remarks as AckRemarks,H.Helpcode
from #HelpCode H with (NOLOCK) 
inner join Machineinformation M on H.Machineid=M.machineid
inner join Plantmachine PM on PM.machineid=M.machineid
inner join Plantinformation P on P.Plantid=PM.Plantid
inner join HelpCodeDetails HD on P.PlantCode=HD.Plantid and HD.Machineid=M.InterfaceID and HD.HelpCode=H.HelpCode and HD.StartTime=H.LastCallTime
where HD.Action1='01') T1 
inner join #HelpCode H on T1.Plantid=H.Plantid and T1.Machineid=H.Machineid
and T1.LastCallTime=H.LastCallTime and T1.Helpcode=H.Helpcode 
--ER0502 From Here

Update #HelpCode set LastCallTime = T1.LastCall,ActionInfo=T1.Action,MobileNo=T1.MobileNo,
Level2MobNo=T1.Level2MobNo,MessageInfo=T1.[Message],Level2Threshold=T1.Level2Threshold,ActionNo=T1.ActionNo, ----ER0458
Level3MobNo=T1.Level3MobNo,Level3Threshold=T1.Level3Threshold from ----ER0458
(select P.Plantid,M.Machineid,HM.Help_Description,HA.Action,
max(HD.Starttime)as Starttime,Max(HD.Endtime)as LastCall,HR.MobileNo,HR.Level2MobNo,HR.[Message],HR.Level2Threshold,HA.ActionNo,HR.Level3MobNo,HR.Level3Threshold ----ER0458
from HelpCodeDetails HD with (NOLOCK) --ER0377
inner join HelpRequestRule HR on HD.Plantid=HR.Plantid and HD.Machineid=HR.Machineid and HD.HelpCode=HR.HelpCode and HD.Action2=HR.Action
inner join Machineinformation M on HD.Machineid=M.interfaceid
inner join HelpCodeMaster HM on HM.Help_Code=HD.HelpCode
inner join HelpCodeActionInfo HA on HA.ActionNo=HD.Action2
inner join Plantmachine PM on PM.machineid=M.machineid
inner join Plantinformation P on P.Plantid=PM.Plantid
where HD.Action2='02' 
group by P.Plantid,M.Machineid,HM.Help_Description,
HA.Action,HR.MobileNo,HR.Level2MobNo,HR.[Message],HR.Level2Threshold,HA.ActionNo,HR.Level3MobNo,HR.Level3Threshold) T1 ----ER0458
inner join #HelpCode H on T1.Plantid=H.Plantid and T1.Machineid=H.Machineid
--and T1.Starttime=H.LastCallTime and T1.Help_Description=H.HelpDescription ----ER0458
and T1.Starttime=H.Raisedtime and T1.Help_Description=H.HelpDescription ----ER0458

--ER0502 From Here
Update #HelpCode set Remarks = T1.AckRemarks from 
(select H.Plantid,H.Machineid,H.LastCallTime,HD.Remarks as AckRemarks,H.Helpcode
from #HelpCode H with (NOLOCK) 
inner join Machineinformation M on H.Machineid=M.machineid
inner join Plantmachine PM on PM.machineid=M.machineid
inner join Plantinformation P on P.Plantid=PM.Plantid
inner join HelpCodeDetails HD on P.PlantCode=HD.Plantid and HD.Machineid=M.InterfaceID and HD.HelpCode=H.HelpCode and HD.Endtime=H.LastCallTime
where HD.Action2='02') T1 
inner join #HelpCode H on T1.Plantid=H.Plantid and T1.Machineid=H.Machineid
and T1.LastCallTime=H.LastCallTime and T1.Helpcode=H.Helpcode 
--ER0502 From Here

Update #HelpCode set LastCallTime = T1.LastCall,ActionInfo=T1.Action,MobileNo=T1.MobileNo,
Level2MobNo=T1.Level2MobNo,MessageInfo=T1.[Message],Level2Threshold=T1.Level2Threshold,ActionNo=T1.ActionNo , ----ER0458
Level3MobNo=T1.Level3MobNo,Level3Threshold=T1.Level3Threshold from ----ER0458
(select P.Plantid,M.Machineid,HM.Help_Description,HA.Action,
max(HD.Starttime)as Starttime,Max(HD.Endtime)as LastCall,HR.MobileNo,HR.Level2MobNo,HR.[Message],HR.Level2Threshold,HA.ActionNo, ----ER0458
HR.Level3Threshold,HR.Level3MobNo
from HelpCodeDetails HD with (NOLOCK) --ER0377
inner join HelpRequestRule HR on HD.Plantid=HR.Plantid and HD.Machineid=HR.Machineid and HD.HelpCode=HR.HelpCode and HD.Action2=HR.Action
inner join Machineinformation M on HD.Machineid=M.interfaceid
inner join HelpCodeMaster HM on HM.Help_Code=HD.HelpCode
inner join HelpCodeActionInfo HA on HA.ActionNo=HD.Action2
inner join Plantmachine PM on PM.machineid=M.machineid
inner join Plantinformation P on P.Plantid=PM.Plantid
where HD.Action2='03' 
group by P.Plantid,M.Machineid,HM.Help_Description,
HA.Action,HR.MobileNo,HR.Level2MobNo,HR.[Message],HR.Level2Threshold,HA.ActionNo,HR.Level3MobNo,HR.Level3Threshold) T1 ----ER0458
inner join #HelpCode H on T1.Plantid=H.Plantid and T1.Machineid=H.Machineid
and T1.Starttime=H.Raisedtime and T1.Help_Description=H.HelpDescription ----ER0458


--ER0502 From Here
Update #HelpCode set Remarks = T1.AckRemarks from 
(select H.Plantid,H.Machineid,H.LastCallTime,HD.Remarks as AckRemarks,H.Helpcode
from #HelpCode H with (NOLOCK) 
inner join Machineinformation M on H.Machineid=M.machineid
inner join Plantmachine PM on PM.machineid=M.machineid
inner join Plantinformation P on P.Plantid=PM.Plantid
inner join HelpCodeDetails HD on P.PlantCode=HD.Plantid and HD.Machineid=M.InterfaceID and HD.HelpCode=H.HelpCode and HD.Endtime=H.LastCallTime
where HD.Action2='03') T1 
inner join #HelpCode H on T1.Plantid=H.Plantid and T1.Machineid=H.Machineid
and T1.LastCallTime=H.LastCallTime and T1.Helpcode=H.Helpcode 
--ER0502 From Here

Update #HelpCode set CountOfRows = isnull(CountOfRows,0) +  isnull(T.CountInit,0) from
(Select Count(*) as CountInit,M.Machineid,M.Requestedtime,H.ActionInfo from MessageHistory M with (NOLOCK) --ER0377
inner join #HelpCode H on M.Machineid=H.Machineid and M.RequestedTime=H.LastCallTime
 Group by M.Machineid,M.Requestedtime,H.ActionInfo)T inner join #HelpCode H on T.Machineid=H.Machineid and T.RequestedTime=H.LastCallTime


 --ER0506 from here
Declare @MsgFormat as int

If Exists(Select * from company where CompanyName like '%GEA%')
BEGIN
Select @MsgFormat=1
End
Else
Begin
Select @MsgFormat=2
End
--ER0506 till here

 ---Inserting when Data not present in MessageHistory for the incoming Machineid.
Insert into #FinalHelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,MobileNo,MessageInfo,Helpcode,ActionNo,Remarks)
select  H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.MobileNo,--H.MessageInfo,
case when @MsgFormat=1 then 'TPM-Trak Msg From Machine  ' + H.Machineid + ' : ' + H.MessageInfo + ' ' + 'Remarks: ' + isnull(H.Remarks,'') + ' ' + Convert(nvarchar(20),H.LastCallTime,100) else H.MessageInfo end, --ER0506
H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H
where H.machineid not in(select distinct isnull(Machineid,'a') from Messagehistory with (NOLOCK)) --ER0377

 ---Inserting when Machineid already exist in MessageHistory table but Timestamps are different and CountofRow in MessageHistory should be less than 1.
Insert into #FinalHelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,MobileNo,MessageInfo,Helpcode,ActionNo,Remarks)
select H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.MobileNo,--H.MessageInfo,
case when @MsgFormat=1 then 'TPM-Trak Msg From Machine  ' + H.Machineid + ' : ' + H.MessageInfo + ' ' + 'Remarks: ' + isnull(H.Remarks,'') + ' ' + Convert(nvarchar(20),H.LastCallTime,100) else H.MessageInfo end,
H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H
inner join (select Machineid,Max(RequestedTime) as RequestedTime from MessageHistory with (NOLOCK) --ER0377
group by Machineid) M on M.Machineid=H.Machineid and M.RequestedTime <> H.LastCallTime and isnull(H.CountOfRows,0)<1


-----ER0458 From Here
--To handle duplicates and 1st Level Escalation for action 'Initiated' 
--i.e Machine already present with Same Timestamp for the action not equal to 'Ack' and 'Reset' then CountofRows=1 then send message to Level2MobNos.
Insert into #FinalHelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,Mobileno,MessageInfo,Helpcode,ActionNo,Remarks)
--select  H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level2MobNo,H.MessageInfo,H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H --ER0506
select  H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level2MobNo,
case when @MsgFormat=1 then 'Since ' + cast(H.Level2Threshold/60 as nvarchar(10)) + ' mins ' + H.Machineid + ' Machine is not been addressed by the ' + H.HelpDescription + ' in charge.please take necessary action.' Else H.MessageInfo End, --ER0506
H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H 
inner join (select distinct Machineid,Max(RequestedTime) as RequestedTime from MessageHistory with (NOLOCK) --ER0377
group by  Machineid) M on M.Machineid=H.Machineid and M.RequestedTime=H.LastCallTime
where (H.ActionNo='01') and (Datediff(s,RequestedTime,@Curtime)>H.Level2Threshold and Datediff(s,RequestedTime,@Curtime)<H.Level3Threshold) and H.CountOfRows=1 --and Datediff(s,RequestedTime,@Curtime)< H.Threshold+20



--To handle duplicates and 2nd Level Escalation for action 'Initiated' 
--i.e Machine already present with Same Timestamp for the action not equal to 'Ack' and 'Reset' then CountofRows=2 then send message to Level3MobNos.
Insert into #FinalHelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,Mobileno,MessageInfo,Helpcode,ActionNo,Remarks)
--select  H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level3MobNo,H.MessageInfo,H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H --ER0506
select  H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level3MobNo,
case when @MsgFormat=1 then 'Since ' + cast(H.Level3Threshold/60 as nvarchar(10)) + ' mins ' + H.Machineid + ' Machine is not been addressed by the ' + H.HelpDescription + ' in charge.please take necessary action.' Else H.MessageInfo End, --ER0506
H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H 
inner join (select distinct Machineid,Max(RequestedTime) as RequestedTime from MessageHistory with (NOLOCK) --ER0377
group by  Machineid) M on M.Machineid=H.Machineid and M.RequestedTime=H.LastCallTime
where (H.ActionNo='01') and Datediff(s,RequestedTime,@Curtime)>H.Level3Threshold and H.CountOfRows=2 --and Datediff(s,RequestedTime,@Curtime)< H.Threshold+20


--2nd level Escalation for Ack
--Inserting when Machineid already exist in MessageHistory table but Timestamps are different and CountofRow in MessageHistory should be less than 1. 
--and If Lastaction is "Initiated" and Escalated i.e CountofRows in MessageHistory = "3" then send Message to Level2MobNos when Actioninfo="Ack"
 Insert into #FinalHelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,MobileNo,MessageInfo,Helpcode,ActionNo,Remarks)
--select H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level2MobNo,H.MessageInfo,H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H --ER0506
select H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level2MobNo,
case when @MsgFormat=1 then 'Since ' + cast(H.Level2Threshold/60 as nvarchar(10)) + ' mins ' + H.Machineid + ' Machine is not been addressed by the ' + H.HelpDescription + ' in charge.please take necessary action.' Else H.MessageInfo End, --ER0506
H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H 
inner join ( Select T1.Machineid,T1.Requestedtime,M.Actionno,Count(*) as Countofaction from 
 (Select M.Machineid,MAX(M.Requestedtime) as Requestedtime from MessageHistory M with (NOLOCK) Group by M.Machineid)T1  --ER0377
 inner join MessageHistory M on T1.Machineid=M.Machineid and T1.RequestedTime=M.RequestedTime
 group by  T1.Machineid,T1.Requestedtime,M.Actionno) M on M.Machineid=H.Machineid and M.RequestedTime = H.LastCallTime 
 and  (M.Actionno='02' and M.Countofaction=1) and (Datediff(s,LastCallTime,@Curtime)>H.Level2Threshold and Datediff(s,LastCallTime,@Curtime)<H.Level3Threshold)
 and isnull(H.CountOfRows,0)=1 and H.Actionno='02' 

 --3rd level Escalation for Ack
--Inserting when Machineid already exist in MessageHistory table but Timestamps are different and CountofRow in MessageHistory should be less than 1. 
--and If Lastaction is "Initiated" and Escalated i.e CountofRows in MessageHistory = "3" then send Message to Level2MobNos when Actioninfo="Ack"
 Insert into #FinalHelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,MobileNo,MessageInfo,Helpcode,ActionNo,Remarks)
--select H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level3MobNo,H.MessageInfo,H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H --ER0506
select H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level3MobNo,
case when @MsgFormat=1 then 'Since ' + cast(H.Level3Threshold/60 as nvarchar(10))+ ' mins ' + H.Machineid + ' Machine is not been addressed by the ' + H.HelpDescription + ' in charge.please take necessary action.' Else H.MessageInfo End, --ER0506
H.Helpcode,H.ActionNo,H.Remarks from #HelpCode H --ER0506
inner join ( Select T1.Machineid,T1.Requestedtime,M.Actionno,Count(*) as Countofaction from 
 (Select M.Machineid,MAX(M.Requestedtime) as Requestedtime from MessageHistory M with (NOLOCK) Group by M.Machineid)T1  --ER0377
 inner join MessageHistory M on T1.Machineid=M.Machineid and T1.RequestedTime=M.RequestedTime
 group by  T1.Machineid,T1.Requestedtime,M.Actionno) M on M.Machineid=H.Machineid and M.RequestedTime = H.LastCallTime 
 and  (M.Actionno='02' and M.Countofaction=2) and (Datediff(s,LastCallTime,@Curtime)>H.Level3Threshold)
 and isnull(H.CountOfRows,0)=2 and H.Actionno='02' 


--escalate for reset
create table #MobileNo
(
Machineid nvarchar(50),
Helpcode nvarchar(50),
Raisedtime datetime,
MobileNo nvarchar(4000)
)

create table #MobileNo1
(
Machineid nvarchar(50),
Helpcode nvarchar(50),
Raisedtime datetime,
MobileNo nvarchar(4000)
)

create table #MobileNo2
(
Machineid nvarchar(50),
Helpcode nvarchar(50),
Raisedtime datetime,
MobileNo nvarchar(4000)
)

insert into #MobileNo
Select distinct Machineid,Helpcode,Raisedtime,MobileNo from #HelpCode where actionno='03'
and isnull(CountOfRows,0)=0

--Commented for GEA  --ER0506 from here
--insert into #MobileNo
--SELECT distinct t.MachineID,t.Helpcode,t.Raisedtime,M.MobileNo 
--FROM MessageHistory M with (NOLOCK) 
--inner join #HelpCode T on M.MachineID = t.MachineID and M.starttime = t.raisedtime and M.Helpcode = t.Helpcode
--where T.actionno='03' and isnull(T.CountOfRows,0)=0 
--and M.MobileNo<>T.MobileNo
--Commented for GEA  --ER0506 till here

insert into #MobileNo1(Machineid,Helpcode,Raisedtime,MobileNo)
SELECT a.MachineID,a.Helpcode,a.Raisedtime,
     Split.a.value('.', 'VARCHAR(100)') AS String  
 FROM  (SELECT MachineID, Helpcode, Raisedtime,
         CAST ('<M>' + REPLACE(MobileNo , ',', '</M><M>') + '</M>' AS XML) AS String  
     FROM  #MobileNo) AS A CROSS APPLY String.nodes ('/M') AS Split(a);

	

insert into #MobileNo2(Machineid,Raisedtime,Helpcode,MobileNo)
SELECT t.MachineID,t.Raisedtime , t.Helpcode,   
      STUFF(ISNULL((SELECT distinct ' , ' + M.MobileNo 
      FROM #MobileNo1 M     
        WHERE M.MachineID = t.MachineID and M.raisedtime = t.raisedtime and M.Helpcode = t.Helpcode
     GROUP BY M.MobileNo
      FOR XML PATH (''), TYPE).value('.','nVARCHAR(max)'), ''), 1, 2, '')           
    FROM #MobileNo1 t group by t.MachineID,t.Raisedtime , t.Helpcode


update #FinalHelpCode set Raisedtime = T.Raisedtime from
(select machineid,Raisedtime,LastCallTime from #HelpCode)T inner join #FinalHelpCode F on T.Machineid=F.Machineid and T.LastCallTime = F.LastCallTime


update #FinalHelpCode set Mobileno = T.Mobileno from
(select distinct Machineid,Raisedtime,MobileNo,Helpcode from #MobileNo2)t inner join #FinalHelpCode on 
#FinalHelpCode.MachineID = t.MachineID and #FinalHelpCode.raisedtime = t.raisedtime and #FinalHelpCode.Helpcode = t.Helpcode
where #FinalHelpCode.ActionNo='03'
----ER0458 Till Here

/*--ER0458 Commented and added at the top
--Escalation for RESET
--Inserting when Machineid already exist in MessageHistory table but Timestamps are different and CountofRow in MessageHistory should be less than 1. 
--and If Lastaction is "Initiated" and Escalated i.e CountofRows in MessageHistory = "2" then send Message to Level2MobNos when Actioninfo="RESET"
 Insert into #FinalHelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,MobileNo,MessageInfo,Helpcode,ActionNo)
select H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level2MobNo,H.MessageInfo,H.Helpcode,H.ActionNo from #HelpCode H
inner join ( Select T1.Machineid,T1.Requestedtime,M.Actionno,Count(*) as Countofaction from 
 (Select M.Machineid,MAX(M.Requestedtime) as Requestedtime from MessageHistory M with (NOLOCK) Group by M.Machineid)T1  --ER0377
 inner join MessageHistory M on T1.Machineid=M.Machineid and T1.RequestedTime=M.RequestedTime
 group by  T1.Machineid,T1.Requestedtime,M.Actionno) M on M.Machineid=H.Machineid and M.RequestedTime <> H.LastCallTime 
 and isnull(H.CountOfRows,0)<1 and H.ActionInfo='Reset' and M.Actionno='01' and M.Countofaction=2

 --To avoid Duplicates when action'Reset'
 --i.e Machine already present with Same Timestamp for the action 'Reset' then CountofRows should be 'Zero'.
Insert into #FinalHelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,Mobileno,MessageInfo,Helpcode,ActionNo)
select  H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.MobileNo,H.MessageInfo,H.Helpcode,H.ActionNo from #HelpCode H
inner join (select distinct Machineid,Max(RequestedTime) as RequestedTime from MessageHistory with (NOLOCK) --ER0377
group by  Machineid) M on M.Machineid=H.Machineid and M.RequestedTime = H.LastCallTime
where H.ActionInfo='Reset' and isnull(H.CountOfRows,0) = 0


--To handle duplicates and Escalation for action 'Initiated' 
--i.e Machine already present with Same Timestamp for the action not equal to 'Reset' then CountofRows=1 then send message to Level2MobNos.
Insert into #FinalHelpCode (Plantid,Machineid,HelpDescription,ActionInfo,LastCallTime,Mobileno,MessageInfo,Helpcode,ActionNo)
select  H.Plantid,H.Machineid,H.HelpDescription,H.ActionInfo,H.LastCallTime,H.Level2MobNo,H.MessageInfo,H.Helpcode,H.ActionNo from #HelpCode H
inner join (select distinct Machineid,Max(RequestedTime) as RequestedTime from MessageHistory with (NOLOCK) --ER0377
group by  Machineid) M on M.Machineid=H.Machineid and M.RequestedTime=H.LastCallTime
where H.ActionInfo<>'Reset' and Datediff(s,RequestedTime,@Curtime)>H.Threshold and H.CountOfRows<2 --and Datediff(s,RequestedTime,@Curtime)< H.Threshold+20
*/

Select @j=Count(*) from #FinalHelpcode
select @i = 1


If @j <> 0
BEGIN

	While @i<=@j
	BEGIN

		Select @Reqtime = LastCallTime from #FinalHelpCode where slno = @i
	
		select @logicalstartdate = dbo.f_GetLogicalDayStart(@Reqtime)

		Insert into #CurrentShift(Startdate,shiftname,Starttime,Endtime)
		exec [s_GetShiftTime] @logicalstartdate,''

		update #CurrentShift set shiftid = T1.shiftid
		from( select shiftid,shiftname from shiftdetails where running=1)T1
		inner join #CurrentShift on #CurrentShift.shiftname=T1.shiftname

		Update #FinalHelpCode set Shiftid = Isnull(#FinalHelpCode.shiftid,0) + isnull(T1.shiftid,0) from
		(select TOP 1 * from #CurrentShift where @Reqtime>=starttime and @Reqtime<=endtime
		 ORDER BY STARTTIME ASC) T1 where slno=@i

		select @Reqtime = ''
		select @i = @i + 1

	END
END

--Update #FinalHelpCode set Helpcode = Case when HelpDescription='Material' THEN '01'
--WHEN HelpDescription='Maintenance' THEN '02'
--WHEN HelpDescription='Inspection' THEN '03'
--WHEN HelpDescription='Supervision' THEN '04'
--eND

--Update #FinalHelpCode set ActionNo = Case when ActionInfo='Initiated' THEN '01'
--WHEN ActionInfo='Acknowledged' THEN '02'
--WHEN ActionInfo='Reset' THEN '03'
--WHEN ActionInfo='Completed' THEN '04'
--eND


If @MsgFormat=1
BEGIN
	Insert into Messagehistory(StartTime,Requestedtime,Msgstatus,MobileNo,Message,Machineid,shiftid,ActionNo,HelpCode)
	select Raisedtime,LastCallTime,0,MobileNo,MessageInfo,
	Machineid,shiftid,ActionNo,HelpCode from #FinalHelpCode Order by LastCallTime
END
ELSE
BEGIN
	Insert into Messagehistory(StartTime,Requestedtime,Msgstatus,MobileNo,Message,Machineid,shiftid,ActionNo,HelpCode)
	select Raisedtime,LastCallTime,0,MobileNo 
	,case when isnull(Remarks,'')<>'' then 'TPM-Trak Msg From Machine  ' + Machineid + ' : ' + MessageInfo + ' ' + Remarks + ' ' + Convert(nvarchar(20),LastCallTime,100)
	else 'TPM-Trak Msg From Machine  ' + Machineid + ' : ' + MessageInfo + ' ' + Convert(nvarchar(20),LastCallTime,100) end,
	Machineid,shiftid,ActionNo,HelpCode from #FinalHelpCode Order by LastCallTime
END



End 
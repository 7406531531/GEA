/****** Object:  Procedure [dbo].[s_GenerateRunningSchedules_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/**********************************************************************************
SwathiKS For GEA To calculate Machinewise ActualStarttime and TentativeEndtime
****************************************************************************************************/

CREATE PROCEDURE [dbo].[s_GenerateRunningSchedules_GEA]

AS
BEGIN

CREATE TABLE #MachineRunningStatus
(
	MachineID NvarChar(50),
	MachineInterface nvarchar(50),
	sttime Datetime,
	ndtime Datetime,
	DataType smallint,
	Comp NvarChar(50), 
	Opn NvarChar(50),
	StartTime datetime, 
	Downtime float, 
	Totaltime int, 
	ManagementLoss float, 
	UT float,
	PDT float,
	LastRecorddatatype int, 
	AutodataMaxtime datetime,
	Stdtime float,
	RunningCompOpn nvarchar(100),
	ActualStarttime datetime,
	TentativeEndtime datetime,
	CycleRuntime float
)

Create table #AE  
(  
mc nvarchar(50),  
dcode nvarchar(50),  
sttime datetime,  
ndtime datetime,  
Loadunload float,  
CycleStart datetime,  
CycleEnd datetime,  
TotalTime float,  
UT float,  
Downtime float,  
PDT float,  
ManagementLoss float,  
MLDown float,  
id bigint,  
datatype nvarchar(50)
)  

Create table #PlannedDownTimes
(
	MachineID nvarchar(50) NOT NULL, 
	MachineInterface nvarchar(50) NOT NULL,
	StartTime DateTime NOT NULL,
	EndTime DateTime NOT NULL
)  

ALTER TABLE #PlannedDownTimes
ADD PRIMARY KEY CLUSTERED
	(   [MachineInterface],
		[StartTime],
		[EndTime]
						
	) ON [PRIMARY]

	
create table #PDT
(
machine nvarchar(50),
StartTime datetime
)

create table #Timeinfo
(
id int identity(1,1) NOT NULL,
machine nvarchar(50),
StartTime datetime,
endtime datetime,
ISICD int
)

create table #Scheduler
(
IDD bigint identity(1,1),
Machineid nvarchar(50),
PONumber nvarchar(50),
MaterialID nvarchar(50),
OpnNo nvarchar(50),
ScheduleStart datetime,
ScheduleEnd datetime,
SCHPriority int,
stdcycletime float,
StdSetupTime float,
SCHStatus nvarchar(50),
ActualStarttime datetime,
TentativeEndtime datetime,
CycleRuntime float
)


Declare @CurrTime as DateTime
SET @CurrTime = convert(nvarchar(20),getdate(),120)


Declare @Type40Threshold int
Declare @Type1Threshold int
Declare @Type11Threshold int

Set @Type40Threshold =0
Set @Type1Threshold = 0
Set @Type11Threshold = 0

Set @Type40Threshold = (Select isnull(Valueintext2,5)*60 from shopdefaults where parameter='ANDONStatusThreshold' and valueintext = 'Type40Threshold')
Set @Type1Threshold = (Select isnull(Valueintext2,5)*60 from shopdefaults where parameter='ANDONStatusThreshold' and valueintext = 'Type1Threshold')
Set @Type11Threshold = (Select isnull(Valueintext2,5)*60 from shopdefaults where parameter='ANDONStatusThreshold' and valueintext = 'Type11Threshold')
  
---Query to get Machinewise Last Record from Rawdata where Datatype in 11  
Insert into #machineRunningStatus(MachineID,MachineInterface,AutodataMaxtime,sttime,DataType,Comp,Opn,Totaltime,Downtime,UT,Stdtime)  
select M.MachineID,M.InterfaceID,A.Endtime,sttime,datatype,comp,opn,0,0,0,COP.Cycletime from rawdata  
inner join (select mc,max(slno) as slno from rawdata WITH (NOLOCK)   
left join Autodata_maxtime A on rawdata.mc=A.machineid where (Rawdata.sttime>A.Endtime and Rawdata.sttime<@currtime) and rawdata.datatype=11 group by mc  ) t1   
on t1.mc=rawdata.mc and t1.slno=rawdata.slno  
left join Autodata_maxtime A on rawdata.mc=A.machineid
inner join machineinformation M on M.InterfaceID=t1.mc  
inner join componentinformation C on C.InterfaceID=RawData.Comp
inner join componentoperationpricing COP on M.Machineid=COP.machineid and C.componentid=COP.componentid and RawData.Opn=COP.operationno
inner join RunningScheduleDetails_GEA R on R.Machineid=COP.machineid and R.MaterialID=COP.componentid and R.OperationNo=COP.operationno and R.ProductionOrder=RawData.WorkOrderNumber
and isnull(R.FabricationNo,'a')=isnull(RawData.SPLString3,'a') AND ISNULL(R.GrnNo,'')=ISNULL(RawData.SPLString4,'')
where (Rawdata.sttime>A.Endtime and Rawdata.sttime<@currtime) and rawdata.datatype=11  and ISNULL(M.Process,'') not in('Assembly','Packing','Testing')
order by rawdata.mc  

---Query to get Machinewise Last Record from Rawdata where Datatype in 11  
Insert into #machineRunningStatus(MachineID,MachineInterface,AutodataMaxtime,sttime,DataType,Comp,Opn,Totaltime,Downtime,UT,Stdtime)  
select M.MachineID,M.InterfaceID,A.Endtime,sttime,datatype,comp,opn,0,0,0,sum(AM.StdCycletime) from rawdata  
inner join (select mc,max(slno) as slno from rawdata WITH (NOLOCK)   
left join Autodata_maxtime A on rawdata.mc=A.machineid where (Rawdata.sttime>A.Endtime and Rawdata.sttime<@currtime) and rawdata.datatype=11 group by mc  ) t1   
on t1.mc=rawdata.mc and t1.slno=rawdata.slno  
left join Autodata_maxtime A on rawdata.mc=A.machineid
inner join machineinformation M on M.InterfaceID=t1.mc  
inner join componentinformation C on C.InterfaceID=RawData.Comp
inner join componentoperationpricing COP on M.Machineid=COP.machineid and C.componentid=COP.componentid and RawData.Opn=COP.operationno
inner join RunningScheduleDetails_GEA R on R.Machineid=COP.machineid and R.MaterialID=COP.componentid and R.OperationNo=COP.operationno and R.ProductionOrder=RawData.WorkOrderNumber
and isnull(R.FabricationNo,'a')=isnull(RawData.SPLString3,'a')
inner join AssemblyActivitySchedules_GEA AR on R.Machineid=AR.machineid and R.MaterialID=AR.MaterialID and R.OperationNo=AR.operationno and R.ProductionOrder=AR.ProductionOrder 
AND R.FabricationNo=AR.FabricationNo
inner join AssemblyActivityMaster_GEA AM on AR.Machineid=AM.Station and AR.activity=AM.Activity and AR.MaterialID=AM.Componentid
where (Rawdata.sttime>A.Endtime and Rawdata.sttime<@currtime) and rawdata.datatype=11  and M.Process in('Assembly','Packing','Testing')
group by M.MachineID,M.InterfaceID,A.Endtime,sttime,datatype,comp,opn

IF (Select isnull(valueintext2,'N') from ShopDefaults where Parameter='Cockpit_RunningCycleUT')='Y'
Begin
Update #machineRunningStatus set UT=ISNULL(T1.UT,0),Downtime=ISNULL(T1.Dt,0) from  
(Select MachineInterface,case when AutodataMaxtime<sttime then (O.cycletime-O.machiningtime) end as UT,  
case when dateadd(second,(O.cycletime-O.machiningtime),AutodataMaxtime)<sttime then datediff(second,dateadd(second,(O.cycletime-O.machiningtime),AutodataMaxtime),sttime) end as DT   
from #MachineRunningStatus  
inner join machineinformation M on #MachineRunningStatus.MachineInterface=M.InterfaceID   
inner join componentinformation C on C.InterfaceID=#MachineRunningStatus.Comp  
inner join componentoperationpricing O on O.componentid=C.componentid and M.machineid=O.machineid and   
#MachineRunningStatus.Opn=O.InterfaceID)T1 inner join #machineRunningStatus on T1.MachineInterface=#machineRunningStatus.MachineInterface  
End

Update #machineRunningStatus set ndtime = case when T1.Endtime>@CurrTime then @CurrTime else T1.Endtime end,LastRecorddatatype=T1.LastRecorddatatype from  
(select rawdata.mc,rawdata.datatype,case when rawdata.datatype=40 then dateadd(second,@type40threshold,rawdata.sttime)  
when rawdata.datatype=42 then dateadd(second,@type40threshold,rawdata.Ndtime)  
when rawdata.datatype=41 then rawdata.sttime  
when rawdata.datatype=11 then dateadd(second,@type11threshold,rawdata.sttime)   
else @CurrTime end as endtime,  
case when rawdata.datatype in(40,41,42) then RawData.DataType   
else 11 end as LastRecorddatatype from  
 (  
  select rawdata.mc,max(rawdata.slno) as slno from rawdata   
  inner join #machineRunningStatus M on M.MachineInterface=rawdata.mc  
  where rawdata.datatype in(40,41,42,11) and (rawdata.sttime>=M.sttime and ISNULL(Rawdata.ndtime,Rawdata.sttime)<@currtime)  group by rawdata.mc  
 )T1  inner join rawdata on rawdata.slno=t1.slno  
 inner join #machineRunningStatus M on M.MachineInterface=rawdata.mc  
)T1 inner join #machineRunningStatus on #machineRunningStatus.MachineInterface=T1.mc 

update  #machineRunningStatus set ndtime=@CurrTime,LastRecorddatatype=11 where ndtime IS NULL  

update #machineRunningStatus set UT=Datediff(second,sttime,ndtime),Totaltime=Datediff(second,sttime,ndtime)  --for L&T


Insert into #AE(mc,dcode,sttime,ndtime,Loadunload,CycleStart,CycleEnd,TotalTime,UT,Downtime,PDT,ManagementLoss,MLDown,id,datatype)  
Select M.MachineInterface,A.dcode,A.sttime,A.ndtime,A.Loadunload,M.sttime,M.ndtime,M.Totaltime,0,0,0,0,0,A.id,A.datatype from Autodata_ICD A  
right outer join #machineRunningStatus M On A.mc=M.MachineInterface  
Where A.sttime>=M.sttime and A.ndtime<=M.ndtime  
and M.datatype='11' and A.datatype='42' Order by A.mc,A.sttime  

insert into #PDT(machine,StartTime)
select MachineInterface,sttime from #MachineRunningStatus where DataType=11

insert into #PDT(machine,StartTime)
select mc,sttime from #AE

insert into #PDT(machine,StartTime)
select mc,ndtime from #AE 

insert into #PDT(machine,StartTime)
select mc,CycleEnd from #AE where CycleEnd>(select max(ndtime) from #AE)

insert into #Timeinfo(machine,StartTime,endtime,ISICD)
select t1.machine,t1.StartTime,LEAD(t1.StartTime)OVER(ORDER BY starttime) as endtime,0 from #PDT t1

update #Timeinfo set ISICD=1 where endtime in(select ndtime from #AE)

IF EXISTS(select * from #AE where datatype=42)  
Begin  

	--update #machineRunningStatus set Totaltime=Datediff(second,sttime,ndtime)  --for L&T

	If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='N' or ((SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'N' and (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'Y')  
	BEGIN  
	  UPDATE #AE SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)  
	  from  
	  (select mc,sttime,  
	  CASE  
	  WHEN Datediff(second,sttime,ndtime) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0  
	  THEN isnull(downcodeinformation.Threshold,0)  
	  ELSE Datediff(second,sttime,ndtime)  
	  END AS LOSS from #AE autodata    
	  INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid  
	  where (autodata.datatype=42) and (downcodeinformation.availeffy = 1)  
	  ) as t2 inner join  #AE on t2.mc = #AE.mc and t2.sttime=#AE.Sttime  
  
	  UPDATE #AE SET downtime = isnull(downtime,0) + isNull(t2.down,0)  
	  from  
	  (select mc,Datediff(second,sttime,ndtime) AS down,sttime,ndtime  
	  from #AE autodata inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid  
	  ) as t2 inner join #AE on t2.mc = #AE.mc and t2.sttime=#AE.Sttime  
	END  

	Declare @strsql as nvarchar(max)
	SET @strSql = ''  
	SET @strSql = 'Insert into #PlannedDownTimes(machineid,machineinterface,starttime,endtime)  
	SELECT MachineInformation.Machineid,MachineInformation.InterfaceID,  
	CASE When StartTime<#AE.CycleStart Then #AE.CycleStart Else StartTime End As StartTime,  
	CASE When EndTime>#AE.CycleEnd Then #AE.CycleEnd Else EndTime End As EndTime  
	FROM PlannedDownTimes inner join MachineInformation on PlannedDownTimes.machine = MachineInformation.MachineID  
	inner join (Select distinct mc,CycleStart,CycleEnd from #AE) #AE on #AE.mc = MachineInformation.InterfaceID  
	WHERE PDTstatus =1 and(  
	(StartTime >= #AE.CycleStart AND EndTime <=#AE.CycleEnd)  
	OR ( StartTime < #AE.CycleStart  AND EndTime <= #AE.CycleEnd AND EndTime > #AE.CycleStart )  
	OR ( StartTime >= #AE.CycleStart   AND StartTime <#AE.CycleEnd AND EndTime > #AE.CycleEnd )  
	OR ( StartTime < #AE.CycleStart  AND EndTime > #AE.CycleEnd)) '  
	SET @strSql =  @strSql +  ' ORDER BY MachineInformation.Machineid,PlannedDownTimes.StartTime'  
	EXEC(@strSql)  
  
	If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='Y'  
	BEGIN  
  
  
	  UPDATE #AE SET downtime = isnull(downtime,0) + isNull(t2.down,0)  
	  from  
	  (select mc,Datediff(second,sttime,ndtime) AS down,sttime,ndtime  
	  from #AE autodata inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid  
	  where (downcodeinformation.availeffy = 0)  
	  ) as t2 inner join #AE on t2.mc = #AE.mc and t2.sttime=#AE.Sttime  
  
	  UPDATE #AE set DownTime =isnull(DownTime,0) - isNull(TT.PPDT ,0),PDT=isnull(PDT,0) + isNull(TT.PPDT ,0)  
	  FROM(  
	   --Down PDT  
	   SELECT autodata.MC,DownID,sttime, SUM  
		 (CASE  
		WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)  
		WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)  
		WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )  
		WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )  
		END ) as PPDT  
	   FROM #AE AutoData --ER0374  
	   CROSS jOIN #PlannedDownTimes T  
	   Inner Join DownCodeInformation On AutoData.DCode=DownCodeInformation.InterfaceID  
	   WHERE autodata.DataType=42 AND (downcodeinformation.availeffy = 0) AND  
	   T.MachineInterface = AutoData.mc And  
		(  
		(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)  
		OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )  
		OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )  
		OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)  
		)  
	   group by autodata.mc,DownID,sttime  
	  ) as TT INNER JOIN #AE ON TT.mc = #AE.mc and TT.sttime=#AE.Sttime  
  
  
	   UPDATE #AE SET  ManagementLoss = isnull(ManagementLoss,0) + isNull(t4.Mloss,0),MLDown=isNull(MLDown,0)+isNull(t4.Dloss,0),  
	   PDT=isnull(PDT,0) + isNull(t4.PPDT ,0)  
	   from  
	   (select T3.mc,T3.sttime,sum(T3.Mloss) as Mloss,sum(T3.Dloss) as Dloss,sum(T3.PPDT) as PPDT from (  
	   select T1.mc,T1.Threshold,T2.PPDT,T1.sttime,  
	   case when DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)> isnull(T1.Threshold ,0) and isnull(T1.Threshold ,0)>0  
	   then DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)- isnull(T1.Threshold ,0)  
	   else 0 End  as Dloss,  
	   case when DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)> isnull(T1.Threshold ,0) and isnull(T1.Threshold ,0)>0  
	   then isnull(T1.Threshold,0)  
	   else (DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)) End  as Mloss  
	   from  
  
	   (   
		select sttime,mc,D.threshold,ndtime  
		from #AE autodata --ER0374  
		inner join downcodeinformation D on autodata.dcode=D.interfaceid   
		where autodata.datatype=42 AND D.availeffy = 1     
	   ) as T1     
	   left outer join  
	   (  
		SELECT autodata.sttime,autodata.ndtime,autodata.mc,  
		 sum(CASE  
		WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)  
		WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)  
		WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )  
		WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )  
		END ) as PPDT  
		FROM #AE AutoData   
		CROSS jOIN #PlannedDownTimes T inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid  
		WHERE autodata.DataType=42 AND T.MachineInterface=autodata.mc AND  
		(  
		(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)  
		OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )  
		OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )  
		OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)  
		)  
		AND (downcodeinformation.availeffy = 1)   
		group  by autodata.sttime,autodata.ndtime,autodata.mc) as T2 on T1.mc=T2.mc and T1.sttime=T2.sttime) as T3  group by T3.mc,T3.sttime  
	   ) as t4 inner join #AE on t4.mc = #AE.mc and t4.sttime = #AE.sttime  
  
	   UPDATE #AE SET downtime = isnull(downtime,0)+isnull(ManagementLoss,0)+isNull(MLDown,0)  
  END  
  
  Update #MachineRunningStatus SET downtime = isnull(downtime,0)+ isnull(T1.down,0),ManagementLoss = isnull(ManagementLoss,0)+isnull(T1.ML,0),  
  --UT = ISNULL(UT,0)+ (ISNULL(Totaltime,0)-ISNULL(T1.down,0)), --For L&T
  UT = (ISNULL(UT,0)-(ISNULL(T1.down,0)+ ISNULL(T1.PDT,0))), --For L&T
  #MachineRunningStatus.PDT=ISNULL(#MachineRunningStatus.PDT,0)+ ISNULL(T1.PDT,0) from  
  (Select mc,Sum(ManagementLoss) as ML,Sum(Downtime) as Down,SUM(PDT) as PDT from #AE Group By mc)T1  
  inner join #MachineRunningStatus on T1.mc = #MachineRunningStatus.machineinterface  
  
END  

Update #MachineRunningStatus set UT = Isnull(#MachineRunningStatus.UT,0) + Isnull(t2.UT,0),StartTime=t2.endtime ,
 Downtime = Isnull(#MachineRunningStatus.Downtime,0) + Isnull(t2.Downtime,0)
from (  
Select mrs.MachineID,mrs.datatype,
case when t1.endtime<@CurrTime and (LastRecorddatatype in(40,42,11)) then datediff(second,t1.endtime,@CurrTime) else 0 end as Downtime,
case when t1.endtime<@CurrTime and (LastRecorddatatype=41) then datediff(second,t1.endtime,@CurrTime) else 0 end as UT,
case when t1.endtime<@CurrTime then t1.endtime else @CurrTime end as endtime  
from #machineRunningStatus mrs inner join  
(  
Select mrs.MachineID,case when mrs.LastRecorddatatype=11 then dateadd(second,@Type11Threshold,sttime) else mrs.ndtime end as endtime   
from #machineRunningStatus mrs  
Inner join Machineinformation M on M.interfaceID = mrs.MachineInterface  
) as t1 on t1.machineID = mrs.machineID   
) as t2 inner join #MachineRunningStatus on t2.MachineID = #MachineRunningStatus.MachineID   


If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Ptime_4m_PLD')='Y'   
BEGIN  

  update #MachineRunningStatus set UT = Isnull(#MachineRunningStatus.UT,0) - isnull(T2.PPDT,0),#MachineRunningStatus.PDT=ISNULL(#MachineRunningStatus.PDT,0)+isnull(T2.PPDT,0)
  from  
  (  
   select M.machineid,  
	sum(CASE  
	WHEN (T.Starttime >= pdt.Starttime AND T.Endtime <=pdt.EndTime)  THEN DateDiff(second,T.Starttime,T.EndTime ) 
	WHEN ( T.Starttime < pdt.Starttime AND T.Endtime <= pdt.EndTime  AND T.Endtime > pdt.Starttime ) THEN DateDiff(second,pdt.Starttime,T.Endtime)  
	WHEN ( T.Starttime >= pdt.Starttime AND T.Starttime <pdt.EndTime  AND T.Endtime > pdt.EndTime  ) THEN DateDiff(second,T.Starttime,pdt.EndTime )  
	WHEN ( T.Starttime < pdt.Starttime AND T.Endtime > pdt.EndTime ) THEN DateDiff(second,pdt.Starttime,pdt.EndTime )  
	END ) as PPDT  
   From Planneddowntimes pdt  
   inner join #machineRunningStatus M on M.machineid=Pdt.machine  
   inner join #Timeinfo T on M.MachineInterface=T.machine  
   where PDTstatus = 1 and  (T.ISICD=0 and T.endtime IS NOT NULL) and
   ((T.Starttime >= pdt.Starttime AND T.Endtime <=pdt.EndTime) or  
	(T.Starttime < pdt.Starttime AND T.Endtime <= pdt.EndTime  AND T.Endtime > pdt.Starttime)OR
	(T.Starttime >= pdt.Starttime AND T.Starttime <pdt.EndTime  AND T.Endtime > pdt.EndTime) OR   
	(T.Starttime < pdt.Starttime AND T.Endtime > pdt.EndTime))  
  group by M.machineid   
  )T2 inner join #MachineRunningStatus on #MachineRunningStatus.machineid=t2.machineid   

  update #MachineRunningStatus set UT = Isnull(#MachineRunningStatus.UT,0) - isnull(T2.PPDT,0),#MachineRunningStatus.PDT=ISNULL(#MachineRunningStatus.PDT,0)+isnull(T2.PPDT,0)
  from  
  (  
   select M.machineid,  
	sum(CASE  
	WHEN (T.Starttime >= pdt.Starttime AND T.Endtime <=pdt.EndTime)  THEN DateDiff(second,T.Starttime,T.EndTime ) 
	WHEN ( T.Starttime < pdt.Starttime AND T.Endtime <= pdt.EndTime  AND T.Endtime > pdt.Starttime ) THEN DateDiff(second,pdt.Starttime,T.Endtime)  
	WHEN ( T.Starttime >= pdt.Starttime AND T.Starttime <pdt.EndTime  AND T.Endtime > pdt.EndTime  ) THEN DateDiff(second,T.Starttime,pdt.EndTime )  
	WHEN ( T.Starttime < pdt.Starttime AND T.Endtime > pdt.EndTime ) THEN DateDiff(second,pdt.Starttime,pdt.EndTime )  
	END ) as PPDT  
   From Planneddowntimes pdt  
   inner join #machineRunningStatus M on M.machineid=Pdt.machine  
   inner join #Timeinfo T on M.MachineInterface=T.machine  
   where PDTstatus = 1 and  (T.ISICD=0 and T.endtime IS NULL) and (M.LastRecorddatatype=41) and
   ((T.Starttime >= pdt.Starttime AND T.Endtime <=pdt.EndTime) or  
	(T.Starttime < pdt.Starttime AND T.Endtime <= pdt.EndTime  AND T.Endtime > pdt.Starttime)OR
	(T.Starttime >= pdt.Starttime AND T.Starttime <pdt.EndTime  AND T.Endtime > pdt.EndTime) OR   
	(T.Starttime < pdt.Starttime AND T.Endtime > pdt.EndTime))  
  group by M.machineid   
  )T2 inner join #MachineRunningStatus on #MachineRunningStatus.machineid=t2.machineid   
end  

 If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='Y'   
BEGIN  
  update #MachineRunningStatus set Downtime = Isnull(#MachineRunningStatus.Downtime,0) - isnull(T2.PPDT,0),#MachineRunningStatus.PDT=ISNULL(#MachineRunningStatus.PDT,0)+isnull(T2.PPDT,0)
  from  
  (  
   select M.machineid,  
	sum(CASE  
	WHEN (T.Starttime >= pdt.Starttime AND T.Endtime <=pdt.EndTime)  THEN DateDiff(second,T.Starttime,T.EndTime ) 
	WHEN ( T.Starttime < pdt.Starttime AND T.Endtime <= pdt.EndTime  AND T.Endtime > pdt.Starttime ) THEN DateDiff(second,pdt.Starttime,T.Endtime)  
	WHEN ( T.Starttime >= pdt.Starttime AND T.Starttime <pdt.EndTime  AND T.Endtime > pdt.EndTime  ) THEN DateDiff(second,T.Starttime,pdt.EndTime )  
	WHEN ( T.Starttime < pdt.Starttime AND T.Endtime > pdt.EndTime ) THEN DateDiff(second,pdt.Starttime,pdt.EndTime )  
	END ) as PPDT  
   From Planneddowntimes pdt  
   inner join #machineRunningStatus M on M.machineid=Pdt.machine  
   inner join #Timeinfo T on M.MachineInterface=T.machine  
   where PDTstatus = 1 and (T.ISICD=0 and T.endtime IS NULL) and (M.LastRecorddatatype in(11,40,42)) and 
   ((T.Starttime >= pdt.Starttime AND T.Endtime <=pdt.EndTime) or  
	(T.Starttime < pdt.Starttime AND T.Endtime <= pdt.EndTime  AND T.Endtime > pdt.Starttime)OR
	(T.Starttime >= pdt.Starttime AND T.Starttime <pdt.EndTime  AND T.Endtime > pdt.EndTime) OR   
	(T.Starttime < pdt.Starttime AND T.Endtime > pdt.EndTime))  
  group by M.machineid   
  )T2 inner join #MachineRunningStatus on #MachineRunningStatus.machineid=t2.machineid   
 end  

UPDATE #MachineRunningStatus SET CycleRuntime=ISNULL(T.UT,0) from
(select MachineID,UT from #MachineRunningStatus)T inner join #MachineRunningStatus R on T.machineid=R.machineid
----------------------------------------------------------------------------------------------------------

update  #machineRunningStatus set ndtime=dateadd(second,stdtime,sttime),Downtime=0,ManagementLoss=0,PDT=0,UT=0--Reupdating to calculate TentativeEndtime

DELETE FROM #AE
DELETE FROM #PDT
DELETE FROM #Timeinfo
DELETE FROM #PlannedDownTimes

Insert into #AE(mc,dcode,sttime,ndtime,Loadunload,CycleStart,CycleEnd,TotalTime,UT,Downtime,PDT,ManagementLoss,MLDown,id,datatype)  
Select M.MachineInterface,A.dcode,A.sttime,A.ndtime,A.Loadunload,M.sttime,M.ndtime,M.Totaltime,0,0,0,0,0,A.id,A.datatype from Autodata_ICD A  
right outer join #machineRunningStatus M On A.mc=M.MachineInterface  
Where A.sttime>=M.sttime and A.ndtime<=M.ndtime  
and M.datatype='11' and A.datatype='42' Order by A.mc,A.sttime  


insert into #PDT(machine,StartTime)
select MachineInterface,sttime from #MachineRunningStatus where DataType=11

insert into #PDT(machine,StartTime)
select mc,sttime from #AE

insert into #PDT(machine,StartTime)
select mc,ndtime from #AE 

insert into #PDT(machine,StartTime)
select mc,CycleEnd from #AE where CycleEnd>(select max(ndtime) from #AE)

insert into #Timeinfo(machine,StartTime,endtime,ISICD)
select t1.machine,t1.StartTime,LEAD(t1.StartTime)OVER(ORDER BY starttime) as endtime,0 from #PDT t1

update #Timeinfo set ISICD=1 where endtime in(select ndtime from #AE)


IF EXISTS(select * from #AE where datatype=42)  
Begin  

	--update #machineRunningStatus set Totaltime=Datediff(second,sttime,ndtime)  --for L&T

	If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='N' or ((SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'N' and (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'Y')  
	BEGIN  
	  UPDATE #AE SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)  
	  from  
	  (select mc,sttime,  
	  CASE  
	  WHEN Datediff(second,sttime,ndtime) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0  
	  THEN isnull(downcodeinformation.Threshold,0)  
	  ELSE Datediff(second,sttime,ndtime)  
	  END AS LOSS from #AE autodata    
	  INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid  
	  where (autodata.datatype=42) and (downcodeinformation.availeffy = 1)  
	  ) as t2 inner join  #AE on t2.mc = #AE.mc and t2.sttime=#AE.Sttime  
  
	  UPDATE #AE SET downtime = isnull(downtime,0) + isNull(t2.down,0)  
	  from  
	  (select mc,Datediff(second,sttime,ndtime) AS down,sttime,ndtime  
	  from #AE autodata inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid  
	  ) as t2 inner join #AE on t2.mc = #AE.mc and t2.sttime=#AE.Sttime  
	END  


	SET @strSql = ''  
	SET @strSql = 'Insert into #PlannedDownTimes(machineid,machineinterface,starttime,endtime)  
	SELECT MachineInformation.Machineid,MachineInformation.InterfaceID,  
	CASE When P.StartTime<#AE.CycleStart Then #AE.CycleStart Else P.StartTime End As StartTime,  
	CASE When P.EndTime>#AE.CycleEnd Then #AE.CycleEnd Else EndTime End As EndTime  
	FROM PlannedDownTimes P inner join MachineInformation on P.machine = MachineInformation.MachineID  
	inner join (Select distinct mc,CycleStart,CycleEnd from #AE) #AE on #AE.mc = MachineInformation.InterfaceID  
	WHERE P.PDTstatus =1 and(  
	(P.StartTime >= #AE.CycleStart AND P.EndTime <=#AE.CycleEnd)  
	OR ( P.StartTime < #AE.CycleStart  AND P.EndTime <= #AE.CycleEnd AND P.EndTime > #AE.CycleStart )  
	OR ( P.StartTime >= #AE.CycleStart   AND P.StartTime <#AE.CycleEnd AND P.EndTime > #AE.CycleEnd )  
	OR ( P.StartTime < #AE.CycleStart  AND P.EndTime > #AE.CycleEnd)) '  
	SET @strSql =  @strSql +  ' ORDER BY MachineInformation.Machineid,P.StartTime'  
	print(@strsql)
	EXEC(@strSql)  

	If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='Y'  
	BEGIN  
  
  
	  UPDATE #AE SET downtime = isnull(downtime,0) + isNull(t2.down,0)  
	  from  
	  (select mc,Datediff(second,sttime,ndtime) AS down,sttime,ndtime  
	  from #AE autodata inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid  
	  where (downcodeinformation.availeffy = 0)  
	  ) as t2 inner join #AE on t2.mc = #AE.mc and t2.sttime=#AE.Sttime  
  
	  UPDATE #AE set DownTime =isnull(DownTime,0) - isNull(TT.PPDT ,0),PDT=isnull(PDT,0) + isNull(TT.PPDT ,0)  
	  FROM(  
	   --Down PDT  
	   SELECT autodata.MC,DownID,sttime, SUM  
		 (CASE  
		WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)  
		WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)  
		WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )  
		WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )  
		END ) as PPDT  
	   FROM #AE AutoData --ER0374  
	   CROSS jOIN #PlannedDownTimes T  
	   Inner Join DownCodeInformation On AutoData.DCode=DownCodeInformation.InterfaceID  
	   WHERE autodata.DataType=42 AND (downcodeinformation.availeffy = 0) AND  
	   T.MachineInterface = AutoData.mc And  
		(  
		(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)  
		OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )  
		OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )  
		OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)  
		)  
	   group by autodata.mc,DownID,sttime  
	  ) as TT INNER JOIN #AE ON TT.mc = #AE.mc and TT.sttime=#AE.Sttime  
  
  
	   UPDATE #AE SET  ManagementLoss = isnull(ManagementLoss,0) + isNull(t4.Mloss,0),MLDown=isNull(MLDown,0)+isNull(t4.Dloss,0),  
	   PDT=isnull(PDT,0) + isNull(t4.PPDT ,0)  
	   from  
	   (select T3.mc,T3.sttime,sum(T3.Mloss) as Mloss,sum(T3.Dloss) as Dloss,sum(T3.PPDT) as PPDT from (  
	   select T1.mc,T1.Threshold,T2.PPDT,T1.sttime,  
	   case when DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)> isnull(T1.Threshold ,0) and isnull(T1.Threshold ,0)>0  
	   then DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)- isnull(T1.Threshold ,0)  
	   else 0 End  as Dloss,  
	   case when DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)> isnull(T1.Threshold ,0) and isnull(T1.Threshold ,0)>0  
	   then isnull(T1.Threshold,0)  
	   else (DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)) End  as Mloss  
	   from  
  
	   (   
		select sttime,mc,D.threshold,ndtime  
		from #AE autodata --ER0374  
		inner join downcodeinformation D on autodata.dcode=D.interfaceid   
		where autodata.datatype=42 AND D.availeffy = 1     
	   ) as T1     
	   left outer join  
	   (  
		SELECT autodata.sttime,autodata.ndtime,autodata.mc,  
		 sum(CASE  
		WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)  
		WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)  
		WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )  
		WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )  
		END ) as PPDT  
		FROM #AE AutoData   
		CROSS jOIN #PlannedDownTimes T inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid  
		WHERE autodata.DataType=42 AND T.MachineInterface=autodata.mc AND  
		(  
		(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)  
		OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )  
		OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )  
		OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)  
		)  
		AND (downcodeinformation.availeffy = 1)   
		group  by autodata.sttime,autodata.ndtime,autodata.mc) as T2 on T1.mc=T2.mc and T1.sttime=T2.sttime) as T3  group by T3.mc,T3.sttime  
	   ) as t4 inner join #AE on t4.mc = #AE.mc and t4.sttime = #AE.sttime  
  
	   UPDATE #AE SET downtime = isnull(downtime,0)+isnull(ManagementLoss,0)+isNull(MLDown,0)  
  END  
  
  Update #MachineRunningStatus SET downtime = isnull(downtime,0)+ isnull(T1.down,0),ManagementLoss = isnull(ManagementLoss,0)+isnull(T1.ML,0),
  #MachineRunningStatus.PDT=ISNULL(#MachineRunningStatus.PDT,0)+ ISNULL(T1.PDT,0) from  
  (Select mc,Sum(ManagementLoss) as ML,Sum(Downtime) as Down,SUM(PDT) as PDT from #AE Group By mc)T1  
  inner join #MachineRunningStatus on T1.mc = #MachineRunningStatus.machineinterface  
  
END  

If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Ptime_4m_PLD')='Y'  
BEGIN  
  update #MachineRunningStatus set #MachineRunningStatus.PDT=ISNULL(#MachineRunningStatus.PDT,0)+isnull(T2.PPDT,0)
  from  
  (  
   select M.machineid,  
	sum(CASE  
	WHEN (T.Starttime >= pdt.Starttime AND T.Endtime <=pdt.EndTime)  THEN DateDiff(second,T.Starttime,T.EndTime ) 
	WHEN ( T.Starttime < pdt.Starttime AND T.Endtime <= pdt.EndTime  AND T.Endtime > pdt.Starttime ) THEN DateDiff(second,pdt.Starttime,T.Endtime)  
	WHEN ( T.Starttime >= pdt.Starttime AND T.Starttime <pdt.EndTime  AND T.Endtime > pdt.EndTime  ) THEN DateDiff(second,T.Starttime,pdt.EndTime )  
	WHEN ( T.Starttime < pdt.Starttime AND T.Endtime > pdt.EndTime ) THEN DateDiff(second,pdt.Starttime,pdt.EndTime )  
	END ) as PPDT  
   From Planneddowntimes pdt  
   inner join #machineRunningStatus M on M.machineid=Pdt.machine  
   inner join #Timeinfo T on M.MachineInterface=T.machine  
   where PDTstatus = 1 and (T.ISICD=0 and T.endtime IS NOT NULL) and
   ((T.Starttime >= pdt.Starttime AND T.Endtime <=pdt.EndTime) or  
	(T.Starttime < pdt.Starttime AND T.Endtime <= pdt.EndTime  AND T.Endtime > pdt.Starttime)OR
	(T.Starttime >= pdt.Starttime AND T.Starttime <pdt.EndTime  AND T.Endtime > pdt.EndTime) OR   
	(T.Starttime < pdt.Starttime AND T.Endtime > pdt.EndTime))  
  group by M.machineid   
  )T2 inner join #MachineRunningStatus on #MachineRunningStatus.machineid=t2.machineid  
END


UPDATE #MachineRunningStatus SET ActualStarttime=T.ActualStarttime,TentativeEndtime=T.TentativeEndtime from
(select MachineID,sttime as ActualStarttime,dateadd(second,(isnull(Stdtime,0)+isnull(downtime,0)+isnull(PDT,0)),sttime) as  TentativeEndtime  from #MachineRunningStatus)T inner join #MachineRunningStatus R on T.machineid=R.machineid

UPDATE RunningScheduleDetails_GEA SET ActualStarttime=T.ActualStarttime,TentativeEndtime=T.TentativeEndtime,CycleRuntime=T.CycleRuntime,UpdatedTS=getdate(),UpdatedBy='Service' from
(select MachineID,ActualStarttime,TentativeEndtime,CycleRuntime from #MachineRunningStatus)T inner join RunningScheduleDetails_GEA R on T.machineid=R.machineid

END
  
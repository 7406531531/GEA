/****** Object:  Procedure [dbo].[s_GenerateSchedules_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[s_GenerateSchedules_GEA]   '1','testing','2021-07-08 18:10:12.633'
CREATE  PROCEDURE [dbo].[s_GenerateSchedules_GEA]  
	@CalculatePlan NVARCHAR(50) ='',
	@Machineid NVARCHAR(50),
	@UserDefinedtime DATETIME=''
AS  
BEGIN  

DECLARE @strsql nvarchar(MAX)

create table #TempScheduler
(
IDD bigint identity(1,1),
Machineid nvarchar(50),
Process nvarchar(50),
PONumber nvarchar(50),
GrnNo NVARCHAR(50),
MaterialID nvarchar(50),
OpnNo nvarchar(50),
FabricationNo nvarchar(50),
ScheduleStart datetime,
ScheduleEnd datetime,
SCHPriority int,
stdcycletime float,
StdSetupTime float,
SCHStatus nvarchar(50),
ActualStarttime datetime,
TentativeEndtime datetime
)

create table #Scheduler
(
IDD bigint identity(1,1),
Machineid nvarchar(50),
Process nvarchar(50),
PONumber nvarchar(50),
GrnNo NVARCHAR(50),
MaterialID nvarchar(50),
FabricationNo nvarchar(50),
OpnNo nvarchar(50),
ScheduleStart datetime,
ScheduleEnd datetime,
SCHPriority int,
stdcycletime float,
StdSetupTime float,
SCHStatus nvarchar(50),
ActualStarttime datetime,
TentativeEndtime datetime
)

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
ISPDT int
)

create table #Timeinfo1
(
id int identity(1,1) NOT NULL,
machine nvarchar(50),
StartTime datetime,
endtime datetime,
ISPDT int
)

IF @CalculatePlan='1'  SELECT @CalculatePlan='RUNNING+NEW+PARKED+PRIORITYOrder'
IF @CalculatePlan='2'  SELECT @CalculatePlan='RUNNING+PRIORITYOrder'


if @CalculatePlan='RUNNING+NEW+PARKED+PRIORITYOrder'
Begin
	Insert into #TempScheduler(Machineid,process,SCHPriority,PONumber,GrnNo,MaterialID,Opnno,FabricationNo,stdcycletime,StdSetupTime,SCHStatus,ScheduleStart,ScheduleEnd,ActualStarttime,TentativeEndtime)
	Select S.Machineid,m.Process,S.SchedulePriority,S.ProductionOrder,s.GrnNo,S.MaterialID,S.OperationNo,S.FabricationNo,COP.cycletime,COP.StdSetupTime,S.Status,S.ScheduleStart,S.ScheduleEnd,R.ActualStarttime,R.TentativeEndtime
	From ScheduleDetails_GEA S 
	inner join machineinformation M on S.Machineid=M.machineid
	inner join componentinformation C on C.componentid=S.MaterialID
	inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
	inner join RunningScheduleDetails_GEA R on S.Machineid=R.machineid and S.MaterialID=R.MaterialID and S.OperationNo=R.operationno and S.ProductionOrder=R.ProductionOrder
	AND isnull(S.FabricationNo,'a')=isnull(R.FabricationNo,'a') AND ISNULL(s.GrnNo,'')=ISNULL(R.GrnNo,'')
	Where S.Machineid=@Machineid and S.status='Running'
	Order by S.SchedulePriority

	Insert into #TempScheduler(Machineid,process,SCHPriority,PONumber,GrnNo,MaterialID,Opnno,FabricationNo,stdcycletime,StdSetupTime,SCHStatus)
	Select S.Machineid,m.process,S.SchedulePriority,S.ProductionOrder,s.GrnNo,S.MaterialID,S.OperationNo,S.FabricationNo,COP.cycletime,COP.StdSetupTime,S.Status
	From ScheduleDetails_GEA S 
	inner join machineinformation M on S.Machineid=M.machineid
	inner join componentinformation C on C.componentid=S.MaterialID
	inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
	Where S.Machineid=@Machineid and S.status in ('New')
	Order by S.SchedulePriority

	INSERT INTO #TempScheduler(Machineid,process,SCHPriority,PONumber,GrnNo,MaterialID,Opnno,FabricationNo,stdcycletime,StdSetupTime,SCHStatus)
	SELECT S.Machineid,m.process,S.SchedulePriority,S.ProductionOrder,s.GrnNo, S.MaterialID,S.OperationNo,S.FabricationNo,COP.cycletime,COP.StdSetupTime,S.Status
	FROM ScheduleDetails_GEA S 
	INNER JOIN machineinformation M ON S.Machineid=M.machineid
	INNER JOIN componentinformation C ON C.componentid=S.MaterialID
	INNER JOIN componentoperationpricing COP ON S.Machineid=COP.machineid AND S.MaterialID=COP.componentid AND S.OperationNo=COP.operationno
	WHERE S.Machineid=@Machineid AND S.status='Parked'
	ORDER BY S.SchedulePriority
END
if @CalculatePlan='RUNNING+PRIORITYOrder'
Begin

	Insert into #TempScheduler(Machineid,Process,SCHPriority,PONumber,GrnNo,MaterialID,Opnno,FabricationNo,stdcycletime,StdSetupTime,SCHStatus,ScheduleStart,ScheduleEnd,ActualStarttime,TentativeEndtime)
	Select S.Machineid,m.process,S.SchedulePriority,S.ProductionOrder,s.GrnNo,S.MaterialID,S.OperationNo,S.FabricationNo,COP.cycletime,COP.StdSetupTime,S.Status,S.ScheduleStart,S.ScheduleEnd,R.ActualStarttime,R.TentativeEndtime
	From ScheduleDetails_GEA S 
	inner join machineinformation M on S.Machineid=M.machineid
	inner join componentinformation C on C.componentid=S.MaterialID
	inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
	inner join RunningScheduleDetails_GEA R on S.Machineid=R.machineid and S.MaterialID=R.MaterialID and S.OperationNo=R.operationno and S.ProductionOrder=R.ProductionOrder
	AND isnull(S.FabricationNo,'a')=isnull(R.FabricationNo,'a') AND ISNULL(s.GrnNo,'')=ISNULL(R.GrnNo,'')
	Where S.Machineid=@Machineid and S.status='Running'
	Order by S.SchedulePriority

	INSERT INTO #TempScheduler(Machineid,Process,SCHPriority,PONumber,GrnNo,MaterialID,Opnno,FabricationNo,stdcycletime,StdSetupTime,SCHStatus)
	SELECT S.Machineid,m.Process,S.SchedulePriority,S.ProductionOrder,s.GrnNo,S.MaterialID,S.OperationNo,S.FabricationNo,COP.cycletime,COP.StdSetupTime,S.Status
	FROM ScheduleDetails_GEA S 
	INNER JOIN machineinformation M ON S.Machineid=M.machineid
	INNER JOIN componentinformation C ON C.componentid=S.MaterialID
	INNER JOIN componentoperationpricing COP ON S.Machineid=COP.machineid AND S.MaterialID=COP.componentid AND S.OperationNo=COP.operationno
	WHERE S.Machineid=@Machineid AND S.status IN ('New','Parked')
	ORDER BY S.SchedulePriority
END

Declare @CountOfSchedules as int,@j as int
Declare @TargetFinishtime as datetime
declare @i as int,@count as int,@TargetHours float,@Diff as float,@CumulativeDiff as float
declare @MINStarttime as datetime
declare @PrevPONo as nvarchar(50),@PrevMaterial as nvarchar(50),@PrevOpnNo as nvarchar(50),@PrevFabricationNo as nvarchar(50),@prevGrnNo AS NVARCHAR(50)
declare @currentPONo as nvarchar(50),@CurrentMaterial as nvarchar(50),@CurrentOpnNo as nvarchar(50),@CurrentFabricationNo as nvarchar(50),@CurrentGrnNo as nvarchar(50)
declare @Starttime as datetime
declare @NonPDTStarttime as datetime --Swathi added on 26/07/2021

select @j=1


--select @Starttime=isnull(ScheduleStart,getdate()),@PrevPONo=PONumber,@PrevMaterial=MaterialID,@PrevOpnNo=OpnNo from #Scheduler where idd=@j
select @Starttime=ISNULL(max(TentativeEndtime),'1900-01-01') from #TempScheduler where SCHStatus='Running'


If @Starttime<>'1900-01-01' 
BEGIN
  Select @Starttime=case when @UserDefinedtime<>'' and @Starttime>@UserDefinedtime then @Starttime 
  when @UserDefinedtime<>'' and @Starttime<@UserDefinedtime then @UserDefinedtime 
  when @UserDefinedtime='' then @Starttime  end

  INSERT INTO #Scheduler(Machineid,Process,SCHPriority,PONumber,GrnNo,MaterialID,Opnno,FabricationNo,stdcycletime,StdSetupTime,SCHStatus,ScheduleStart,ScheduleEnd) 
 SELECT Machineid,Process,SCHPriority,PONumber,GrnNo,MaterialID,Opnno,FabricationNo,stdcycletime,StdSetupTime,SCHStatus,ScheduleStart,ScheduleEnd FROM #TempScheduler 
 WHERE SCHStatus<>'Running' ORDER BY idd
END

If @Starttime='1900-01-01'
BEGIN
 select @Starttime=case when @UserDefinedtime='' then getdate() else @UserDefinedtime end

 INSERT INTO #Scheduler(Machineid,Process,SCHPriority,PONumber,GrnNo,MaterialID,Opnno,FabricationNo,stdcycletime,StdSetupTime,SCHStatus) 
 SELECT Machineid,Process,SCHPriority,PONumber,GrnNo,MaterialID,Opnno,FabricationNo,stdcycletime,StdSetupTime,SCHStatus FROM #TempScheduler ORDER BY idd
END

Update #Scheduler set stdcycletime=ISNULL(T.Cycletime,0),StdSetupTime=ISNULL(T.StdSetupTime,0) from
(SELECT S.Machineid,S.PONumber,S.MaterialID,S.Opnno,S.FabricationNo,SUM(M.stdcycletime) as Cycletime,SUM(M.StdSetupTime) as StdSetupTime from #Scheduler S
inner join AssemblyActivitySchedules_GEA R on S.Machineid=R.machineid and S.MaterialID=R.MaterialID and S.OpnNo=R.operationno and S.PONumber=R.ProductionOrder AND S.FabricationNo=R.FabricationNo
inner join AssemblyActivityMaster_GEA M on R.Machineid=M.Station and R.activity=M.Activity and R.MaterialID=M.Componentid
where S.Process in('Assembly','Packing','Testing')
group by S.Machineid,S.PONumber,S.MaterialID,S.Opnno,S.FabricationNo
)T inner join #Scheduler S on S.Machineid=T.machineid and S.MaterialID=T.MaterialID and S.OpnNo=T.OpnNo and S.PONumber=T.PONumber AND S.FabricationNo=T.FabricationNo 
where S.Process in('Assembly','Packing','Testing')

select @CountOfSchedules=count(*) from #Scheduler

----Added on 04/06/2021 From here  --Swathi commented on 26/07/2021
--IF EXISTS(select * from PlannedDownTimes where Machine=@Machineid and (@Starttime between starttime and Endtime))
--Begin
-- select @Starttime=MIn(endtime) from PlannedDownTimes where Machine=@Machineid and endtime>=@Starttime
--End
----Added on 04/06/2021 till here  --Swathi commented on 26/07/2021


WHILE @j<=@CountOfSchedules
BEGIN


		IF EXISTS(SELECT * FROM PlannedDownTimes WHERE Machine=@Machineid AND starttime>=@Starttime)
		BEGIN

				insert into #PDT(machine,StartTime)
				select machine,starttime from PlannedDownTimes where Machine=@Machineid
				and starttime>=@Starttime

				select @MINStarttime=MIn(starttime) from #PDT


				IF @MINStarttime>@Starttime 
				Begin
					insert into #PDT(machine,StartTime)
					select @Machineid,@Starttime
				END


				insert into #PDT(machine,StartTime)
				select machine,endtime from PlannedDownTimes where Machine=@Machineid
				and starttime>=@Starttime

				insert into #Timeinfo1(StartTime,endtime,ISPDT)
				select t1.starttime,LEAD(t1.starttime)OVER(ORDER BY starttime) as endtime,0 from #PDT t1

				--update #Timeinfo1 set ISPDT=1 where endtime in(select endtime from PlannedDownTimes where Machine=@Machineid
				--and starttime>=@Starttime) --Swathi commented on 26/07/2021

				update #Timeinfo1 set ISPDT=1 where endtime in(select endtime from PlannedDownTimes where Machine=@Machineid
				and Endtime>=@Starttime) --Swathi added on 26/07/2021


				select @i=0,@count=0
				SET @i=(Select TOP 1 id from #Timeinfo1 where ISPDT=0 order by id)
				select @count=max(id) from #Timeinfo1 
				select @NonPDTStarttime=(Select starttime from #Timeinfo1 where id=@i)

				--Swathi added on 26/07/2021
				IF EXISTS(select * from #timeinfo1 where (@starttime between starttime and endtime) and @StartTime<=@NonPDTStarttime)
				Begin
					Select @Starttime=@NonPDTStarttime
				End
				--Swathi added on 26/07/2021

				Select @CumulativeDiff=datediff(second,starttime,Endtime) from #Timeinfo1 where ISPDT=0 and id=@i --Added on 04/06/2021
				select @TargetHours=stdcycletime from #Scheduler where idd=@j 
				Select @Diff=0

						WHILE @i<=@count
						BEGIN
			
							--Select @Diff=datediff(second,starttime,case when ISNULL(endtime,'1900-01-01')='1900-01-01' then dateadd(second,(@TargetHours-ISNULL(@CumulativeDiff,0)),starttime) Else Endtime END) 
							--from #Timeinfo1 where ISPDT=0 and id=@i --Commented on 04/06/2021

							--If @Diff>@TargetHours  --commented on 04/06/2021
							IF @CumulativeDiff>@TargetHours --Added on 04/06/2021
							BEGIN
								SELECT @TargetFinishtime =CASE 
								--when @TargetHours-ISNULL(@CumulativeDiff,0)>=0 then dateadd(second,(@TargetHours-ISNULL(@CumulativeDiff,0)),starttime) 
								WHEN @TargetHours<ISNULL(@CumulativeDiff,0) THEN DATEADD(SECOND,(@TargetHours-ISNULL(@Diff,0)),starttime) 
								ELSE @TargetFinishtime END FROM #Timeinfo1 WHERE ISPDT=0 AND id=@i
								SELECT @i=@count+1
							END
							ELSE
							BEGIN
						
								SELECT @TargetFinishtime=CASE WHEN ISNULL(endtime,'1900-01-01')='1900-01-01' THEN DATEADD(SECOND,(@TargetHours-ISNULL(@CumulativeDiff,0)),starttime) ELSE Endtime END  FROM #Timeinfo1 WHERE ISPDT=0 AND id=@i
								--SELECT @CumulativeDiff=ISNULL(@CumulativeDiff,0) + (SELECT datediff(second,starttime,endtime) from #Timeinfo1 where ISPDT=0 and id=@i)
								SELECT @Diff=ISNULL(@Diff,0) + (SELECT DATEDIFF(SECOND,starttime,endtime) FROM #Timeinfo1 WHERE ISPDT=0 AND id=@i)
								SET @i=(SELECT TOP 1 id FROM #Timeinfo1 WHERE ISPDT=0 AND id>@i ORDER BY id)
								SELECT @CumulativeDiff=ISNULL(@CumulativeDiff,0) + (SELECT DATEDIFF(SECOND,starttime,endtime) FROM #Timeinfo1 WHERE ISPDT=0 AND id=@i)
							END
						END


		UPDATE #scheduler SET ScheduleStart=@Starttime,ScheduleEnd=@TargetFinishtime WHERE idd=@j

		END
		ELSE
		BEGIN

			UPDATE #scheduler SET ScheduleStart=@Starttime,ScheduleEnd=DATEADD(SECOND,CAST((stdcycletime)AS FLOAT),@Starttime) WHERE idd=@j
		END

SELECT @Starttime=ScheduleEnd,@PrevPONo=PONumber,@PrevMaterial=MaterialID,@PrevOpnNo=OpnNo,@PrevFabricationNo=FabricationNo,@prevGrnNo=GrnNo FROM #Scheduler WHERE idd=@j


SELECT @j=@j+1
SELECT @CurrentPONo=PONumber,@currentMaterial=MaterialID,@CurrentOpnNo=OpnNo,@CurrentFabricationNo=FabricationNo,@CurrentGrnNo=GrnNo  FROM #Scheduler WHERE idd=@j

IF  @currentMaterial<>@PrevMaterial OR @CurrentOpnNo<>@PrevOpnNo OR ISNULL(@CurrentFabricationNo,'a')<>ISNULL(@PrevFabricationNo,'a') OR ISNULL(@CurrentGrnNo,'')<>ISNULL(@prevGrnNo,'')
BEGIN
	--update #Scheduler set stdcycletime=stdcycletime+StdSetupTime from #Scheduler where idd=@j
	UPDATE #Scheduler SET @Starttime=DATEADD(SECOND,StdSetupTime,@Starttime) FROM #Scheduler WHERE idd=@j
END

DELETE FROM #PDT
DELETE FROM #Timeinfo1
END


UPDATE ScheduleDetails_GEA SET ScheduleStart=t.ScheduleStart,ScheduleEnd=T.ScheduleEnd FROM
(SELECT * FROM #Scheduler)T INNER JOIN ScheduleDetails_GEA S ON S.Machineid=T.Machineid AND S.ProductionOrder=T.PONumber AND
S.MaterialID=T.MaterialID AND S.OperationNo=T.OpnNo AND S.SchedulePriority=T.SCHPriority AND ISNULL(S.FabricationNo,'a')=ISNULL(T.FabricationNo,'a') AND ISNULL(s.GrnNo,'')=ISNULL(t.GrnNo,'')

END 
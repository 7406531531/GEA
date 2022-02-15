/****** Object:  Procedure [dbo].[s_GetANDONHelpCodeDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*************************************************************************************************** 
-- Author:		Anjana C V
-- Create date: 08 April 2020
-- Modified date: 08 April 2020
-- Description:  Get  ANDON Help Code Details Data for GEA
ER0506 : SwathiKS : 08/Jun/2021::To handle stdcycletime at suboperation Level. (CN Calcualtion has beeen altered only for Assemnly,packing,Testing Processes)


--1st Screen :
exec [dbo].[s_GetANDONHelpCodeDetails_GEA] '2021-06-03 06:00:00','','1st Screen'

--2nd Screen :
Exec [dbo].[s_GetANDONHelpCodeDetails_GEA] '2021-08-10 22:30:00','','2nd Screen'

--3rd Screen :
Exec [dbo].[s_GetANDONHelpCodeDetails_GEA] '2020-02-01 06:30:00 AM','','3rd Screen'
****************************************************************************************************/  
CREATE PROCEDURE [dbo].[s_GetANDONHelpCodeDetails_GEA]
	@DateTime datetime ='',
	@PlantID nvarchar(50)='',
	@Param nvarchar(50)=''

WITH RECOMPILE
AS
BEGIN

SET NOCOUNT ON;

Declare @strPlantID as nvarchar(255)
Declare @timeformat as nvarchar(50)
Declare @Starttime AS Datetime 
Declare @Endtime AS Datetime
Declare @strSql as nvarchar(4000)
Declare @startMonth AS DateTime 
 
CREATE TABLE #CockPitData 
(
	Plantid nvarchar(50),
	MachineID nvarchar(50),
	Process nvarchar(50),
	MachineInterface nvarchar(50) PRIMARY KEY,
	ProductionEfficiency float,
	AvailabilityEfficiency float,
	OverallEfficiency float,
	Components float,
	Target float,
	TotalTime float,
	UtilisedTime float,
	ManagementLoss float,
	DownTime float,
	CN float,
	PEGreen smallint,
	PERed smallint,
	AEGreen smallint,
	AERed smallint,
	OEGreen smallint,
	OERed smallint,
	MaxDownReason nvarchar(50) DEFAULT (''),
	MaxDowntime float ,
	MLDown float,
	Operatorid nvarchar(50),
	HelpCode1 nvarchar(10),
	HelpCode2 nvarchar(10),
	HelpCode3 nvarchar(10),
	HelpCode4 nvarchar(10),
	HelpCode1TS nvarchar(10),
	HelpCode2TS nvarchar(10),
	HelpCode3TS nvarchar(10),
	HelpCode4TS nvarchar(10),
	ColorCode nvarchar(50)
)

CREATE TABLE #T_autodata
(
	[mc] [nvarchar](50)not NULL,
	[comp] [nvarchar](50) NULL,
	[opn] [nvarchar](50) NULL,
	[opr] [nvarchar](50) NULL,
	[dcode] [nvarchar](50) NULL,
	[sttime] [datetime] not NULL,
	[ndtime] [datetime] NULL,
	[datatype] [tinyint] NULL ,
	[cycletime] [int] NULL,
	[loadunload] [int] NULL ,
	[msttime] [datetime] NULL,
	[PartsCount] [int] NULL ,
	id  bigint not null,
	WorkorderNumber nvarchar(50), --ER0506 Added for GEA 07/06/2021
	CompSlNo nvarchar(50) -- ER0506 Added for GEA 07/06/2021
)

ALTER TABLE #T_autodata

ADD PRIMARY KEY CLUSTERED
(
	mc,sttime ASC
)ON [PRIMARY]

CREATE TABLE #T_autodataforDown
	(
		[mc] [nvarchar](50)not NULL,
		[comp] [nvarchar](50) NULL,
		[opn] [nvarchar](50) NULL,
		[opr] [nvarchar](50) NULL,
		[dcode] [nvarchar](50) NULL,
		[sttime] [datetime] not NULL,
		[ndtime] [datetime] NULL,
		[datatype] [tinyint] NULL ,
		[cycletime] [int] NULL,
		[loadunload] [int] NULL ,
		[msttime] [datetime] NULL,
		[PartsCount] [int] NULL ,
		id  bigint not null
	)

ALTER TABLE #T_autodataforDown
ADD PRIMARY KEY CLUSTERED
	(
		mc,sttime ASC
	)ON [PRIMARY]

CREATE TABLE #PLD
(
	MachineID nvarchar(50),
	MachineInterface nvarchar(50),
	pPlannedDT float Default 0,
	dPlannedDT float Default 0,
	MPlannedDT float Default 0,
	IPlannedDT float Default 0,
	DownID nvarchar(50)
)

CREATE table #PlannedDownTimes
(
	MachineID nvarchar(50) NOT NULL, 
	MachineInterface nvarchar(50) NOT NULL, 
	StartTime DateTime NOT NULL, 
	EndTime DateTime NOT NULL, 
)

ALTER TABLE #PlannedDownTimes
	ADD PRIMARY KEY CLUSTERED
		(   [MachineInterface],
			[StartTime],
			[EndTime]
						
		) ON [PRIMARY]

CREATE table #Runningpart_Part
(  
	 Machineid nvarchar(50),  
	 Operatorid nvarchar(50),
	 StTime Datetime 
)  

CREATE table #HelpCode
(
	Machineid nvarchar(50), 
	HelpDescription nvarchar(50), 
	HelpCode nvarchar(50),
	Action1 nvarchar(10),
	Action2 nvarchar(10)
)

CREATE TABLE #MachineRunningStatus
(
	MachineID NvarChar(50),
	MachineInterface nvarchar(50),
	sttime Datetime,
	ndtime Datetime,
	DataType smallint,
	ColorCode varchar(10),
	DownTime Int,
	lastDownstart datetime,
	PDT int
)


CREATE TABLE #HourDetails
	(
		[ID] int IDENTITY(1,1),
		PDate Datetime,
		ShiftName NvarChar(20),
		ShiftID int,
		ShiftStart DateTime,
		ShiftEnd DateTime,
		HourName NVarchar(50),
		HourID Int,
		HourStart DateTime,
		HourEnd Datetime 	
	)


CREATE table #HourlyData1
	(
		 Machineid nvarchar(50),  
		 FromTime datetime,  
		 ToTime Datetime,  
		 Actual float,  
		 Target float Default 0,
		 ActualTotal float Default 0,
		 TargetTotal float Default 0
	)

CREATE table #HourlyData
	(
		Machineid nvarchar(50),  
		FromTime datetime,  
		ToTime Datetime,  
		Actual float,  
		Target float Default 0,
		ActualTotal float Default 0,
		TargetTotal float Default 0
	)

CREATE Table #ShiftTemp  
	 (  
	  PDate datetime,  
	  ShiftName nvarchar(20),  
	  FromTime datetime,  
	  ToTime Datetime, 
	  ShiftId int
	 ) 

 CREATE TABLE #PlannedDownTimesHour
	(
		SlNo int not null identity(1,1),
		Starttime datetime,
		EndTime datetime,
		Machine nvarchar(50),
		MachineInterface nvarchar(50),
		DownReason nvarchar(50),
		HourStart datetime
	)

CREATE TABLE #Target  
	(
		MachineID nvarchar(50) NOT NULL,  
		machineinterface nvarchar(50),  
		Compinterface nvarchar(50),  
		OpnInterface nvarchar(50),  
		Component nvarchar(50) NOT NULL,  
		Operation nvarchar(50) NOT NULL,  
		Operator nvarchar(50),  
		OprInterface nvarchar(50),  
		FromTm datetime,  
		ToTm datetime,     
		msttime datetime,  
		ndtime datetime,  
		batchid int,  
		autodataid bigint ,
		stdTime float,
		Shift nvarchar(20)
	)

CREATE TABLE #FinalTarget  
	(
		 MachineID nvarchar(50) NOT NULL,  
		 machineinterface nvarchar(50),  
		 Component nvarchar(50) NOT NULL,  
		 Compinterface nvarchar(50),  
		 Operation nvarchar(50) NOT NULL,  
		 OpnInterface nvarchar(50),  
		 Operator nvarchar(50),  
		 OprInterface nvarchar(50),  
		 FromTm datetime,  
		 ToTm datetime,     
		 BatchStart datetime,  
		 BatchEnd datetime,  
		 batchid int,    
		 Components float,  
		 Downtime nvarchar(4000),  
		 stdTime float,
		 Target float default 0,
		 Shift nvarchar(20),
		 Runtime float default 0,
		 TotalAvailabletime float
	)

CREATE TABLE #DownTimeData
(
	MachineID nvarchar(50) NOT NULL,
	McInterfaceid nvarchar(4),
	DownID nvarchar(50) NOT NULL,
	DownTime float,
	DownFreq int
)

ALTER TABLE #DownTimeData
	ADD PRIMARY KEY CLUSTERED
	(
		[MachineId], [DownID]
	)ON [PRIMARY]

SELECT @strPlantID = ''

Select @timeformat = isnull((select valueintext from cockpitdefaults where parameter='timeformat'),'ss')
if (@timeformat <>'hh:mm:ss' and @timeformat <>'hh' and @timeformat <>'mm'and @timeformat <>'ss')
begin
	Select @timeformat = 'ss'
end
IF ISNULL(@DateTime ,'') =''
BEGIN
	Select @DateTime = GETDATE()
END

Select @Endtime = @DateTime

--If (select ValueInText from CockpitDefaults where Parameter = 'ANDONHelpCode') = 'Daily'
If (select valueintext2 from CockpitDefaults where parameter='WebAndon' and valueintext='ShowDataBy') = 'Daywise'
BEGIN
Select @Starttime = dbo.f_GetLogicalDay(@DateTime,'start')
END

--ELSE If (select ValueInText from CockpitDefaults where Parameter = 'ANDONHelpCode') = 'Weekly'
ELSE If (select valueintext2 from CockpitDefaults where parameter='WebAndon' and valueintext='ShowDataBy') = 'Weekwise'
BEGIN 
Select @Starttime = dbo.f_GetLogicalDay((DATEADD(dd, -(DATEPART(dw, @DateTime)-1),  @DateTime)),'start')
END

If @Param='3rd Screen'
BEGIN
	Select @startMonth = [dbo].[f_GetLogicalMonth](@DateTime,'Start')
END


Select @strsql=''
SET @strSql = 'INSERT INTO #CockpitData (Plantid,MachineID,process,MachineInterface,ProductionEfficiency ,AvailabilityEfficiency,
				OverallEfficiency,Components ,TotalTime ,UtilisedTime ,	ManagementLoss,DownTime ,CN,PEGreen ,PERed,AEGreen ,AERed ,
				OEGreen ,OERed,HelpCode1,HelpCode2,HelpCode3,HelpCode4,MaxDowntime,Target ) '
SET @strSql = @strSql + ' SELECT PlantMachine.Plantid,MachineInformation.MachineID,MachineInformation.process,MachineInformation.interfaceid ,0,0,0,0,0,0,
						   0,0,0,PEGreen ,PERed,AEGreen ,AERed ,OEGreen ,OERed,''White'',''White'',''White'',''White'',0,0 
						   FROM MachineInformation 
			               LEFT OUTER JOIN PlantMachine ON machineinformation.machineid = PlantMachine.MachineID 
						   WHERE MachineInformation.interfaceid > ''0'' '
SET @strSql =  @strSql  + @strPlantID 
PRINT @StrSql
EXEC(@strSql)
------------------------------------------------------------------------------------------------
---------------------------Help code and mc status-----------------------------
select @strsql=''
		SELECT @strsql= @strsql + 'insert into #HelpCode(Machineid,HelpDescription,HelpCode,Action1,Action2)  
		Select T.Machineid,T.Help_Description,T.HelpCode,H.Action1,H.Action2 
		from(
			select Machineinformation.Machineid,Max(HD.ID) as ID,HM.Help_Description,HD.HelpCode 
			 from helpcodedetails HD WITH (NOLOCK)
			 Inner join HelpCodeMaster HM on HD.HelpCode=HM.Help_code
			 Inner join Machineinformation on HD.Machineid=Machineinformation.interfaceid 
		     group by Machineinformation.Machineid,HM.Help_Description,HD.HelpCode
			)T 
		inner join helpcodedetails H on T.ID = H.ID
		where isnull(H.Action2,''a'') <> ''04'''
		print @strsql
		exec (@strsql) 
	
		Update #Cockpitdata set HelpCode1 = T1.Val1 from
		(Select Machineid,
		 Case when Action1 = '01' and  Isnull(Action2,'a')='a' then 'Red'
		 when Action1 = '01' and  Action2 ='02' then 'Yellow'
		 when Action1 = '01' and  Action2 ='03' then 'Green'
		 when Action1 = '01' and  Action2 ='04' then 'White' end as Val1 from #HelpCode
		 Where  HelpCode = '01')T1
		inner join #CockpitData on T1.MachineID = #CockpitData.MachineID

		Update #Cockpitdata set HelpCode2=T1.Val2 from
		(Select Machineid,
		 Case when Action1 = '01' and  Isnull(Action2,'a')='a' then 'Red'
		 when Action1 = '01' and  Action2 ='02' then 'Yellow'
		 when Action1 = '01' and  Action2 ='03' then 'Green'
		 when Action1 = '01' and  Action2 ='04' then 'White' end as Val2 from #HelpCode
		 Where  HelpCode = '02')T1
		inner join #CockpitData on T1.MachineID = #CockpitData.MachineID

		Update #Cockpitdata set HelpCode3=T1.Val3 from
		(Select Machineid,
		 Case when Action1 = '01' and  Isnull(Action2,'a')='a' then 'Red'
		 when Action1 = '01' and  Action2 ='02' then 'Yellow'
		 when Action1 = '01' and  Action2 ='03' then 'Green'
		 when Action1 = '01' and  Action2 ='04' then 'White' end as  Val3 
		 from #HelpCode
		 Where  HelpCode = '03'
		 )T1
		inner join #CockpitData on T1.MachineID = #CockpitData.MachineID

		Update #Cockpitdata set HelpCode4=T1.Val4 from
		(Select Machineid,
		 Case when Action1 = '01' and  Isnull(Action2,'a')='a' then 'Red'
		  when Action1 = '01' and  Action2 ='02' then 'Yellow'
		  when Action1 = '01' and  Action2 ='03' then 'Green'
		  when Action1 = '01' and  Action2 ='04' then 'White' end as Val4 
		 from #HelpCode
		 Where  HelpCode = '04'
		 )T1
		inner join #CockpitData on T1.MachineID = #CockpitData.MachineID


		Declare @Type40Threshold int
		Declare @Type1Threshold int
		Declare @Type11Threshold int

		Set @Type40Threshold = (Select isnull(Valueintext2,5)*60 from shopdefaults where parameter='ANDONStatusThreshold' and valueintext = 'Type40Threshold')
		Set @Type1Threshold = (Select isnull(Valueintext2,5)*60 from shopdefaults where parameter='ANDONStatusThreshold' and valueintext = 'Type1Threshold')
		Set @Type11Threshold = (Select isnull(Valueintext2,5)*60 from shopdefaults where parameter='ANDONStatusThreshold' and valueintext = 'Type11Threshold')
		print @Type40Threshold
		print @Type1Threshold
		print @Type11Threshold

		Insert into #machineRunningStatus
		select fd.MachineID,fd.MachineInterface,sttime,ndtime,datatype,'White',0,'1900-01-01',0 from rawdata
		inner join (select mc,max(slno) as slno from rawdata WITH (NOLOCK) where sttime<@DateTime and isnull(ndtime,'1900-01-01')<@DateTime
		and datatype in(2,42,40,41,1,11) group by mc ) t1 on t1.mc=rawdata.mc and t1.slno=rawdata.slno
		right outer join #CockpitData fd on fd.MachineInterface = rawdata.mc
		order by rawdata.mc

		update #machineRunningStatus set ColorCode = case when (datediff(second,sttime,@DateTime)- @Type11Threshold)>0  then 'Red' else 'Green' end where datatype in (11)
		update #machineRunningStatus set ColorCode = 'Green' where datatype in (41)
		update #machineRunningStatus set ColorCode = 'Red' where datatype in (42,2)

		update #machineRunningStatus set ColorCode = t1.ColorCode from (
		Select mrs.MachineID,Case when (
		case when datatype = 40 then datediff(second,sttime,@DateTime)- @Type40Threshold
		when datatype = 1 then datediff(second,ndtime,@DateTime)- @Type1Threshold
		end) > 0 then 'Red' else 'Green' end as ColorCode
		from #machineRunningStatus mrs 
		where  datatype in (40,1)
		) as t1 inner join #machineRunningStatus on t1.MachineID = #machineRunningStatus.MachineID

		Update #machineRunningStatus set DownTime = Isnull(#machineRunningStatus.DownTime,0) + Isnull(t2.DownTime,0)
		,lastDownstart=t2.LastRecord
		from (
			Select mrs.MachineID,
			dateDiff(second,t1.LastRecord,@DateTime) as DownTime,t1.LastRecord
			from #machineRunningStatus mrs 
			inner join (
				Select mrs.MachineID,
				case when (datatype = 1) then dateadd(s,@Type1Threshold,ndtime)
				when (datatype = 2)or(datatype = 42) then ndtime
				when datatype = 40 then dateadd(s,@Type40Threshold,sttime)
				when datatype=11 then dateadd(s,@Type11Threshold,sttime)
				when datatype=41 then sttime end as LastRecord
				from #machineRunningStatus mrs
			) as t1 on t1.machineID = mrs.machineID 
		) as t2 inner join #machineRunningStatus on t2.MachineID = #machineRunningStatus.MachineID


		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'N' 
		BEGIN
			update #machineRunningStatus set PDT = Isnull(fd.PDT,0) + isnull(T2.pdt,0)
			from
			(
			Select T1.machineid,sum(datediff(ss,T1.StartTime,t1.EndTime)) as pdt 
			from (
			select fD.machineid,
			Case when  fd.lastDownstart <= pdt.StartTime then pdt.StartTime else  lastDownstart End as StartTime,
			Case when @DateTime >= pdt.EndTime then pdt.EndTime else @DateTime End as EndTime
			From Planneddowntimes pdt
			inner join #machineRunningStatus fD on fd.machineid=Pdt.machine
			where PDTstatus = 1  and 
			((pdt.StartTime >= fd.lastDownstart and pdt.EndTime <= @DateTime)or
			(pdt.StartTime < fd.lastDownstart and pdt.EndTime > fd.lastDownstart and pdt.EndTime <=@DateTime)or
			(pdt.StartTime >= fd.lastDownstart and pdt.StartTime <@DateTime and pdt.EndTime >@DateTime) or
			(pdt.StartTime <  fd.lastDownstart and pdt.EndTime >@DateTime))
			)T1  group by T1.machineid )T2 inner join #machineRunningStatus fd on fd.machineid=t2.machineid	
				
	    update #machineRunningStatus set ColorCode = Case when Downtime-PDT=0 then 'Blue' else Colorcode end 
		end

		update #machineRunningStatus set ColorCode ='Red' where isnull(sttime,'1900-01-01')='1900-01-01'
	
		Update #CockpitData set Colorcode = Isnull(#CockpitData.Colorcode,'') +  isnull(T1.Color,'') from
		(select Machineid,Colorcode as color from #machineRunningStatus)T1
		inner join #CockpitData on T1.MachineID = #CockpitData.MachineID

-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

	Select @strsql=''
	select @strsql ='insert into #T_autodata '
	select @strsql = @strsql + 'SELECT mc, comp, opn, opr, dcode,sttime,'
	select @strsql = @strsql + 'ndtime, datatype, cycletime, loadunload, msttime, PartsCount,id,WorkorderNumber,CompSlNo' -- ER0506 Added For GEA on 07/06/2021
	select @strsql = @strsql + ' from autodata WITH (NOLOCK) where (( sttime >='''+ convert(nvarchar(25),@Starttime,120)+''' and ndtime <= '''+ convert(nvarchar(25),@Endtime,120)+''' ) OR ' ----ER0377 Added LOCK
	select @strsql = @strsql + '( sttime <'''+ convert(nvarchar(25),@Starttime,120)+''' and ndtime >'''+ convert(nvarchar(25),@Endtime,120)+''' )OR '
	select @strsql = @strsql + '( sttime <'''+ convert(nvarchar(25),@Starttime,120)+''' and ndtime >'''+ convert(nvarchar(25),@Starttime,120)+'''
						and ndtime<='''+convert(nvarchar(25),@Endtime,120)+''' )'
	select @strsql = @strsql + ' OR ( sttime >='''+convert(nvarchar(25),@Starttime,120)+''' and ndtime >'''+ convert(nvarchar(25),@Endtime,120)+''' and sttime<'''+convert(nvarchar(25),@Endtime,120)+''' ) )'
	print @strsql
	exec (@strsql) 

SET @strSql = ''
SET @strSql = 'INSERT INTO #PLD(MachineID,MachineInterface,pPlannedDT,dPlannedDT)
	SELECT MachineID ,Interfaceid,0  ,0 FROM MachineInformation WHERE  MachineInformation.interfaceid > ''0'' '
SET @strSql =  @strSql  
PRINT @StrSql
EXEC(@strSql)

/* Planned Down times for the given time period */
SET @strSql = ''
SET @strSql = 'Insert into #PlannedDownTimes
	SELECT Machine,InterfaceID,
		CASE When StartTime<''' + convert(nvarchar(20),@Starttime,120)+''' Then ''' + convert(nvarchar(20),@Starttime,120)+''' Else StartTime End As StartTime,
		CASE When EndTime>''' + convert(nvarchar(20),@EndTime,120)+''' Then ''' + convert(nvarchar(20),@EndTime,120)+''' Else EndTime End As EndTime
	FROM PlannedDownTimes inner join MachineInformation on PlannedDownTimes.machine = MachineInformation.MachineID
	WHERE PDTstatus =1 and(
	(StartTime >= ''' + convert(nvarchar(20),@Starttime,120)+''' AND EndTime <=''' + convert(nvarchar(20),@EndTime,120)+''')
	OR ( StartTime < ''' + convert(nvarchar(20),@Starttime,120)+'''  AND EndTime <= ''' + convert(nvarchar(20),@EndTime,120)+''' AND EndTime > ''' + convert(nvarchar(20),@Starttime,120)+''' )
	OR ( StartTime >= ''' + convert(nvarchar(20),@Starttime,120)+'''   AND StartTime <''' + convert(nvarchar(20),@EndTime,120)+''' AND EndTime > ''' + convert(nvarchar(20),@EndTime,120)+''' )
	OR ( StartTime < ''' + convert(nvarchar(20),@Starttime,120)+'''  AND EndTime > ''' + convert(nvarchar(20),@EndTime,120)+''')) '
SET @strSql =  @strSql  + ' ORDER BY Machine,StartTime'
PRINT @StrSql
EXEC(@strSql)
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
IF (@param = '1st screen' or @param = '2nd screen')
BEGIN
		UPDATE #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) + isNull(t2.cycle,0)
		from
		(	(select  mc,
		sum( case 
		     when ( (autodata.msttime>=@Starttime) and (autodata.ndtime<=@Endtime)) 
		      then  (cycletime+loadunload)
		     when ((autodata.msttime<@Starttime)and (autodata.ndtime>@Starttime)and (autodata.ndtime<=@Endtime)) 
			  then DateDiff(second, @Starttime, ndtime)
			 when ((autodata.msttime>=@Starttime)and (autodata.msttime<@Endtime)and (autodata.ndtime>@Endtime)) 
			  then DateDiff(second, mstTime, @Endtime)
			 when ((autodata.msttime<@Starttime)and (autodata.ndtime>@Endtime)) 
			  then DateDiff(second, @Starttime, @Endtime) END
		  ) as cycle
		from #T_autodata autodata 
		where (autodata.datatype=1) AND(( (autodata.msttime>=@Starttime) and (autodata.ndtime<=@Endtime))
		OR ((autodata.msttime<@Starttime) and (autodata.ndtime>@Starttime) and (autodata.ndtime<=@Endtime))
		OR ((autodata.msttime>=@Starttime) and (autodata.msttime<@Endtime) and (autodata.ndtime>@Endtime))
		OR((autodata.msttime<@Starttime) and (autodata.ndtime>@Endtime)))
		group by autodata.mc
)
		) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface

		/* Fetching Down Records from Production Cycle  */
		/* If Down Records of TYPE-2*/
		UPDATE  #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) - isNull(t2.Down,0)
		FROM
		(Select AutoData.mc ,
		SUM(
		CASE
			When autodata.sttime <= @Starttime Then datediff(s, @Starttime,autodata.ndtime )
			When autodata.sttime > @Starttime Then datediff(s , autodata.sttime,autodata.ndtime)
		END) as Down
		From #T_autodata AutoData INNER Join
			(Select mc,Sttime,NdTime From #T_autodata AutoData
				Where DataType=1 And DateDiff(Second,sttime,ndtime)>CycleTime And
				(msttime < @Starttime)And (ndtime > @Starttime) AND (ndtime <= @EndTime)) as T1
		ON AutoData.mc=T1.mc
		Where AutoData.DataType=2
		And ( autodata.Sttime > T1.Sttime )
		And ( autodata.ndtime <  T1.ndtime )
		AND ( autodata.ndtime >  @Starttime )
		GROUP BY AUTODATA.mc)AS T2 Inner Join #CockpitData on t2.mc = #CockpitData.machineinterface

		/* If Down Records of TYPE-3*/
		UPDATE  #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) - isNull(t2.Down,0)
		FROM
		(Select AutoData.mc ,
		SUM(CASE
			When autodata.ndtime > @EndTime Then datediff(s,autodata.sttime, @EndTime )
			When autodata.ndtime <=@EndTime Then datediff(s , autodata.sttime,autodata.ndtime)
		END) as Down
		From #T_autodata AutoData INNER Join
			(Select mc,Sttime,NdTime From #T_autodata AutoData
				Where DataType=1 And DateDiff(Second,sttime,ndtime)>CycleTime And
				(sttime >= @Starttime)And (ndtime > @EndTime) and (sttime<@EndTime) ) as T1
		ON AutoData.mc=T1.mc
		Where AutoData.DataType=2
		And (T1.Sttime < autodata.sttime  )
		And ( T1.ndtime >  autodata.ndtime)
		AND (autodata.sttime  <  @EndTime)
		GROUP BY AUTODATA.mc
		)AS T2 Inner Join #CockpitData on t2.mc = #CockpitData.machineinterface

		/* If Down Records of TYPE-4*/
		UPDATE  #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) - isNull(t2.Down,0)
		FROM
		(Select AutoData.mc ,
		SUM(CASE
			When autodata.sttime >= @Starttime AND autodata.ndtime <= @EndTime Then datediff(s , autodata.sttime,autodata.ndtime)
			When autodata.sttime < @Starttime AND autodata.ndtime > @Starttime AND autodata.ndtime<=@EndTime Then datediff(s, @Starttime,autodata.ndtime )
			When autodata.sttime>=@Starttime And autodata.sttime < @EndTime AND autodata.ndtime > @EndTime Then datediff(s,autodata.sttime, @EndTime )
			When autodata.sttime<@Starttime AND autodata.ndtime>@EndTime   Then datediff(s , @Starttime,@EndTime)
		END) as Down
		From #T_autodata AutoData INNER Join
			(Select mc,Sttime,NdTime From #T_autodata AutoData
				Where DataType=1 And DateDiff(Second,sttime,ndtime)>CycleTime And
				(msttime < @Starttime)And (ndtime > @EndTime) ) as T1
		ON AutoData.mc=T1.mc
		Where AutoData.DataType=2
		And (T1.Sttime < autodata.sttime  )
		And ( T1.ndtime >  autodata.ndtime)
		AND (autodata.ndtime  >  @Starttime)
		AND (autodata.sttime  <  @EndTime)
		GROUP BY AUTODATA.mc
		)AS T2 Inner Join #CockpitData on t2.mc = #CockpitData.machineinterface

		--mod 4:Get utilised time over lapping with PDT.
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Ptime_4m_PLD')='Y'
		BEGIN

		------------------------------------ ER0377 Added From Here ---------------------------------
			UPDATE #PLD set pPlannedDT =isnull(pPlannedDT,0) + isNull(TT.PPDT ,0)
			FROM(
				--Production Time in PDT
				SELECT autodata.MC,SUM
					(CASE
		  			WHEN autodata.msttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN DateDiff(second,autodata.msttime,autodata.ndtime) --DR0325 Added
					WHEN ( autodata.msttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.msttime >= T.StartTime   AND autodata.msttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.msttime,T.EndTime )
					WHEN ( autodata.msttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END)  as PPDT
					FROM (select M.machineid,mc,msttime,ndtime from #T_autodata autodata
						inner join machineinformation M on M.interfaceid=Autodata.mc
						 where autodata.DataType=1 And 
						((autodata.msttime >= @Starttime  AND autodata.ndtime <=@Endtime)
						OR ( autodata.msttime < @Starttime  AND autodata.ndtime <= @Endtime AND autodata.ndtime > @Starttime )
						OR ( autodata.msttime >= @Starttime   AND autodata.msttime <@Endtime AND autodata.ndtime > @Endtime )
						OR ( autodata.msttime < @Starttime  AND autodata.ndtime > @Endtime))
						)
				AutoData inner jOIN #PlannedDownTimes T on T.Machineid=AutoData.machineid
				WHERE 
					(
					(autodata.msttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.msttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.msttime >= T.StartTime   AND autodata.msttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.msttime < T.StartTime  AND autodata.ndtime > T.EndTime) )
				group by autodata.mc
			)
			 as TT INNER JOIN #PLD ON TT.mc = #PLD.MachineInterface

				--mod 4(4):Handle intearction between ICD and PDT for type 1 production record for the selected time period.
				UPDATE  #PLD set IPlannedDT =isnull(IPlannedDT,0) + isNull(T2.IPDT ,0) 	FROM	(
				Select T1.mc,SUM(
					CASE 	
						When T1.sttime >= T.StartTime  AND T1.ndtime <=T.EndTime  Then datediff(s , T1.sttime,T1.ndtime) ---type 1
						When T1.sttime < T.StartTime  and  T1.ndtime <= T.EndTime AND T1.ndtime > T.StartTime Then datediff(s, T.StartTime,T1.ndtime ) ---type 2
						When T1.sttime >= T.StartTime   AND T1.sttime <T.EndTime AND T1.ndtime > T.EndTime Then datediff(s, T1.sttime,T.EndTime ) ---type 3
						when T1.sttime < T.StartTime  AND T1.ndtime > T.EndTime Then datediff(s, T.StartTime,T.EndTime ) ---type 4
					END) as IPDT from
				(Select A.mc,(select machineid from machineinformation where interfaceid = A.mc)as machine, A.sttime, ndtime, A.datatype from #T_autodata A
				Where A.DataType=2
				and exists 
					(
					Select B.Sttime,B.NdTime,B.mc From #T_autodata B
					Where B.mc = A.mc and
					B.DataType=1 And DateDiff(Second,B.sttime,B.ndtime)> B.CycleTime And
					(B.msttime >= @Starttime AND B.ndtime <= @Endtime) and
					(B.sttime < A.sttime) AND (B.ndtime > A.ndtime) 
					)
				 )as T1 inner join
				(select  machine,Case when starttime<@Starttime then @Starttime else starttime end as starttime, 
				case when endtime> @Endtime then @Endtime else endtime end as endtime from dbo.PlannedDownTimes 
				where ((( StartTime >=@Starttime) And ( EndTime <=@Endtime))
				or (StartTime < @Starttime  and  EndTime <= @Endtime AND EndTime > @Starttime)
				or (StartTime >= @Starttime  AND StartTime <@Endtime AND EndTime > @Endtime)
				or (( StartTime <@Starttime) And ( EndTime >@Endtime )) )
				)T
				on T1.machine=T.machine AND
				((( T.StartTime >=T1.Sttime) And ( T.EndTime <=T1.ndtime ))
				or (T.StartTime < T1.Sttime  and  T.EndTime <= T1.ndtime AND T.EndTime > T1.Sttime)
				or (T.StartTime >= T1.Sttime   AND T.StartTime <T1.ndtime AND T.EndTime > T1.ndtime )
				or (( T.StartTime <T1.Sttime) And ( T.EndTime >T1.ndtime )) )group by T1.mc
				)AS T2  INNER JOIN #PLD ON T2.mc = #PLD.MachineInterface
				---mod 4(4)
	
			/* Fetching Down Records from Production Cycle  */
			/* If production  Records of TYPE-2*/
			UPDATE  #PLD set IPlannedDT =isnull(IPlannedDT,0) + isNull(T2.IPDT ,0) 	FROM	(
				Select T1.mc,SUM(
				CASE 	
					When T1.sttime >= T.StartTime  AND T1.ndtime <=T.EndTime  Then datediff(s , T1.sttime,T1.ndtime) ---type 1
					When T1.sttime < T.StartTime  and  T1.ndtime <= T.EndTime AND T1.ndtime > T.StartTime Then datediff(s, T.StartTime,T1.ndtime ) ---type 2
					When T1.sttime >= T.StartTime   AND T1.sttime <T.EndTime AND T1.ndtime > T.EndTime Then datediff(s, T1.sttime,T.EndTime ) ---type 3
					when T1.sttime < T.StartTime  AND T1.ndtime > T.EndTime Then datediff(s, T.StartTime,T.EndTime ) ---type 4
				END) as IPDT from
				(Select A.mc,(select machineid from machineinformation where interfaceid = A.mc)as machine, A.sttime, ndtime, A.datatype from #T_autodata A
				Where A.DataType=2
				and exists 
				(
				Select B.Sttime,B.NdTime From #T_autodata B
				Where B.mc = A.mc and
				B.DataType=1 And DateDiff(Second,B.sttime,B.ndtime)> B.CycleTime And
				(B.msttime < @Starttime And B.ndtime > @Starttime AND B.ndtime <= @EndTime) 
				And ((A.Sttime > B.Sttime) And ( A.ndtime < B.ndtime) AND ( A.ndtime > @Starttime ))
				)
				)as T1 inner join
				(select  machine,Case when starttime<@Starttime then @Starttime else starttime end as starttime, 
				case when endtime> @Endtime then @Endtime else endtime end as endtime from dbo.PlannedDownTimes 
				where ((( StartTime >=@Starttime) And ( EndTime <=@Endtime))
				or (StartTime < @Starttime  and  EndTime <= @Endtime AND EndTime > @Starttime)
				or (StartTime >= @Starttime  AND StartTime <@Endtime AND EndTime > @Endtime)
				or (( StartTime <@Starttime) And ( EndTime >@Endtime )) )
				)T
				on T1.machine=T.machine AND
				(( T.StartTime >= @Starttime ) And ( T.StartTime <  T1.ndtime )) group by T1.mc
			)AS T2  INNER JOIN #PLD ON T2.mc = #PLD.MachineInterface
	
			/* If production Records of TYPE-3*/
			UPDATE  #PLD set IPlannedDT =isnull(IPlannedDT,0) + isNull(T2.IPDT ,0)FROM (
			Select T1.mc,SUM(
				CASE 	
					When T1.sttime >= T.StartTime  AND T1.ndtime <=T.EndTime  Then datediff(s , T1.sttime,T1.ndtime) ---type 1
					When T1.sttime < T.StartTime  and  T1.ndtime <= T.EndTime AND T1.ndtime > T.StartTime Then datediff(s, T.StartTime,T1.ndtime ) ---type 2
					When T1.sttime >= T.StartTime   AND T1.sttime <T.EndTime AND T1.ndtime > T.EndTime Then datediff(s, T1.sttime,T.EndTime ) ---type 3
					when T1.sttime < T.StartTime  AND T1.ndtime > T.EndTime Then datediff(s, T.StartTime,T.EndTime ) ---type 4
				END) as IPDT from
				(Select A.mc,(select machineid from machineinformation where interfaceid = A.mc)as machine, A.sttime, ndtime, A.datatype from #T_autodata A
				Where A.DataType=2
				and exists 
				(
				Select B.Sttime,B.NdTime From #T_autodata B
				Where B.mc = A.mc and
				B.DataType=1 And DateDiff(Second,B.sttime,B.ndtime)> B.CycleTime And
				(B.sttime >= @Starttime And B.ndtime > @EndTime and B.sttime <@EndTime) and
				((B.Sttime < A.sttime  )And ( B.ndtime > A.ndtime) AND (A.msttime < @EndTime))
				)
				)as T1 inner join
		--		Inner join #PlannedDownTimes T
				(select  machine,Case when starttime<@Starttime then @Starttime else starttime end as starttime, 
				case when endtime> @Endtime then @Endtime else endtime end as endtime from dbo.PlannedDownTimes 
				where ((( StartTime >=@Starttime) And ( EndTime <=@Endtime))
				or (StartTime < @Starttime  and  EndTime <= @Endtime AND EndTime > @Starttime)
				or (StartTime >= @Starttime  AND StartTime <@Endtime AND EndTime > @Endtime)
				or (( StartTime <@Starttime) And ( EndTime >@Endtime )) )
				)T
				on T1.machine=T.machine
				AND (( T.EndTime > T1.Sttime )And ( T.EndTime <=@EndTime )) group by T1.mc
				)AS T2  INNER JOIN #PLD ON T2.mc = #PLD.MachineInterface
	
	
			/* If production Records of TYPE-4*/
			UPDATE  #PLD set IPlannedDT =isnull(IPlannedDT,0) + isNull(T2.IPDT ,0)FROM (
			Select T1.mc,SUM(
			CASE 	
				When T1.sttime >= T.StartTime  AND T1.ndtime <=T.EndTime  Then datediff(s , T1.sttime,T1.ndtime) ---type 1
				When T1.sttime < T.StartTime  and  T1.ndtime <= T.EndTime AND T1.ndtime > T.StartTime Then datediff(s, T.StartTime,T1.ndtime ) ---type 2
				When T1.sttime >= T.StartTime   AND T1.sttime <T.EndTime AND T1.ndtime > T.EndTime Then datediff(s, T1.sttime,T.EndTime ) ---type 3
				when T1.sttime < T.StartTime  AND T1.ndtime > T.EndTime Then datediff(s, T.StartTime,T.EndTime ) ---type 4
			END) as IPDT from
			(Select A.mc,(select machineid from machineinformation where interfaceid = A.mc)as machine, A.sttime, ndtime, A.datatype from #T_autodata A
			Where A.DataType=2
			and exists 
			(
			Select B.Sttime,B.NdTime From #T_autodata B
			Where B.mc = A.mc and
			B.DataType=1 And DateDiff(Second,B.sttime,B.ndtime)> B.CycleTime And
			(B.msttime < @Starttime And B.ndtime > @EndTime)
			And ((B.Sttime < A.sttime)And ( B.ndtime >  A.ndtime)AND (A.ndtime  >  @Starttime) AND (A.sttime  <  @EndTime))
			)
			)as T1 inner join
				(select  machine,Case when starttime<@Starttime then @Starttime else starttime end as starttime, 
				case when endtime> @Endtime then @Endtime else endtime end as endtime from dbo.PlannedDownTimes 
				where ((( StartTime >=@Starttime) And ( EndTime <=@Endtime))
				or (StartTime < @Starttime  and  EndTime <= @Endtime AND EndTime > @Starttime)
				or (StartTime >= @Starttime  AND StartTime <@Endtime AND EndTime > @Endtime)
				or (( StartTime <@Starttime) And ( EndTime >@Endtime )) )
				)T
				on T1.machine=T.machine AND
			(( T.StartTime >=@Starttime) And ( T.EndTime <=@EndTime )) group by T1.mc
			)AS T2  INNER JOIN #PLD ON T2.mc = #PLD.MachineInterface
		  ---------------------------------------------------------------------

			
		END
		--mod 4
		/*******************************      Utilised Calculation Ends ***************************************************/

		/*******************************Down Record***********************************/
		--**************************************** ManagementLoss and Downtime Calculation Starts **************************************
		---Below IF condition added by Mrudula for mod 4. TO get the ML if 'Ignore_Dtime_4m_PLD'<>"Y"
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='N' or ((SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'N' and (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'Y')
		BEGIN
				-- Type 1
				UPDATE #CockpitData SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)
				from
				(select mc,sum(
				CASE
				WHEN (loadunload) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0
				THEN isnull(downcodeinformation.Threshold,0)
				ELSE loadunload
				END) AS LOSS
				from #T_autodata autodata INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid
				where (autodata.msttime>=@Starttime)
				and (autodata.ndtime<=@EndTime)
				and (autodata.datatype=2)
				and (downcodeinformation.availeffy = 1)
				group by autodata.mc) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
				-- Type 2
				UPDATE #CockpitData SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)
				from
				(select      mc,sum(
				CASE WHEN DateDiff(second, @Starttime, ndtime) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0
				then isnull(downcodeinformation.Threshold,0)
				ELSE DateDiff(second, @Starttime, ndtime)
				END)loss
				from #T_autodata autodata INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid
				where (autodata.sttime<@Starttime)
				and (autodata.ndtime>@Starttime)
				and (autodata.ndtime<=@EndTime)
				and (autodata.datatype=2)
				and (downcodeinformation.availeffy = 1)
				group by autodata.mc
				) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
				-- Type 3
				UPDATE #CockpitData SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)
				from
				(select      mc,SUM(
				CASE WHEN DateDiff(second,stTime, @Endtime) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0
				then isnull(downcodeinformation.Threshold,0)
				ELSE DateDiff(second, stTime, @Endtime)
				END)loss
				from #T_autodata autodata INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid
				where (autodata.msttime>=@Starttime)
				and (autodata.sttime<@EndTime)
				and (autodata.ndtime>@EndTime)
				and (autodata.datatype=2)
				and (downcodeinformation.availeffy = 1)
				group by autodata.mc
				) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
				-- Type 4
				UPDATE #CockpitData SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)
				from
				(select mc,sum(
				CASE WHEN DateDiff(second, @Starttime, @Endtime) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0
				then isnull(downcodeinformation.Threshold,0)
				ELSE DateDiff(second, @Starttime, @Endtime)
				END)loss
				from #T_autodata autodata INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid
				where autodata.msttime<@Starttime
				and autodata.ndtime>@EndTime
				and (autodata.datatype=2)
				and (downcodeinformation.availeffy = 1)
				group by autodata.mc
				) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
				---get the downtime for the time period
				UPDATE #CockpitData SET downtime = isnull(downtime,0) + isNull(t2.down,0)
				from
				(select mc,sum(
						CASE
						WHEN  autodata.msttime>=@Starttime  and  autodata.ndtime<=@EndTime  THEN  loadunload
						WHEN (autodata.sttime<@Starttime and  autodata.ndtime>@Starttime and autodata.ndtime<=@EndTime)  THEN DateDiff(second, @Starttime, ndtime)
						WHEN (autodata.msttime>=@Starttime  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)  THEN DateDiff(second, stTime, @Endtime)
						WHEN autodata.msttime<@Starttime and autodata.ndtime>@EndTime   THEN DateDiff(second, @Starttime, @EndTime)
						END
					)AS down
				from #T_autodata autodata inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid
				where autodata.datatype=2 AND
				(
				(autodata.msttime>=@Starttime  and  autodata.ndtime<=@EndTime)
				OR (autodata.sttime<@Starttime and  autodata.ndtime>@Starttime and autodata.ndtime<=@EndTime)
				OR (autodata.msttime>=@Starttime  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)
				OR (autodata.msttime<@Starttime and autodata.ndtime>@EndTime )
				)
				group by autodata.mc
				) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
		End

		---mod 4: Handling interaction between PDT and downtime . Also interaction between PDT and Management Loss
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='Y'
		BEGIN
			---step 1
			
			UPDATE #CockpitData SET downtime = isnull(downtime,0) + isNull(t2.down,0)
			from
			(select mc,sum(
					CASE
					WHEN  autodata.msttime>=@Starttime  and  autodata.ndtime<=@EndTime  THEN  loadunload
					WHEN (autodata.sttime<@Starttime and  autodata.ndtime>@Starttime and autodata.ndtime<=@EndTime)  THEN DateDiff(second, @Starttime, ndtime)
					WHEN (autodata.msttime>=@Starttime  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)  THEN DateDiff(second, stTime, @Endtime)
					WHEN autodata.msttime<@Starttime and autodata.ndtime>@EndTime   THEN DateDiff(second, @Starttime, @EndTime)
					END
				)AS down
			from #T_autodata autodata inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid
			where autodata.datatype=2 AND
			(
			(autodata.msttime>=@Starttime  and  autodata.ndtime<=@EndTime)
			OR (autodata.sttime<@Starttime and  autodata.ndtime>@Starttime and autodata.ndtime<=@EndTime)
			OR (autodata.msttime>=@Starttime  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)
			OR (autodata.msttime<@Starttime and autodata.ndtime>@EndTime )
			) AND (downcodeinformation.availeffy = 0)
			group by autodata.mc
			) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface

			---mod 4 checking for (downcodeinformation.availeffy = 0) to get the overlapping PDT and Downs which is not ML
			UPDATE #PLD set dPlannedDT =isnull(dPlannedDT,0) + isNull(TT.PPDT ,0)
			FROM(
				--Production PDT
				SELECT autodata.MC, SUM
				   (CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM #T_autodata AutoData CROSS jOIN #PlannedDownTimes T inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid
				WHERE autodata.DataType=2 AND T.MachineInterface=autodata.mc AND
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)AND (downcodeinformation.availeffy = 0)
				group by autodata.mc
			) as TT INNER JOIN #PLD ON TT.mc = #PLD.MachineInterface

			---step 3
			---Management loss calculation
			---IN T1 Select get all the downtimes which is of type management loss
			---IN T2  get the time to be deducted from the cycle if the cycle is overlapping with the PDT. And it should be ML record
			---In T3 Get the real management loss , and time to be considered as real down for each cycle(by comaring with the ML threshold)
			---In T4 consolidate everything at machine level and update the same to #CockpitData for ManagementLoss and MLDown
			
			UPDATE #CockpitData SET  ManagementLoss = isnull(ManagementLoss,0) + isNull(t4.Mloss,0),MLDown=isNull(MLDown,0)+isNull(t4.Dloss,0)
			from
			(select T3.mc,sum(T3.Mloss) as Mloss,sum(T3.Dloss) as Dloss from (
			select   t1.id,T1.mc,T1.Threshold,
			case when DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)> isnull(T1.Threshold ,0) and isnull(T1.Threshold ,0)>0
			then DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)- isnull(T1.Threshold ,0)
			else 0 End  as Dloss,
			case when DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)> isnull(T1.Threshold ,0) and isnull(T1.Threshold ,0)>0
			then isnull(T1.Threshold,0)
			else (DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)) End  as Mloss
			 from
			
			(   select id,mc,comp,opn,opr,D.threshold,
				case when autodata.sttime<@Starttime then @Starttime else sttime END as sttime,
	       			case when ndtime>@EndTime then @EndTime else ndtime END as ndtime
				from #T_autodata autodata
				inner join downcodeinformation D
				on autodata.dcode=D.interfaceid where autodata.datatype=2 AND
				(
				(autodata.sttime>=@Starttime  and  autodata.ndtime<=@EndTime)
				OR (autodata.sttime<@Starttime and  autodata.ndtime>@Starttime and autodata.ndtime<=@EndTime)
				OR (autodata.sttime>=@Starttime  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)
				OR (autodata.sttime<@Starttime and autodata.ndtime>@EndTime )
				) AND (D.availeffy = 1)) as T1 	
			left outer join
			(SELECT autodata.id,
					   sum(CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM #T_autodata AutoData CROSS jOIN #PlannedDownTimes T inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid
				WHERE autodata.DataType=2 AND T.MachineInterface=autodata.mc AND
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)
					AND (downcodeinformation.availeffy = 1) group  by autodata.id ) as T2 on T1.id=T2.id ) as T3  group by T3.mc
			) as t4 inner join #CockpitData on t4.mc = #CockpitData.machineinterface
			UPDATE #CockpitData SET downtime = isnull(downtime,0)+isnull(ManagementLoss,0)+isNull(MLDown,0)
		END

		---mod 4: Till here Handling interaction between PDT and downtime . Also interaction between PDT and Management Loss
		---mod 4:If Ignore_Dtime_4m_PLD<> Y and Ignore_Dtime_4m_PLD<> N
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'Y' AND (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'N'
		BEGIN
			UPDATE #PLD set dPlannedDT =isnull(dPlannedDT,0) + isNull(TT.PPDT ,0)
			FROM(
				--Production PDT
				SELECT autodata.MC, SUM
					   (CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM #T_autodata AutoData CROSS jOIN #PlannedDownTimes T
				Inner Join DownCodeInformation D ON AutoData.DCode = D.InterfaceID
				WHERE autodata.DataType=2 AND T.MachineInterface=autodata.mc AND D.DownID=(SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD') AND
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)
				group by autodata.mc
			) as TT INNER JOIN #PLD ON TT.mc = #PLD.MachineInterface
		END

		--************************************ Down and Management  Calculation Ends ******************************************
		---mod 4
		-- Get the value of CN
		-- Type 1
		/* Changed by SSK to Combine SubOperations*/
		UPDATE #CockpitData SET CN = isnull(CN,0) + isNull(t2.C1N1,0)
		from
		(select mc,
		SUM((componentoperationpricing.cycletime/ISNULL(ComponentOperationPricing.SubOperations,1))* autodata.partscount) C1N1
		FROM #T_autodata autodata INNER JOIN
		componentoperationpricing ON autodata.opn = componentoperationpricing.InterfaceID INNER JOIN
		componentinformation ON autodata.comp = componentinformation.InterfaceID AND
		componentoperationpricing.componentid = componentinformation.componentid
		--mod 2
		inner join machineinformation on machineinformation.interfaceid=autodata.mc
		and componentoperationpricing.machineid=machineinformation.machineid
		--mod 2
		where (((autodata.sttime>=@Starttime)and (autodata.ndtime<=@EndTime)) or
		((autodata.sttime<@Starttime)and (autodata.ndtime>@Starttime)and (autodata.ndtime<=@EndTime)) )
		and (autodata.datatype=1)
		group by autodata.mc
		) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface

		-- mod 4 Ignore count from CN calculation which is over lapping with PDT
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #CockpitData SET CN = isnull(CN,0) - isNull(t2.C1N1,0)
			From
			(
				select mc,SUM((O.cycletime * ISNULL(A.PartsCount,1))/ISNULL(O.SubOperations,1))  C1N1
				From #T_autodata A
				Inner join machineinformation M on M.interfaceid=A.mc
				Inner join componentinformation C ON A.Comp=C.interfaceid
				Inner join ComponentOperationPricing O ON A.Opn=O.interfaceid AND C.Componentid=O.componentid And O.MachineID = M.MachineID
				Cross jOIN #PlannedDownTimes T
				WHERE A.DataType=1 AND T.MachineInterface=A.mc
				AND(A.ndtime > T.StartTime  AND A.ndtime <=T.EndTime)
				AND(A.ndtime > @Starttime  AND A.ndtime <=@EndTime)
				Group by mc
			) as T2
			inner join #CockpitData  on t2.mc = #CockpitData.machineinterface
		END

			----ER0506 Included For GEA 0n 07/06/2021
			UPDATE #CockpitData SET CN = isNull(t2.C1N1,0)
			from
			(select mc,SUM((T.cycletime/ISNULL(T.SubOperations,1))* T.partscount) C1N1
			FROM 
			(Select A.mc,A.comp,A.opn,A.WorkorderNumber,A.CompSlNo,SUM(M1.Stdcycletime) as cycletime,O.SubOperations,A.PartsCount from #T_autodata A
			inner join machineinformation M on M.interfaceid=A.mc
			INNER JOIN componentinformation C ON A.comp = C.InterfaceID
			Inner join ComponentOperationPricing O ON A.Opn=O.interfaceid AND C.Componentid=O.componentid And O.MachineID = M.MachineID
			inner join AssemblyActivitySchedules_GEA R on O.Machineid=R.machineid and O.componentid=R.MaterialID and O.operationno=R.operationno and A.WorkorderNumber=R.ProductionOrder AND A.CompSlNo=R.FabricationNo
			inner join AssemblyActivityMaster_GEA M1 on R.Machineid=M1.Station and R.activity=M1.Activity and R.MaterialID=M1.Componentid
			where M.Process in('Assembly','Packing','Testing') and ((A.sttime>=@StartTime and A.ndtime<=@EndTime) or
			(A.sttime<@StartTime and A.ndtime>@StartTime and A.ndtime<=@EndTime)) and A.datatype=1
			Group by A.mc,A.comp,A.opn,A.WorkorderNumber,A.CompSlNo,O.SubOperations,A.PartsCount)T 
			group by T.mc
			) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface Where #CockpitData.Process in('Assembly','Packing','Testing')

			-- mod 4 Ignore count from CN calculation which is over lapping with PDT
			If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
			BEGIN
				UPDATE #CockpitData SET CN = isnull(CN,0) - isNull(t2.C1N1,0)
				From
				(
					select mc,SUM((T.cycletime/ISNULL(T.SubOperations,1))* T.partscount) C1N1
					FROM 
					(Select A.mc,A.comp,A.opn,A.WorkorderNumber,A.CompSlNo,SUM(M1.Stdcycletime) as cycletime,O.SubOperations,A.PartsCount from #T_autodata A
					inner join machineinformation M on M.interfaceid=A.mc
					INNER JOIN componentinformation C ON A.comp = C.InterfaceID
					Inner join ComponentOperationPricing O ON A.Opn=O.interfaceid AND C.Componentid=O.componentid And O.MachineID = M.MachineID
					inner join AssemblyActivitySchedules_GEA R on O.Machineid=R.machineid and O.componentid=R.MaterialID and O.operationno=R.operationno and A.WorkorderNumber=R.ProductionOrder AND A.CompSlNo=R.FabricationNo
					inner join AssemblyActivityMaster_GEA M1 on R.Machineid=M1.Station and R.activity=M1.Activity and R.MaterialID=M1.Componentid
					Cross jOIN #PlannedDownTimes T
					where M.Process in('Assembly','Packing','Testing') and ((A.sttime>=@StartTime and A.ndtime<=@EndTime) or
					(A.sttime<@StartTime and A.ndtime>@StartTime and A.ndtime<=@EndTime))
					AND(A.ndtime > T.StartTime  AND A.ndtime <=T.EndTime)
					and A.datatype=1 AND T.MachineInterface=A.mc
					Group by A.mc,A.comp,A.opn,A.WorkorderNumber,A.CompSlNo,O.SubOperations,A.PartsCount)T 
					group by T.mc
				) as T2 inner join #CockpitData  on t2.mc = #CockpitData.machineinterface Where #CockpitData.Process in('Assembly','Packing','Testing')
			END
			----ER0506 Included For GEA 0n 07/06/2021

		--Calculation of PartsCount Begins..
		UPDATE #CockpitData SET components = ISNULL(components,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM(CEILING (CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			---mod 2
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid
			---mod 2
			GROUP BY mc
		) As T2 Inner join #CockpitData on T2.mc = #CockpitData.machineinterface

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #CockpitData SET components = ISNULL(components,0) - ISNULL(T2.comp,0) from(
				select mc,SUM(CEILING (CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
					select mc,Sum(ISNULL(PartsCount,1))AS OrginalCount,comp,opn from #T_autodata autodata
					CROSS JOIN #PlannedDownTimes T
					WHERE autodata.DataType=1 And T.MachineInterface = autodata.mc
					AND (autodata.ndtime > T.StartTime  AND autodata.ndtime <=T.EndTime)
					AND (autodata.ndtime > @Starttime  AND autodata.ndtime <=@EndTime)
					Group by mc,comp,opn
				) as T1
			Inner join Machineinformation M on M.interfaceID = T1.mc
			Inner join componentinformation C on T1.Comp=C.interfaceid
			Inner join ComponentOperationPricing O ON T1.Opn=O.interfaceid and C.Componentid=O.componentid and O.MachineID = M.MachineID
			GROUP BY MC
			) as T2 inner join #CockpitData on T2.mc = #CockpitData.machineinterface
		END

		UPDATE #CockpitData
			SET UtilisedTime=(UtilisedTime-ISNULL(#PLD.pPlannedDT,0)+isnull(#PLD.IPlannedDT,0)),
				DownTime=(DownTime-ISNULL(#PLD.dPlannedDT,0))
			From #CockpitData Inner Join #PLD on #PLD.Machineid=#CockpitData.Machineid

		-- Calculate efficiencies
		UPDATE #CockpitData
		SET
			ProductionEfficiency = (CN/UtilisedTime) ,
			AvailabilityEfficiency = (UtilisedTime)/(UtilisedTime + DownTime - ManagementLoss),
			TotalTime = DateDiff(second, @Starttime, @EndTime)
		WHERE UtilisedTime <> 0

		UPDATE #CockpitData
		SET
			OverAllEfficiency = Round((ProductionEfficiency * AvailabilityEfficiency)*100,0),
			ProductionEfficiency = Round(ProductionEfficiency * 100,0) ,
			AvailabilityEfficiency = Round(AvailabilityEfficiency * 100,0)

----------------------------------Target count--------------------------------------------------
Select @strsql=''   
	Select @strsql= 'insert into #Target(MachineID,machineinterface,Component,Compinterface,Operation,Opninterface,Operator,OprInterface,  
	msttime,ndtime,FromTm,Totm,batchid,autodataid,stdtime)'  
	select @strsql = @strsql + ' SELECT machineinformation.machineid, machineinformation.interfaceid,C.componentid, C.interfaceid,  
	O.operationno, O.interfaceid, E.Employeeid,E.interfaceid, 
	Case when autodata.msttime< ''' + convert(nvarchar(20),@Starttime)+''' then ''' + convert(nvarchar(20),@Starttime)+''' else autodata.msttime end,   
	Case when autodata.ndtime> ''' + convert(nvarchar(20),@Starttime)+''' then ''' + convert(nvarchar(20),@Starttime)+''' else autodata.ndtime end,  
	''' + convert(nvarchar(20),@Starttime)+''',''' + convert(nvarchar(20),@Endtime)+''',0,autodata.id,O.Cycletime 
	FROM #T_autodata  autodata  
	INNER JOIN  machineinformation ON autodata.mc = machineinformation.InterfaceID   
	INNER JOIN componentinformation C ON autodata.comp = C.InterfaceID    
	INNER JOIN componentoperationpricing O ON autodata.opn = O.InterfaceID  
	INNER JOIN EmployeeInformation E ON autodata.opr = E.InterfaceID 
	AND c.componentid = O.componentid and O.machineid=machineinformation.machineid   
	Left Outer Join downcodeinformation DI on DI.interfaceid=autodata.dcode  
	Left Outer Join PlantMachine ON PlantMachine.MachineID=Machineinformation.machineid   
	WHERE ((autodata.msttime >= ''' + convert(nvarchar(20),@Starttime)+'''  AND autodata.ndtime <= ''' + convert(nvarchar(20),@Endtime)+''')  
	OR ( autodata.msttime < ''' + convert(nvarchar(20),@Starttime)+'''  AND autodata.ndtime <= ''' + convert(nvarchar(20),@Endtime)+''' AND autodata.ndtime >''' + convert(nvarchar(20),@Starttime)+''' )  
	OR ( autodata.msttime >= ''' + convert(nvarchar(20),@Starttime)+''' AND autodata.msttime < ''' + convert(nvarchar(20),@Endtime)+''' AND autodata.ndtime > ''' + convert(nvarchar(20),@Endtime)+''')  
	OR ( autodata.msttime < ''' + convert(nvarchar(20),@Starttime)+''' AND autodata.ndtime > ''' + convert(nvarchar(20),@Endtime)+'''))'  
	select @strsql = @strsql  + @strPlantID
	select @strsql = @strsql + ' order by autodata.msttime'  
	print @strsql 
	exec (@strsql)  
	
insert into #FinalTarget (MachineID,Component,operation,Operator,machineinterface,Compinterface,Opninterface,Oprinterface,BatchStart,BatchEnd,
	FromTm,ToTm,stdtime,shift,batchid,Target,runtime)
	select MachineID,Component,operation,Operator,machineinterface,Compinterface,Opninterface,Oprinterface,min(msttime),max(ndtime),
	FromTm,ToTm,stdtime,shift,batchid,0,datediff(s,min(msttime),max(ndtime))
	from
	(
	select MachineID,Component,operation,Operator,machineinterface,Compinterface,Opninterface,Oprinterface,msttime,ndtime,FromTm,ToTm,stdtime,shift,
	RANK() OVER (
	  PARTITION BY t.machineid
	  order by t.machineid, t.msttime
	) -
	RANK() OVER (
	  PARTITION BY  t.machineid, t.component, t.operation, t.operator, t.fromtm 
	  order by t.machineid, t.fromtm, t.msttime
	) AS batchid
	from #Target t 
	) tt
	group by MachineID,Component,operation,Operator,machineinterface,Compinterface,Opninterface,Oprinterface,batchid,FromTm,ToTm,stdtime,shift 
	order by tt.batchid


If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Ptime_4m_PLD')<>'N'    
BEGIN    

   Update #FinalTarget set Runtime=Isnull(Runtime,0) - Isnull(T3.pdt,0)     
	from (    
	Select t2.machineinterface,T2.MachineID,T2.BatchStart,T2.BatchEnd,T2.Fromtm,sum(datediff(ss,T2.StartTimepdt,t2.EndTimepdt))as pdt    
	from    
	(    
	Select T1.machineinterface,T1.Compinterface,T1.Opninterface,T1.BatchStart,T1.BatchEnd,T1.FromTm,Pdt.MachineID,    
	Case when  T1.BatchStart <= pdt.StartTime then pdt.StartTime else T1.BatchStart End as StartTimepdt,    
	Case when  T1.BatchEnd >= pdt.EndTime then pdt.EndTime else T1.BatchEnd End as EndTimepdt    
	from #FinalTarget T1    
	inner join #PlannedDownTimes pdt on t1.machineid=Pdt.MachineID    
	where     
	((pdt.StartTime >= t1.BatchStart and pdt.EndTime <= t1.BatchEnd)or    
	(pdt.StartTime < t1.BatchStart and pdt.EndTime > t1.BatchStart and pdt.EndTime <=t1.BatchEnd)or    
	(pdt.StartTime >= t1.BatchStart and pdt.StartTime <t1.BatchEnd and pdt.EndTime >t1.BatchEnd) or    
	(pdt.StartTime <  t1.BatchStart and pdt.EndTime >t1.BatchEnd))    
	)T2 group by  t2.machineinterface,T2.MachineID,T2.BatchStart,T2.BatchEnd,T2.Fromtm    
	) T3 inner join #FinalTarget T on T.machineinterface=T3.machineinterface and T.BatchStart=T3.BatchStart and  T.BatchEnd=T3.BatchEnd and T.Fromtm=T3.Fromtm    

END   
  
	Update #FinalTarget set Target = Isnull(Target,0) + isnull(T2.targetcount,0) from     
		(    
		Select T.machineinterface,T.Compinterface,T.Opninterface,T.FromTm,T.BatchStart,T.BatchEnd,
		sum(((T.Runtime*CO.suboperations)/CO.cycletime)*isnull(CO.targetpercent,100) /100) as targetcount    
		from #FinalTarget T     
		inner join machineinformation M on M.Interfaceid=T.machineinterface    
		inner join componentinformation C on C.interfaceid=T.Compinterface    
		inner join componentoperationpricing CO on M.machineid=co.machineid and c.componentid=Co.componentid    
		and Co.interfaceid=T.Opninterface    
		group by T.FromTm,T.BatchStart,T.BatchEnd,T.machineinterface,T.Compinterface,T.Opninterface   
		)T2 Inner Join #FinalTarget on t2.machineinterface = #FinalTarget.machineinterface and  
		t2.compinterface = #FinalTarget.compinterface and t2.opninterface = #FinalTarget.opninterface 
		and #FinalTarget.BatchStart=T2.BatchStart and  #FinalTarget.BatchEnd=T2.BatchEnd and #FinalTarget.Fromtm=T2.Fromtm

Update #CockpitData set Target = Isnull(Target,0) + isnull(T1.TCount,0) from 
	(   select machineinterface,
		FLOOR(sum(isnull(Target,0))) as TCount,
		sum(isnull(Runtime,0)) as Runtime from 
		#FinalTarget
		group by machineinterface
	 )T1 inner join #CockpitData on #CockpitData.MachineInterface=T1.machineinterface 
---------------------------------------------------------------------------


------------------------------------------------------------------------------------
		
END
			
IF @param = '1st screen'
BEGIN

PRINT '-- 1ST SCREEN----'

	-------------------------------------------------------------------------------------------------------------------
		/* Maximum Down Reason Time ,Calculation as goes down*/
		---Irrespective of whether the down is management loss or genuine down we are considering the down reason which is the largest
		----------------------------------------------------------------------------------------------------------------------
		--mod 4 commented till here  for Optimization
		select @strsql = ''
		select @strsql = 'INSERT INTO #DownTimeData (MachineID,McInterfaceid, DownID, DownTime,DownFreq) SELECT Machineinformation.MachineID AS MachineID,Machineinformation.interfaceid, downcodeinformation.downid AS DownID, 0,0'
		select @strsql = @strsql+' FROM Machineinformation CROSS JOIN downcodeinformation LEFT OUTER JOIN PlantMachine ON PlantMachine.MachineID=Machineinformation.MachineID '
		select @strsql = @strsql+' Where MachineInformation.interfaceid > ''0'' '
		select @strsql = @strsql + @strPlantID  + ' ORDER BY  downcodeinformation.downid, Machineinformation.MachineID'
		exec (@strsql)
		--********************************************* Get Down Time Details *******************************************************
		--Type 1,2,3 and 4.
		select @strsql = ''
		select @strsql = @strsql + 'UPDATE #DownTimeData SET downtime = isnull(DownTime,0) + isnull(t2.down,0) '
		select @strsql = @strsql + ' FROM'
		select @strsql = @strsql + ' (SELECT mc,--count(mc)as dwnfrq,
		SUM(CASE
		WHEN (autodata.sttime>='''+convert(varchar(20),@Starttime)+''' and autodata.ndtime<='''+convert(varchar(20),@endtime)+''' ) THEN loadunload
		WHEN (autodata.sttime<'''+convert(varchar(20),@Starttime)+''' and autodata.ndtime>'''+convert(varchar(20),@Starttime)+'''and autodata.ndtime<='''+convert(varchar(20),@endtime)+''') THEN DateDiff(second, '''+convert(varchar(20),@Starttime)+''', ndtime)
		WHEN (autodata.sttime>='''+convert(varchar(20),@Starttime)+'''and autodata.sttime<'''+convert(varchar(20),@endtime)+''' and autodata.ndtime>'''+convert(varchar(20),@endtime)+''') THEN DateDiff(second, stTime, '''+convert(varchar(20),@Endtime)+''')
		ELSE DateDiff(second,'''+convert(varchar(20),@Starttime)+''','''+convert(varchar(20),@endtime)+''')
		END) as down
		,downcodeinformation.downid as downid'
		select @strsql = @strsql + ' from'
		select @strsql = @strsql + '  #T_autodata autodata INNER JOIN'
		select @strsql = @strsql + ' machineinformation ON autodata.mc = machineinformation.InterfaceID Left Outer Join PlantMachine ON PlantMachine.MachineID=machineinformation.MachineID INNER JOIN'
		select @strsql = @strsql + ' componentinformation ON autodata.comp = componentinformation.InterfaceID INNER JOIN'
		select @strsql = @strsql + ' employeeinformation ON autodata.opr = employeeinformation.interfaceid INNER JOIN'
		select @strsql = @strsql + ' downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid'
		select @strsql = @strsql + ' where  datatype=2 AND ((autodata.sttime>='''+convert(varchar(20),@Starttime)+''' and autodata.ndtime<='''+convert(varchar(20),@endtime)+''' )OR
		(autodata.sttime<'''+convert(varchar(20),@Starttime)+''' and autodata.ndtime>'''+convert(varchar(20),@Starttime)+'''and autodata.ndtime<='''+convert(varchar(20),@endtime)+''')OR
		(autodata.sttime>='''+convert(varchar(20),@Starttime)+'''and autodata.sttime<'''+convert(varchar(20),@endtime)+''' and autodata.ndtime>'''+convert(varchar(20),@endtime)+''')OR
		(autodata.sttime<'''+convert(varchar(20),@Starttime)+''' and autodata.ndtime>'''+convert(varchar(20),@endtime)+'''))'
		select @strsql = @strsql  + @strPlantID 
		select @strsql = @strsql + ' group by autodata.mc,downcodeinformation.downid )'
		select @strsql = @strsql + ' as t2 inner join #DownTimeData on t2.mc=#DownTimeData.McInterfaceid and t2.downid=#DownTimeData.downid'
		exec (@strsql)
		--*********************************************************************************************************************
		--mod 4
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='Y'
		BEGIN
			UPDATE #DownTimeData set DownTime =isnull(DownTime,0) - isNull(TT.PPDT ,0)
			FROM(
				--Production PDT
				SELECT autodata.MC,DownID, SUM
					   (CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM #T_autodata AutoData CROSS jOIN #PlannedDownTimes T
				Inner Join DownCodeInformation On AutoData.DCode=DownCodeInformation.InterfaceID
				WHERE autodata.DataType=2 AND T.MachineInterface = AutoData.mc And
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)
				group by autodata.mc,DownID
			) as TT INNER JOIN #DownTimeData ON TT.mc = #DownTimeData.McInterfaceid AND #DownTimeData.DownID=TT.DownId
			Where #DownTimeData.DownTime>0
		END

		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'Y' AND (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'N'
		BEGIN
			UPDATE #DownTimeData set DownTime =isnull(DownTime,0) - isNull(TT.PPDT ,0)
			FROM(
				--Production PDT
				SELECT autodata.MC,DownId, SUM
					   (CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM #T_autodata AutoData CROSS jOIN #PlannedDownTimes T
				Inner Join DownCodeInformation D ON AutoData.DCode = D.InterfaceID
				WHERE autodata.DataType=2 And T.MachineInterface = AutoData.mc AND D.DownID=(SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD') AND
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)
				group by autodata.mc,DownId
			) as TT INNER JOIN #DownTimeData ON TT.mc = #DownTimeData.McInterfaceid AND #DownTimeData.DownID=TT.DownId
			Where #DownTimeData.DownTime>0
		END

		--mod 4 commented till here for Optimization
		---mod 4 Update for MaxDownReasonTime
		Update #CockpitData SET MaxDownReason = MaxDReason,MaxDowntime=MaxDTime
		From (select A.MachineID as MachineID,
		A.DownID as MaxDReason,A.DownTime as MaxDTime
		FROM #DownTimeData A
		INNER JOIN (SELECT B.machineid,MAX(B.DownTime)as DownTime FROM #DownTimeData B group by machineid) as T2
		ON A.MachineId = T2.MachineId and A.DownTime = t2.DownTime
		Where A.DownTime > 0
		)as T3 inner join #CockpitData on T3.MachineID = #CockpitData.MachineID

		select @strsql=''
		SELECT @strsql= @strsql + 'insert into #Runningpart_Part(Machineid,Operatorid,StTime)  
		  select Machineinformation.machineid,E.Employeeid,Max(A.StTime) as Sttime from #T_autodata A  
		  inner join Machineinformation on A.mc=Machineinformation.interfaceid  
		  inner join Employeeinformation E on A.Opr=E.interfaceid  
		  where ndtime>'''+convert(nvarchar(20),@Starttime)+''' and ndtime<='''+convert(nvarchar(20),@endtime)+'''   '  
		SELECT @strsql = @strsql   
		SELECT @strsql = @strsql +'group by Machineinformation.Machineid,E.Employeeid Order by Machineinformation.machineid'
		print @strsql
		exec (@strsql) 

		Update #CockpitData SET Operatorid = isnull(#CockpitData.Operatorid,'') + isnull(T1.Operatorid,'') from
		(Select Machineid,Operatorid from #Runningpart_Part)T1
		inner join #CockpitData on T1.MachineID = #CockpitData.MachineID
		
	SELECT
		Plantid,
		MachineID,
		ColorCode,
		HelpCode1,HelpCode2,HelpCode3,HelpCode4,
		Utilisedtime,
		ProductionEfficiency,
		AvailabilityEfficiency,
		OverAllEfficiency,
		Components,
		Round(Target,0) as Planned,
		PEGreen,
		PERed,
		AEGreen,
		AERed,
		OEGreen,
		OERed
	FROM #CockpitData where (Plantid=@PlantID or isnull(@PlantID,'')='')
	order by Plantid,machineid asc

		SELECT
		Plantid,
		MachineID,
		OverAllEfficiency,
		Components,
		Utilisedtime,
		e.Name as Operatorid,
		MaxDownReason,
		Case when MaxDownReason = '' then ''
		when substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),1,charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))-1) = '0' 
		then substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))+1,len(dbo.f_FormatTime(MaxDowntime,'hh:mm'))) + ' mins ' 
		when substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))+1,len(dbo.f_FormatTime(MaxDowntime,'hh:mm')))= '0'
		then substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),1,charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))-1) + ' hrs '
		else substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),1,charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))-1) + ' hrs ' +
		substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))+1,len(dbo.f_FormatTime(MaxDowntime,'hh:mm'))) + ' mins ' 
		end as MaxDowntime
		FROM #CockpitData
		left outer join employeeinformation e on e.Employeeid=#CockPitData.Operatorid
		where OverAllEfficiency>0	and  (Plantid=@PlantID or isnull(@PlantID,'')='')	
		order by OverAllEfficiency desc

	SELECT
		Plantid,
		MachineID,
		OverAllEfficiency,
		Components,
		Utilisedtime,
		e.Name as Operatorid,
		MaxDownReason,
		Case when MaxDownReason = '' then ''
		when substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),1,charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))-1) = '0' 
		then substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))+1,len(dbo.f_FormatTime(MaxDowntime,'hh:mm'))) + ' mins ' 
		when substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))+1,len(dbo.f_FormatTime(MaxDowntime,'hh:mm')))= '0'
		then substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),1,charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))-1) + ' hrs '
		else substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),1,charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))-1) + ' hrs ' +
		substring(dbo.f_FormatTime(MaxDowntime,'hh:mm'),charindex(':',dbo.f_FormatTime(MaxDowntime,'hh:mm'))+1,len(dbo.f_FormatTime(MaxDowntime,'hh:mm'))) + ' mins ' 
		end as MaxDowntime
		FROM #CockpitData
	   left outer join employeeinformation e on e.Employeeid=#CockPitData.Operatorid
       where OverAllEfficiency>0 and (Plantid=@PlantID or isnull(@PlantID,'')='')
		order by OverAllEfficiency 
END


If @Param= '2nd Screen'
BEGIN

declare @CurStrtTime as datetime
select @CurStrtTime=@Starttime

while @CurStrtTime<=@Endtime
BEGIN
	INSERT #ShiftTemp(PDate,ShiftName, FromTime, ToTime)
	EXEC s_GetShiftTime @CurStrtTime,''
	SELECT @CurStrtTime=DATEADD(DAY,1,@CurStrtTime)
END

UPDATE #ShiftTemp
set Shiftid = S.SHIFTID
FROM (SELECT SHIFTID,ShiftName from shiftdetails where running = 1) S
INNER JOIN #ShiftTemp ST ON ST.ShiftName = S.ShiftName

insert into #HourDetails(PDate,ShiftName,ShiftID,ShiftStart,ShiftEnd,HourName,HourID,HourStart,HourEnd)
select S.PDate,S.ShiftName,S.ShiftID,S.FromTime,S.ToTime,SH.Hourname,SH.HourID,
		dateadd(day,SH.Fromday,(convert(datetime, CONVERT ( NVARCHAR(50), CAST(S.FromTime AS DATE)) + ' ' + CAST(datePart(hh,SH.HourStart) AS nvarchar(2)) + ':' + CAST(datePart(mi,SH.HourStart) as nvarchar(2))+ ':' + CAST(datePart(ss,SH.HourStart) as nvarchar(2))))),
		dateadd(day,SH.Today,(convert(datetime, CONVERT ( NVARCHAR(50), CAST(S.FromTime AS DATE)) + ' ' + CAST(datePart(hh,SH.HourEnd) AS nvarchar(2)) + ':' + CAST(datePart(mi,SH.HourEnd) as nvarchar(2))+ ':' + CAST(datePart(ss,SH.HourEnd) as nvarchar(2)))))
		from (Select * from #ShiftTemp ) S 
		inner join Shifthourdefinition SH on SH.shiftid=S.Shiftid
		order by S.Shiftid,SH.Hourid

		 Select @strsql=''
		 select @strsql ='Insert into #HourlyData1(Machineid,FromTime,ToTime,Actual,Target,TargetTotal,ActualTotal)'
		 select @strsql = @strsql + ' Select Machineinformation.Machineid,H.HourStart,H.HourEnd,0,0,0,0
									  from Machineinformation 
									  inner join Plantmachine on Plantmachine.machineid=Machineinformation.machineid 
									  CROSS JOIN #HourDetails H '
		 select @strsql = @strsql  + @strPlantID
		 SELECT @strSql = @strSql + 'order by H.HourStart,H.Hourid' 
		 print @strsql
		 exec (@strsql)
 
insert INTO #PlannedDownTimeshour(StartTime,EndTime,Machine,MachineInterface,Downreason,HourStart)
select
CASE When P.StartTime<T1.FromTime Then T1.FromTime Else P.StartTime End,
case When P.EndTime>T1.ToTime Then T1.ToTime Else P.EndTime End,Machine,M.InterfaceID,DownReason,T1.FromTime
FROM PlannedDownTimes P
cross join #HourlyData1 T1
inner join MachineInformation M on P.machine = M.MachineID
inner join Plantmachine on Plantmachine.machineid=M.machineid 
WHERE P.PDTstatus =1 and (
(P.StartTime >= T1.FromTime  AND P.EndTime <=T1.ToTime)
OR ( P.StartTime < T1.FromTime  AND P.EndTime <= T1.ToTime AND P.EndTime > T1.FromTime )
OR ( P.StartTime >= T1.FromTime   AND P.StartTime <T1.ToTime AND P.EndTime > T1.ToTime )
OR ( P.StartTime < T1.FromTime  AND P.EndTime > T1.ToTime) )
and machine=T1.Machineid
ORDER BY P.StartTime

	Update #HourlyData1 set Totime = Case When T.Totim>@DateTime then @DateTime Else T.Totim end from
	(select Machineid,Fromtime,Totime as totim from #HourlyData1 where @DateTime between Fromtime and Totime)T 
	inner join #HourlyData1 H on T.Machineid=H.Machineid and t.Fromtime=H.Fromtime

	Insert into #HourlyData(Machineid,FromTime,ToTime,Actual,Target,TargetTotal,ActualTotal)
	select Machineid,FromTime,ToTime,Actual,Target,TargetTotal,ActualTotal from #HourlyData1
	Where Totime<=@DateTime

	Select @strsql=''
	select @strsql =' Update #HourlyData set Actual = Isnull(Actual,0) + Isnull(T1.Comp,0) from '
	select @strsql = @strsql + '(Select machineinformation.machineid,T.FromTime,T.ToTime,SUM(Isnull(A.partscount,1)/ISNULL(O.SubOperations,1)) As Comp
	from #T_autodata A WITH (NOLOCK)  
	Inner join machineinformation on machineinformation.interfaceid=A.mc
	inner join Plantmachine on Plantmachine.machineid=Machineinformation.machineid
	Inner join #HourlyData T on T.machineid=machineinformation.machineid
	Inner join componentinformation C ON A.Comp=C.interfaceid
	Inner join ComponentOperationPricing O WITH (NOLOCK) ON A.Opn=O.interfaceid AND C.Componentid=O.componentid And O.MachineID = machineinformation.MachineID
	WHERE A.DataType=1 AND (A.ndtime > T.FromTime  AND A.ndtime <=T.ToTime)'
	select @strsql = @strsql  + @strPlantID
	select @strsql = @strsql + ' Group by machineinformation.machineid,T.FromTime,T.ToTime)T1 inner join #HourlyData on #HourlyData.FromTime=T1.FromTime
	and #HourlyData.ToTime=T1.ToTime and #HourlyData.machineid=T1.machineid'
	print @strsql
	exec (@strsql)

	If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
	BEGIN
		
		Select @strsql=''
		select @strsql =' Update #HourlyData set Actual = Isnull(Actual,0) - Isnull(T1.Comp,0) from '
		select @strsql = @strsql + '(Select machineinformation.machineid,T1.FromTime,T1.ToTime,SUM(Isnull(A.partscount,1)/ISNULL(O.SubOperations,1)) As Comp
		from #T_autodata A WITH (NOLOCK)  ----ER0377 Added LOCK
		Inner join machineinformation on machineinformation.interfaceid=A.mc
		inner join Plantmachine on Plantmachine.machineid=Machineinformation.machineid
		Inner join #HourlyData T1 on T1.machineid=machineinformation.machineid
		Inner join componentinformation C ON A.Comp=C.interfaceid
		Inner join ComponentOperationPricing O WITH (NOLOCK) ON A.Opn=O.interfaceid AND C.Componentid=O.componentid And O.MachineID = machineinformation.MachineID
		CROSS jOIN PlannedDownTimes T
		WHERE A.DataType=1 and T.machine=T1.Machineid
		AND(A.ndtime > T1.FromTime  AND A.ndtime <=T1.ToTime)
		AND(A.ndtime > T.StartTime  AND A.ndtime <=T.EndTime)'
		select @strsql = @strsql + @strPlantID		
		select @strsql = @strsql + ' Group by machineinformation.machineid,T1.FromTime,T1.ToTime)T1 inner join #HourlyData on #HourlyData.FromTime=T1.FromTime
		and #HourlyData.ToTime=T1.ToTime and #HourlyData.machineid=T1.machineid	'
		print @strsql
		exec (@strsql)

	END

-------------------------------------Hourly target------------------------------------------------
DELETE FROM #Target
DELETE FROM #FinalTarget
	
Select @strsql=''   
	Select @strsql= 'insert into #Target(MachineID,machineinterface,Component,Compinterface,Operation,Opninterface,Operator,OprInterface,  
	msttime,ndtime,FromTm,Totm,batchid,autodataid,stdtime,Shift)'  
	select @strsql = @strsql + ' SELECT  machineinformation.machineid, machineinformation.interfaceid,C.componentid, C.interfaceid,  
		O.operationno, O.interfaceid,E.Employeeid,E.interfaceid, 
		Case when autodata.msttime< T.Hourstart then T.Hourstart else autodata.msttime end,   
		Case when autodata.ndtime> T.HourEnd then T.HourEnd else autodata.ndtime end,  
		T.Hourstart,T.HourEnd,0,autodata.id,O.Cycletime,T.ShiftName 
		FROM #T_autodata  autodata  
		INNER JOIN  machineinformation ON autodata.mc = machineinformation.InterfaceID   
		INNER JOIN componentinformation C ON autodata.comp = C.InterfaceID    
		INNER JOIN componentoperationpricing O ON autodata.opn = O.InterfaceID  
		AND c.componentid = O.componentid and O.machineid=machineinformation.machineid
		INNER JOIN employeeinformation E ON Autodata.opr = E.interfaceid   
		Left Outer Join downcodeinformation DI on DI.interfaceid=autodata.dcode  
		Left Outer Join PlantMachine ON PlantMachine.MachineID=Machineinformation.machineid   
		Cross join #HourDetails T  
		WHERE ((autodata.msttime >= T.Hourstart  AND autodata.ndtime <= T.HourEnd)  
		OR ( autodata.msttime < T.Hourstart  AND autodata.ndtime <= T.HourEnd AND autodata.ndtime >T.Hourstart )  
		OR ( autodata.msttime >= T.Hourstart AND autodata.msttime <T.HourEnd AND autodata.ndtime > T.HourEnd)  
		OR ( autodata.msttime < T.Hourstart AND autodata.ndtime > T.HourEnd)) '  
	select @strsql = @strsql  + @strPlantID
	select @strsql = @strsql + ' order by autodata.msttime '  
	print @strsql  
	exec (@strsql)  

insert into #FinalTarget (MachineID,Component,operation,Operator,machineinterface,Compinterface,Opninterface,Oprinterface,BatchStart,BatchEnd,
	FromTm,ToTm,stdtime,shift,batchid,Target,runtime)
	select MachineID,Component,operation,Operator,machineinterface,Compinterface,Opninterface,Oprinterface,min(msttime),max(ndtime),
	FromTm,ToTm,stdtime,shift,batchid,0,datediff(s,min(msttime),max(ndtime))
	from
	(
	select MachineID,Component,operation,Operator,machineinterface,Compinterface,Opninterface,Oprinterface,msttime,ndtime,FromTm,ToTm,stdtime,shift,
	RANK() OVER (
	  PARTITION BY t.machineid
	  order by t.machineid, t.msttime
	) -
	RANK() OVER (
	  PARTITION BY  t.machineid, t.component, t.operation, t.operator, t.fromtm 
	  order by t.machineid, t.fromtm, t.msttime
	) AS batchid
	from #Target t 
	) tt
	group by MachineID,Component,operation,Operator,machineinterface,Compinterface,Opninterface,Oprinterface,batchid,FromTm,ToTm,stdtime,shift 
	order by tt.batchid


If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Ptime_4m_PLD')<>'N'    
BEGIN    

   Update #FinalTarget set Runtime=Isnull(Runtime,0) - Isnull(T3.pdt,0)     
	from (    
	Select t2.machineinterface,T2.Machine,T2.BatchStart,T2.BatchEnd,T2.Fromtm,sum(datediff(ss,T2.StartTimepdt,t2.EndTimepdt))as pdt    
	from    
	(    
	Select T1.machineinterface,T1.Compinterface,T1.Opninterface,T1.BatchStart,T1.BatchEnd,T1.FromTm,Pdt.machine,    
	Case when  T1.BatchStart <= pdt.StartTime then pdt.StartTime else T1.BatchStart End as StartTimepdt,    
	Case when  T1.BatchEnd >= pdt.EndTime then pdt.EndTime else T1.BatchEnd End as EndTimepdt    
	from #FinalTarget T1    
	inner join #PlannedDownTimeshour pdt on t1.machineid=Pdt.machine    
	where     
	((pdt.StartTime >= t1.BatchStart and pdt.EndTime <= t1.BatchEnd)or    
	(pdt.StartTime < t1.BatchStart and pdt.EndTime > t1.BatchStart and pdt.EndTime <=t1.BatchEnd)or    
	(pdt.StartTime >= t1.BatchStart and pdt.StartTime <t1.BatchEnd and pdt.EndTime >t1.BatchEnd) or    
	(pdt.StartTime <  t1.BatchStart and pdt.EndTime >t1.BatchEnd))    
	)T2 group by  t2.machineinterface,T2.Machine,T2.BatchStart,T2.BatchEnd,T2.Fromtm    
	) T3 inner join #FinalTarget T on T.machineinterface=T3.machineinterface and T.BatchStart=T3.BatchStart and  T.BatchEnd=T3.BatchEnd and T.Fromtm=T3.Fromtm    

END   
  
	Update #FinalTarget set Target = Isnull(Target,0) + isnull(T2.targetcount,0) from     
		(    
		Select T.machineinterface,T.Compinterface,T.Opninterface,T.FromTm,T.BatchStart,T.BatchEnd,
		sum(((T.Runtime*CO.suboperations)/CO.cycletime)*isnull(CO.targetpercent,100) /100) as targetcount    
		from #FinalTarget T     
		inner join machineinformation M on M.Interfaceid=T.machineinterface    
		inner join componentinformation C on C.interfaceid=T.Compinterface    
		inner join componentoperationpricing CO on M.machineid=co.machineid and c.componentid=Co.componentid    
		and Co.interfaceid=T.Opninterface    
		group by T.FromTm,T.BatchStart,T.BatchEnd,T.machineinterface,T.Compinterface,T.Opninterface   
		)T2 Inner Join #FinalTarget on t2.machineinterface = #FinalTarget.machineinterface and  
		t2.compinterface = #FinalTarget.compinterface and t2.opninterface = #FinalTarget.opninterface 
		and #FinalTarget.BatchStart=T2.BatchStart and  #FinalTarget.BatchEnd=T2.BatchEnd and #FinalTarget.Fromtm=T2.Fromtm
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
	Update #HourlyData set Target = Isnull(HD.Target,0) + isnull(T1.TCount,0) 
	from 
	(
	 
	 select machineinterface,Machineid,
		shift,FromTm, 
		FLOOR(sum(isnull(Target,0))) as TCount,
		sum(isnull(Runtime,0)) as Runtime from 
		#FinalTarget
		group by machineinterface,Machineid,shift,FromTm 	 
	 )T1 inner join #HourlyData HD on HD.machineid=T1.machineid and
	 HD.Fromtime=T1.FromTm 

	Update #HourlyData set TargetTotal = Isnull(TargetTotal,0) + isnull(T1.TCount,0),
							ActualTotal= Isnull(ActualTotal,0) + isnull(T1.ACount,0) 
					  from 
						(
						 Select machineid,Sum(Target) as Tcount,Sum(Actual) as Acount from #HourlyData
						 Group by machineid
						)T1 inner join #HourlyData on #HourlyData.machineid=T1.machineid

-------------------------------------------------------------
--------------------------output-----------------------------
-------------------------------------------------------------

	 SELECT
		Plantid,
		MachineID,
		ColorCode,
		HelpCode1,HelpCode2,HelpCode3,HelpCode4,
		Utilisedtime,
		ProductionEfficiency,
		AvailabilityEfficiency,
		OverAllEfficiency,
		Components,
		Round(Target,0) as Planned,
		PEGreen,
		PERed,
		AEGreen,
		AERed,
		OEGreen,
		OERed
	FROM #CockpitData
	where (Plantid=@PlantID or isnull(@plantid,'')='')
	order by Plantid,machineid asc

	SELECT
		Plantid,
		#CockpitData.machineid,
		Fromtime,
		Totime,
		Round(#HourlyData.Target,0) as Rated,
		Actual,
		Round(TargetTotal,0) as TargetTotal,
		ActualTotal
	FROM #CockpitData 
	inner join #HourlyData on #HourlyData.machineid=#CockpitData.machineid
	where (Plantid=@PlantID or isnull(@plantid,'')='')
	order by Plantid,#HourlyData.machineid,#HourlyData.Fromtime,#HourlyData.Totime

End



If @param = '3rd Screen'
BEGIN


/******************************* Utilised Calculation Starts ***************************************************/
		UPDATE #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) + isNull(t2.cycle,0)
		from
		(select      mc,sum(cycletime+loadunload) as cycle
		from autodata WITH (NOLOCK) 
		where (autodata.msttime>=@startMonth)
		and (autodata.ndtime<=@EndTime)
		and (autodata.datatype=1)
		group by autodata.mc
		) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
		-- Type 2
		UPDATE #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) + isNull(t2.cycle,0)
		from
		(select  mc,SUM(DateDiff(second, @startMonth, ndtime)) cycle
		from  autodata WITH (NOLOCK) 
		where (autodata.msttime<@startMonth)
		and (autodata.ndtime>@startMonth)
		and (autodata.ndtime<=@EndTime)
		and (autodata.datatype=1)
		group by autodata.mc
		) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
		-- Type 3
		UPDATE  #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) + isNull(t2.cycle,0)
		from
		(select  mc,sum(DateDiff(second, mstTime, @Endtime)) cycle
		from  autodata WITH (NOLOCK) 
		where (autodata.msttime>=@startMonth)
		and (autodata.msttime<@EndTime)
		and (autodata.ndtime>@EndTime)
		and (autodata.datatype=1)
		group by autodata.mc
		) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
		-- Type 4
		UPDATE #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) + isnull(t2.cycle,0)
		from
		(select mc,
		sum(DateDiff(second, @startMonth, @EndTime)) cycle from  autodata WITH (NOLOCK) -- ----ER0377 Added LOCK
		where (autodata.msttime<@startMonth)
		and (autodata.ndtime>@EndTime)
		and (autodata.datatype=1)
		group by autodata.mc
		)as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface

		/* Fetching Down Records from Production Cycle  */
		/* If Down Records of TYPE-2*/
		UPDATE  #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) - isNull(t2.Down,0)
		FROM
		(Select AutoData.mc ,
		SUM(
		CASE
			When autodata.sttime <= @startMonth Then datediff(s, @startMonth,autodata.ndtime )
			When autodata.sttime > @startMonth Then datediff(s , autodata.sttime,autodata.ndtime)
		END) as Down
		From  AutoData WITH (NOLOCK) INNER Join -- ----ER0377 Added LOCK
			(Select mc,Sttime,NdTime From  AutoData
				Where DataType=1 And DateDiff(Second,sttime,ndtime)>CycleTime And
				(msttime < @startMonth)And (ndtime > @startMonth) AND (ndtime <= @EndTime)) as T1
		ON AutoData.mc=T1.mc
		Where AutoData.DataType=2
		And ( autodata.Sttime > T1.Sttime )
		And ( autodata.ndtime <  T1.ndtime )
		AND ( autodata.ndtime >  @startMonth )
		GROUP BY AUTODATA.mc)AS T2 Inner Join #CockpitData on t2.mc = #CockpitData.machineinterface

		/* If Down Records of TYPE-3*/
		UPDATE  #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) - isNull(t2.Down,0)
		FROM
		(Select AutoData.mc ,
		SUM(CASE
			When autodata.ndtime > @EndTime Then datediff(s,autodata.sttime, @EndTime )
			When autodata.ndtime <=@EndTime Then datediff(s , autodata.sttime,autodata.ndtime)
		END) as Down
		From  AutoData WITH (NOLOCK) INNER Join -- ----ER0377 Added LOCK
			(Select mc,Sttime,NdTime From  AutoData
				Where DataType=1 And DateDiff(Second,sttime,ndtime)>CycleTime And
				(sttime >= @startMonth)And (ndtime > @EndTime) and (sttime<@EndTime) ) as T1
		ON AutoData.mc=T1.mc
		Where AutoData.DataType=2
		And (T1.Sttime < autodata.sttime  )
		And ( T1.ndtime >  autodata.ndtime)
		AND (autodata.sttime  <  @EndTime)
		GROUP BY AUTODATA.mc)AS T2 Inner Join #CockpitData on t2.mc = #CockpitData.machineinterface

		/* If Down Records of TYPE-4*/
		UPDATE  #CockpitData SET UtilisedTime = isnull(UtilisedTime,0) - isNull(t2.Down,0)
		FROM
		(Select AutoData.mc ,
		SUM(CASE
			When autodata.sttime >= @startMonth AND autodata.ndtime <= @EndTime Then datediff(s , autodata.sttime,autodata.ndtime)
			When autodata.sttime < @startMonth AND autodata.ndtime > @startMonth AND autodata.ndtime<=@EndTime Then datediff(s, @startMonth,autodata.ndtime )
			When autodata.sttime>=@startMonth And autodata.sttime < @EndTime AND autodata.ndtime > @EndTime Then datediff(s,autodata.sttime, @EndTime )
			When autodata.sttime<@startMonth AND autodata.ndtime>@EndTime   Then datediff(s , @startMonth,@EndTime)
		END) as Down
		From  AutoData WITH (NOLOCK) INNER Join -- ----ER0377 Added LOCK
			(Select mc,Sttime,NdTime From  AutoData
				Where DataType=1 And DateDiff(Second,sttime,ndtime)>CycleTime And
				(msttime < @startMonth)And (ndtime > @EndTime) ) as T1
		ON AutoData.mc=T1.mc
		Where AutoData.DataType=2
		And (T1.Sttime < autodata.sttime  )
		And ( T1.ndtime >  autodata.ndtime)
		AND (autodata.ndtime  >  @startMonth)
		AND (autodata.sttime  <  @EndTime)
		GROUP BY AUTODATA.mc
		)AS T2 Inner Join #CockpitData on t2.mc = #CockpitData.machineinterface

		--mod 4:Get utilised time over lapping with PDT.
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Ptime_4m_PLD')='Y'
		BEGIN

		------------------------------------  ----ER0377 Added  From Here ---------------------------------
			UPDATE #PLD set pPlannedDT =isnull(pPlannedDT,0) + isNull(TT.PPDT ,0)
			FROM(
				--Production Time in PDT
				SELECT autodata.MC,SUM
					(CASE
		--			WHEN autodata.msttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.cycletime+autodata.loadunload) --DR0325 Commented
					WHEN autodata.msttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN DateDiff(second,autodata.msttime,autodata.ndtime) --DR0325 Added
					WHEN ( autodata.msttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.msttime >= T.StartTime   AND autodata.msttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.msttime,T.EndTime )
					WHEN ( autodata.msttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END)  as PPDT
					FROM (select M.machineid,mc,msttime,ndtime from  autodata WITH (NOLOCK) -- ----ER0377 Added LOCK
						inner join machineinformation M on M.interfaceid=Autodata.mc
						 where autodata.DataType=1 And 
						((autodata.msttime >= @startMonth  AND autodata.ndtime <=@Endtime)
						OR ( autodata.msttime < @startMonth  AND autodata.ndtime <= @Endtime AND autodata.ndtime > @startMonth )
						OR ( autodata.msttime >= @startMonth   AND autodata.msttime <@Endtime AND autodata.ndtime > @Endtime )
						OR ( autodata.msttime < @startMonth  AND autodata.ndtime > @Endtime))
						)
				AutoData  inner jOIN #PlannedDownTimes T on T.Machineid=AutoData.machineid -- ----ER0377 Added LOCK
				WHERE 
					(
					(autodata.msttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.msttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.msttime >= T.StartTime   AND autodata.msttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.msttime < T.StartTime  AND autodata.ndtime > T.EndTime) )
				group by autodata.mc
			)
			 as TT INNER JOIN #PLD ON TT.mc = #PLD.MachineInterface

				--mod 4(4):Handle intearction between ICD and PDT for type 1 production record for the selected time period.
				UPDATE  #PLD set IPlannedDT =isnull(IPlannedDT,0) + isNull(T2.IPDT ,0) 	FROM	(
				Select T1.mc,SUM(
					CASE 	
						When T1.sttime >= T.StartTime  AND T1.ndtime <=T.EndTime  Then datediff(s , T1.sttime,T1.ndtime) ---type 1
						When T1.sttime < T.StartTime  and  T1.ndtime <= T.EndTime AND T1.ndtime > T.StartTime Then datediff(s, T.StartTime,T1.ndtime ) ---type 2
						When T1.sttime >= T.StartTime   AND T1.sttime <T.EndTime AND T1.ndtime > T.EndTime Then datediff(s, T1.sttime,T.EndTime ) ---type 3
						when T1.sttime < T.StartTime  AND T1.ndtime > T.EndTime Then datediff(s, T.StartTime,T.EndTime ) ---type 4
					END) as IPDT from
				(Select A.mc,(select machineid from machineinformation where interfaceid = A.mc)as machine, A.sttime, ndtime, 
				A.datatype from autodata A WITH (NOLOCK) -- ----ER0377 Added LOCK
				Where A.DataType=2
				and exists 
					(
					Select B.Sttime,B.NdTime,B.mc From autodata B WITH (NOLOCK) -- ----ER0377 Added LOCK
					Where B.mc = A.mc and
					B.DataType=1 And DateDiff(Second,B.sttime,B.ndtime)> B.CycleTime And
					(B.msttime >= @startMonth AND B.ndtime <= @Endtime) and
					(B.sttime < A.sttime) AND (B.ndtime > A.ndtime) 
					)
				 )as T1 inner join
				(select  machine,Case when starttime<@startMonth then @startMonth else starttime end as starttime, 
				case when endtime> @Endtime then @Endtime else endtime end as endtime from dbo.PlannedDownTimes 
				where ((( StartTime >=@startMonth) And ( EndTime <=@Endtime))
				or (StartTime < @startMonth  and  EndTime <= @Endtime AND EndTime > @startMonth)
				or (StartTime >= @startMonth  AND StartTime <@Endtime AND EndTime > @Endtime)
				or (( StartTime <@startMonth) And ( EndTime >@Endtime )) )
				)T
				on T1.machine=T.machine AND
				((( T.StartTime >=T1.Sttime) And ( T.EndTime <=T1.ndtime ))
				or (T.StartTime < T1.Sttime  and  T.EndTime <= T1.ndtime AND T.EndTime > T1.Sttime)
				or (T.StartTime >= T1.Sttime   AND T.StartTime <T1.ndtime AND T.EndTime > T1.ndtime )
				or (( T.StartTime <T1.Sttime) And ( T.EndTime >T1.ndtime )) )group by T1.mc
				)AS T2  INNER JOIN #PLD ON T2.mc = #PLD.MachineInterface
				---mod 4(4)
	
			/* Fetching Down Records from Production Cycle  */
			/* If production  Records of TYPE-2*/
			UPDATE  #PLD set IPlannedDT =isnull(IPlannedDT,0) + isNull(T2.IPDT ,0) 	FROM	(
				Select T1.mc,SUM(
				CASE 	
					When T1.sttime >= T.StartTime  AND T1.ndtime <=T.EndTime  Then datediff(s , T1.sttime,T1.ndtime) ---type 1
					When T1.sttime < T.StartTime  and  T1.ndtime <= T.EndTime AND T1.ndtime > T.StartTime Then datediff(s, T.StartTime,T1.ndtime ) ---type 2
					When T1.sttime >= T.StartTime   AND T1.sttime <T.EndTime AND T1.ndtime > T.EndTime Then datediff(s, T1.sttime,T.EndTime ) ---type 3
					when T1.sttime < T.StartTime  AND T1.ndtime > T.EndTime Then datediff(s, T.StartTime,T.EndTime ) ---type 4
				END) as IPDT from
				(Select A.mc,(select machineid from machineinformation where interfaceid = A.mc)as machine, A.sttime, ndtime, 
				A.datatype from autodata A WITH (NOLOCK) -- ----ER0377 Added LOCK
				Where A.DataType=2
				and exists 
				(
				Select B.Sttime,B.NdTime From autodata B WITH (NOLOCK) -- ----ER0377 Added LOCK
				Where B.mc = A.mc and
				B.DataType=1 And DateDiff(Second,B.sttime,B.ndtime)> B.CycleTime And
				(B.msttime < @startMonth And B.ndtime > @startMonth AND B.ndtime <= @EndTime) 
				And ((A.Sttime > B.Sttime) And ( A.ndtime < B.ndtime) AND ( A.ndtime > @startMonth ))
				)
				)as T1 inner join
				(select  machine,Case when starttime<@startMonth then @startMonth else starttime end as starttime, 
				case when endtime> @Endtime then @Endtime else endtime end as endtime from dbo.PlannedDownTimes 
				where ((( StartTime >=@startMonth) And ( EndTime <=@Endtime))
				or (StartTime < @startMonth  and  EndTime <= @Endtime AND EndTime > @startMonth)
				or (StartTime >= @startMonth  AND StartTime <@Endtime AND EndTime > @Endtime)
				or (( StartTime <@startMonth) And ( EndTime >@Endtime )) )
				)T
				on T1.machine=T.machine AND
				(( T.StartTime >= @startMonth ) And ( T.StartTime <  T1.ndtime )) group by T1.mc
			)AS T2  INNER JOIN #PLD ON T2.mc = #PLD.MachineInterface
	
			/* If production Records of TYPE-3*/
			UPDATE  #PLD set IPlannedDT =isnull(IPlannedDT,0) + isNull(T2.IPDT ,0)FROM (
			Select T1.mc,SUM(
				CASE 	
					When T1.sttime >= T.StartTime  AND T1.ndtime <=T.EndTime  Then datediff(s , T1.sttime,T1.ndtime) ---type 1
					When T1.sttime < T.StartTime  and  T1.ndtime <= T.EndTime AND T1.ndtime > T.StartTime Then datediff(s, T.StartTime,T1.ndtime ) ---type 2
					When T1.sttime >= T.StartTime   AND T1.sttime <T.EndTime AND T1.ndtime > T.EndTime Then datediff(s, T1.sttime,T.EndTime ) ---type 3
					when T1.sttime < T.StartTime  AND T1.ndtime > T.EndTime Then datediff(s, T.StartTime,T.EndTime ) ---type 4
				END) as IPDT from
				(Select A.mc,(select machineid from machineinformation where interfaceid = A.mc)as machine,
				 A.sttime, ndtime, A.datatype from autodata A WITH (NOLOCK) 
				Where A.DataType=2
				and exists 
				(
				Select B.Sttime,B.NdTime From autodata B WITH (NOLOCK) 
				Where B.mc = A.mc and
				B.DataType=1 And DateDiff(Second,B.sttime,B.ndtime)> B.CycleTime And
				(B.sttime >= @startMonth And B.ndtime > @EndTime and B.sttime <@EndTime) and
				((B.Sttime < A.sttime  )And ( B.ndtime > A.ndtime) AND (A.msttime < @EndTime))
				)
				)as T1 inner join

				(select  machine,Case when starttime<@startMonth then @startMonth else starttime end as starttime, 
				case when endtime> @Endtime then @Endtime else endtime end as endtime from dbo.PlannedDownTimes 
				where ((( StartTime >=@startMonth) And ( EndTime <=@Endtime))
				or (StartTime < @startMonth  and  EndTime <= @Endtime AND EndTime > @startMonth)
				or (StartTime >= @startMonth  AND StartTime <@Endtime AND EndTime > @Endtime)
				or (( StartTime <@startMonth) And ( EndTime >@Endtime )) )
				)T
				on T1.machine=T.machine
				AND (( T.EndTime > T1.Sttime )And ( T.EndTime <=@EndTime )) group by T1.mc
				)AS T2  INNER JOIN #PLD ON T2.mc = #PLD.MachineInterface
	
	
			/* If production Records of TYPE-4*/
			UPDATE  #PLD set IPlannedDT =isnull(IPlannedDT,0) + isNull(T2.IPDT ,0)FROM (
			Select T1.mc,SUM(
			CASE 	
				When T1.sttime >= T.StartTime  AND T1.ndtime <=T.EndTime  Then datediff(s , T1.sttime,T1.ndtime) ---type 1
				When T1.sttime < T.StartTime  and  T1.ndtime <= T.EndTime AND T1.ndtime > T.StartTime Then datediff(s, T.StartTime,T1.ndtime ) ---type 2
				When T1.sttime >= T.StartTime   AND T1.sttime <T.EndTime AND T1.ndtime > T.EndTime Then datediff(s, T1.sttime,T.EndTime ) ---type 3
				when T1.sttime < T.StartTime  AND T1.ndtime > T.EndTime Then datediff(s, T.StartTime,T.EndTime ) ---type 4
			END) as IPDT from
			(Select A.mc,(select machineid from machineinformation where interfaceid = A.mc)as machine, A.sttime, ndtime,
			 A.datatype from autodata A WITH (NOLOCK) 
			Where A.DataType=2
			and exists 
			(
			Select B.Sttime,B.NdTime From autodata B WITH (NOLOCK) 
			Where B.mc = A.mc and
			B.DataType=1 And DateDiff(Second,B.sttime,B.ndtime)> B.CycleTime And
			(B.msttime < @startMonth And B.ndtime > @EndTime)
			And ((B.Sttime < A.sttime)And ( B.ndtime >  A.ndtime)AND (A.ndtime  >  @startMonth) AND (A.sttime  <  @EndTime))
			)
			)as T1 inner join
				(select  machine,Case when starttime<@startMonth then @startMonth else starttime end as starttime, 
				case when endtime> @Endtime then @Endtime else endtime end as endtime from dbo.PlannedDownTimes 
				where ((( StartTime >=@startMonth) And ( EndTime <=@Endtime))
				or (StartTime < @startMonth  and  EndTime <= @Endtime AND EndTime > @startMonth)
				or (StartTime >= @startMonth  AND StartTime <@Endtime AND EndTime > @Endtime)
				or (( StartTime <@startMonth) And ( EndTime >@Endtime )) )
				)T
				on T1.machine=T.machine AND
			(( T.StartTime >=@startMonth) And ( T.EndTime <=@EndTime )) group by T1.mc
			)AS T2  INNER JOIN #PLD ON T2.mc = #PLD.MachineInterface
		  ------------------------------------  ----ER0377 Added Till Here --------------------------------
			
		END
		--mod 4
		/*******************************      Utilised Calculation Ends ***************************************************/

		/*******************************Down Record***********************************/
		--**************************************** ManagementLoss and Downtime Calculation Starts **************************************
		---Below IF condition added by Mrudula for mod 4. TO get the ML if 'Ignore_Dtime_4m_PLD'<>"Y"
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='N' or ((SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'N' and (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'Y')
		BEGIN
				-- Type 1
				UPDATE #CockpitData SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)
				from
				(select mc,sum(
				CASE
				WHEN (loadunload) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0
				THEN isnull(downcodeinformation.Threshold,0)
				ELSE loadunload
				END) AS LOSS
				from  autodata WITH (NOLOCK) 
				INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid
				where (autodata.msttime>=@startMonth)
				and (autodata.ndtime<=@EndTime)
				and (autodata.datatype=2)
				and (downcodeinformation.availeffy = 1)
				group by autodata.mc) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
				-- Type 2
				UPDATE #CockpitData SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)
				from
				(select      mc,sum(
				CASE WHEN DateDiff(second, @startMonth, ndtime) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0
				then isnull(downcodeinformation.Threshold,0)
				ELSE DateDiff(second, @startMonth, ndtime)
				END)loss
				from  autodata WITH (NOLOCK) 
				INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid
				where (autodata.sttime<@startMonth)
				and (autodata.ndtime>@startMonth)
				and (autodata.ndtime<=@EndTime)
				and (autodata.datatype=2)
				and (downcodeinformation.availeffy = 1)
				group by autodata.mc
				) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
				-- Type 3
				UPDATE #CockpitData SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)
				from
				(select      mc,SUM(
				CASE WHEN DateDiff(second,stTime, @Endtime) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0
				then isnull(downcodeinformation.Threshold,0)
				ELSE DateDiff(second, stTime, @Endtime)
				END)loss
				from  autodata WITH (NOLOCK) 
				INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid
				where (autodata.msttime>=@startMonth)
				and (autodata.sttime<@EndTime)
				and (autodata.ndtime>@EndTime)
				and (autodata.datatype=2)
				and (downcodeinformation.availeffy = 1)
				group by autodata.mc
				) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
				-- Type 4
				UPDATE #CockpitData SET ManagementLoss = isnull(ManagementLoss,0) + isNull(t2.loss,0)
				from
				(select mc,sum(
				CASE WHEN DateDiff(second, @startMonth, @Endtime) > isnull(downcodeinformation.Threshold,0) and isnull(downcodeinformation.Threshold,0) > 0
				then isnull(downcodeinformation.Threshold,0)
				ELSE DateDiff(second, @startMonth, @Endtime)
				END)loss
				from  autodata WITH (NOLOCK) 
				INNER JOIN downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid
				where autodata.msttime<@startMonth
				and autodata.ndtime>@EndTime
				and (autodata.datatype=2)
				and (downcodeinformation.availeffy = 1)
				group by autodata.mc
				) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
				---get the downtime for the time period
				UPDATE #CockpitData SET downtime = isnull(downtime,0) + isNull(t2.down,0)
				from
				(select mc,sum(
						CASE
						WHEN  autodata.msttime>=@startMonth  and  autodata.ndtime<=@EndTime  THEN  loadunload
						WHEN (autodata.sttime<@startMonth and  autodata.ndtime>@startMonth and autodata.ndtime<=@EndTime)  THEN DateDiff(second, @startMonth, ndtime)
						WHEN (autodata.msttime>=@startMonth  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)  THEN DateDiff(second, stTime, @Endtime)
						WHEN autodata.msttime<@startMonth and autodata.ndtime>@EndTime   THEN DateDiff(second, @startMonth, @EndTime)
						END
					)AS down
				from  autodata WITH (NOLOCK) 
				inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid
				where autodata.datatype=2 AND
				(
				(autodata.msttime>=@startMonth  and  autodata.ndtime<=@EndTime)
				OR (autodata.sttime<@startMonth and  autodata.ndtime>@startMonth and autodata.ndtime<=@EndTime)
				OR (autodata.msttime>=@startMonth  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)
				OR (autodata.msttime<@startMonth and autodata.ndtime>@EndTime )
				)
				group by autodata.mc
				) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface
		End

		---mod 4: Handling interaction between PDT and downtime . Also interaction between PDT and Management Loss
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='Y'
		BEGIN
			---step 1
			
			UPDATE #CockpitData SET downtime = isnull(downtime,0) + isNull(t2.down,0)
			from
			(select mc,sum(
					CASE
					WHEN  autodata.msttime>=@startMonth  and  autodata.ndtime<=@EndTime  THEN  loadunload
					WHEN (autodata.sttime<@startMonth and  autodata.ndtime>@startMonth and autodata.ndtime<=@EndTime)  THEN DateDiff(second, @startMonth, ndtime)
					WHEN (autodata.msttime>=@startMonth  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)  THEN DateDiff(second, stTime, @Endtime)
					WHEN autodata.msttime<@startMonth and autodata.ndtime>@EndTime   THEN DateDiff(second, @startMonth, @EndTime)
					END
				)AS down
			from  autodata WITH (NOLOCK) -- ----ER0377 Added LOCK
			inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid
			where autodata.datatype=2 AND
			(
			(autodata.msttime>=@startMonth  and  autodata.ndtime<=@EndTime)
			OR (autodata.sttime<@startMonth and  autodata.ndtime>@startMonth and autodata.ndtime<=@EndTime)
			OR (autodata.msttime>=@startMonth  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)
			OR (autodata.msttime<@startMonth and autodata.ndtime>@EndTime )
			) AND (downcodeinformation.availeffy = 0)
			group by autodata.mc
			) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface

			---mod 4 checking for (downcodeinformation.availeffy = 0) to get the overlapping PDT and Downs which is not ML
			UPDATE #PLD set dPlannedDT =isnull(dPlannedDT,0) + isNull(TT.PPDT ,0)
			FROM(
				--Production PDT
				SELECT autodata.MC, SUM
				   (CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM  AutoData WITH (NOLOCK) 
				CROSS jOIN #PlannedDownTimes T inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid
				WHERE autodata.DataType=2 AND T.MachineInterface=autodata.mc AND
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)AND (downcodeinformation.availeffy = 0)
				group by autodata.mc
			) as TT INNER JOIN #PLD ON TT.mc = #PLD.MachineInterface

			---step 3
			---Management loss calculation
			---IN T1 Select get all the downtimes which is of type management loss
			---IN T2  get the time to be deducted from the cycle if the cycle is overlapping with the PDT. And it should be ML record
			---In T3 Get the real management loss , and time to be considered as real down for each cycle(by comaring with the ML threshold)
			---In T4 consolidate everything at machine level and update the same to #CockpitData for ManagementLoss and MLDown
			
			UPDATE #CockpitData SET  ManagementLoss = isnull(ManagementLoss,0) + isNull(t4.Mloss,0),MLDown=isNull(MLDown,0)+isNull(t4.Dloss,0)
			from
			(select T3.mc,sum(T3.Mloss) as Mloss,sum(T3.Dloss) as Dloss from (
			select   t1.id,T1.mc,T1.Threshold,
			case when DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)> isnull(T1.Threshold ,0) and isnull(T1.Threshold ,0)>0
			then DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)- isnull(T1.Threshold ,0)
			else 0 End  as Dloss,
			case when DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)> isnull(T1.Threshold ,0) and isnull(T1.Threshold ,0)>0
			then isnull(T1.Threshold,0)
			else (DateDiff(second,T1.sttime,T1.ndtime)-isnull(T2.PPDT,0)) End  as Mloss
			 from
			
			(   select id,mc,comp,opn,opr,D.threshold,
				case when autodata.sttime<@startMonth then @startMonth else sttime END as sttime,
	       			case when ndtime>@EndTime then @EndTime else ndtime END as ndtime
				from  autodata WITH (NOLOCK) -- ----ER0377 Added LOCK
				inner join downcodeinformation D
				on autodata.dcode=D.interfaceid where autodata.datatype=2 AND
				(
				(autodata.sttime>=@startMonth  and  autodata.ndtime<=@EndTime)
				OR (autodata.sttime<@startMonth and  autodata.ndtime>@startMonth and autodata.ndtime<=@EndTime)
				OR (autodata.sttime>=@startMonth  and autodata.sttime<@EndTime  and autodata.ndtime>@EndTime)
				OR (autodata.sttime<@startMonth and autodata.ndtime>@EndTime )
				) AND (D.availeffy = 1)) as T1 	
			left outer join
			(SELECT autodata.id,
					   sum(CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM  AutoData WITH (NOLOCK) -- ----ER0377 Added LOCK
				CROSS jOIN #PlannedDownTimes T inner join downcodeinformation on autodata.dcode=downcodeinformation.interfaceid
				WHERE autodata.DataType=2 AND T.MachineInterface=autodata.mc AND
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)
					AND (downcodeinformation.availeffy = 1) group  by autodata.id ) as T2 on T1.id=T2.id ) as T3  group by T3.mc
			) as t4 inner join #CockpitData on t4.mc = #CockpitData.machineinterface
			UPDATE #CockpitData SET downtime = isnull(downtime,0)+isnull(ManagementLoss,0)+isNull(MLDown,0)
		END

		---mod 4: Till here Handling interaction between PDT and downtime . Also interaction between PDT and Management Loss
		---mod 4:If Ignore_Dtime_4m_PLD<> Y and Ignore_Dtime_4m_PLD<> N
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'Y' AND (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'N'
		BEGIN
			UPDATE #PLD set dPlannedDT =isnull(dPlannedDT,0) + isNull(TT.PPDT ,0)
			FROM(
				--Production PDT
				SELECT autodata.MC, SUM
					   (CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM  AutoData WITH (NOLOCK) 
				 CROSS jOIN #PlannedDownTimes T
				Inner Join DownCodeInformation D ON AutoData.DCode = D.InterfaceID
				WHERE autodata.DataType=2 AND T.MachineInterface=autodata.mc AND D.DownID=(SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD') AND
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)
				group by autodata.mc
			) as TT INNER JOIN #PLD ON TT.mc = #PLD.MachineInterface
		END

		--************************************ Down and Management  Calculation Ends ******************************************
		---mod 4
		-- Get the value of CN
		-- Type 1
		/* Changed by SSK to Combine SubOperations*/
		UPDATE #CockpitData SET CN = isnull(CN,0) + isNull(t2.C1N1,0)
		from
		(select mc,
		SUM((componentoperationpricing.cycletime/ISNULL(ComponentOperationPricing.SubOperations,1))* autodata.partscount) C1N1
		FROM  autodata WITH (NOLOCK) 
		INNER JOIN
		componentoperationpricing WITH (NOLOCK) ON autodata.opn = componentoperationpricing.InterfaceID INNER JOIN ----ER0377 Added LOCK
		componentinformation ON autodata.comp = componentinformation.InterfaceID AND
		componentoperationpricing.componentid = componentinformation.componentid
		--mod 2
		inner join machineinformation on machineinformation.interfaceid=autodata.mc
		and componentoperationpricing.machineid=machineinformation.machineid
		--mod 2
		where (((autodata.sttime>=@startMonth)and (autodata.ndtime<=@EndTime)) or
		((autodata.sttime<@startMonth)and (autodata.ndtime>@startMonth)and (autodata.ndtime<=@EndTime)) )
		and (autodata.datatype=1)
		group by autodata.mc
		) as t2 inner join #CockpitData on t2.mc = #CockpitData.machineinterface

		-- mod 4 Ignore count from CN calculation which is over lapping with PDT
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #CockpitData SET CN = isnull(CN,0) - isNull(t2.C1N1,0)
			From
			(
				select mc,SUM((O.cycletime * ISNULL(A.PartsCount,1))/ISNULL(O.SubOperations,1))  C1N1
				From autodata A WITH (NOLOCK) 
				Inner join machineinformation M on M.interfaceid=A.mc
				Inner join componentinformation C ON A.Comp=C.interfaceid
				Inner join ComponentOperationPricing O WITH (NOLOCK) ON A.Opn=O.interfaceid AND C.Componentid=O.componentid And O.MachineID = M.MachineID ----ER0377 Added LOCK
				Cross jOIN #PlannedDownTimes T
				WHERE A.DataType=1 AND T.MachineInterface=A.mc
				AND(A.ndtime > T.StartTime  AND A.ndtime <=T.EndTime)
				AND(A.ndtime > @startMonth  AND A.ndtime <=@EndTime)
				Group by mc
			) as T2
			inner join #CockpitData  on t2.mc = #CockpitData.machineinterface
		END

		--Calculation of PartsCount Begins..
		UPDATE #CockpitData SET components = ISNULL(components,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM(CEILING (CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from  autodata WITH (NOLOCK) -- ----ER0377 Added LOCK
				   where (autodata.ndtime>@startMonth) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O WITH (NOLOCK) ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid ----ER0377 Added LOCK
			---mod 2
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid
			---mod 2
			GROUP BY mc
		) As T2 Inner join #CockpitData on T2.mc = #CockpitData.machineinterface

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #CockpitData SET components = ISNULL(components,0) - ISNULL(T2.comp,0) from(
				select mc,SUM(CEILING (CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
					select mc,Sum(ISNULL(PartsCount,1))AS OrginalCount,comp,opn from  autodata WITH (NOLOCK) -- ----ER0377 Added LOCK
					CROSS JOIN #PlannedDownTimes T
					WHERE autodata.DataType=1 And T.MachineInterface = autodata.mc
					AND (autodata.ndtime > T.StartTime  AND autodata.ndtime <=T.EndTime)
					AND (autodata.ndtime > @startMonth  AND autodata.ndtime <=@EndTime)
					Group by mc,comp,opn
				) as T1
			Inner join Machineinformation M on M.interfaceID = T1.mc
			Inner join componentinformation C on T1.Comp=C.interfaceid
			Inner join ComponentOperationPricing O WITH (NOLOCK) ON T1.Opn=O.interfaceid and C.Componentid=O.componentid and O.MachineID = M.MachineID ----ER0377 Added LOCK
			GROUP BY MC
			) as T2 inner join #CockpitData on T2.mc = #CockpitData.machineinterface
		END

		UPDATE #CockpitData
			SET UtilisedTime=(UtilisedTime-ISNULL(#PLD.pPlannedDT,0)+isnull(#PLD.IPlannedDT,0)),
				DownTime=(DownTime-ISNULL(#PLD.dPlannedDT,0))
			From #CockpitData Inner Join #PLD on #PLD.Machineid=#CockpitData.Machineid

		-- Calculate efficiencies
		UPDATE #CockpitData
		SET
			ProductionEfficiency = (CN/UtilisedTime) ,
			AvailabilityEfficiency = (UtilisedTime)/(UtilisedTime + DownTime - ManagementLoss),
			TotalTime = DateDiff(second, @startMonth, @EndTime)
		WHERE UtilisedTime <> 0

		UPDATE #CockpitData
		SET
			OverAllEfficiency = Round((ProductionEfficiency * AvailabilityEfficiency)*100,0),
			ProductionEfficiency = Round(ProductionEfficiency * 100,0) ,
			AvailabilityEfficiency = Round(AvailabilityEfficiency * 100,0)



--------------------------------------------------------------------------------------------
-------------------------------------Down Chart data----------------------------------------
--------------------------------------------------------------------------------------------
		select @strsql = ''
		select @strsql = 'INSERT INTO #DownTimeData (MachineID,McInterfaceid, DownID, DownTime,DownFreq) SELECT Machineinformation.MachineID AS MachineID,Machineinformation.interfaceid, downcodeinformation.downid AS DownID, 0,0'
		select @strsql = @strsql+' FROM Machineinformation CROSS JOIN downcodeinformation LEFT OUTER JOIN PlantMachine ON PlantMachine.MachineID=Machineinformation.MachineID '
		select @strsql = @strsql+' Where MachineInformation.interfaceid > ''0'' '
		select @strsql = @strsql + @strPlantID + ' ORDER BY  downcodeinformation.downid, Machineinformation.MachineID'
		exec (@strsql)
		--********************************************* Get Down Time Details *******************************************************
		--Type 1,2,3 and 4.
		select @strsql = ''
		select @strsql = @strsql + 'UPDATE #DownTimeData SET downtime = isnull(DownTime,0) + isnull(t2.down,0) '
		select @strsql = @strsql + ' FROM'
		select @strsql = @strsql + ' (SELECT mc,--count(mc)as dwnfrq,
		SUM(CASE
		WHEN (autodata.sttime>='''+convert(varchar(20),@Starttime)+''' and autodata.ndtime<='''+convert(varchar(20),@endtime)+''' ) THEN loadunload
		WHEN (autodata.sttime<'''+convert(varchar(20),@Starttime)+''' and autodata.ndtime>'''+convert(varchar(20),@Starttime)+'''and autodata.ndtime<='''+convert(varchar(20),@endtime)+''') THEN DateDiff(second, '''+convert(varchar(20),@Starttime)+''', ndtime)
		WHEN (autodata.sttime>='''+convert(varchar(20),@Starttime)+'''and autodata.sttime<'''+convert(varchar(20),@endtime)+''' and autodata.ndtime>'''+convert(varchar(20),@endtime)+''') THEN DateDiff(second, stTime, '''+convert(varchar(20),@Endtime)+''')
		ELSE DateDiff(second,'''+convert(varchar(20),@Starttime)+''','''+convert(varchar(20),@endtime)+''')
		END) as down
		,downcodeinformation.downid as downid'
		select @strsql = @strsql + ' from'
		select @strsql = @strsql + '  #T_autodata autodata INNER JOIN'
		select @strsql = @strsql + ' machineinformation ON autodata.mc = machineinformation.InterfaceID Left Outer Join PlantMachine ON PlantMachine.MachineID=machineinformation.MachineID INNER JOIN'
		select @strsql = @strsql + ' componentinformation ON autodata.comp = componentinformation.InterfaceID INNER JOIN'
		select @strsql = @strsql + ' employeeinformation ON autodata.opr = employeeinformation.interfaceid INNER JOIN'
		select @strsql = @strsql + ' downcodeinformation ON autodata.dcode = downcodeinformation.interfaceid'
		select @strsql = @strsql + ' where  datatype=2 AND ((autodata.sttime>='''+convert(varchar(20),@Starttime)+''' and autodata.ndtime<='''+convert(varchar(20),@endtime)+''' )OR
		(autodata.sttime<'''+convert(varchar(20),@Starttime)+''' and autodata.ndtime>'''+convert(varchar(20),@Starttime)+'''and autodata.ndtime<='''+convert(varchar(20),@endtime)+''')OR
		(autodata.sttime>='''+convert(varchar(20),@Starttime)+'''and autodata.sttime<'''+convert(varchar(20),@endtime)+''' and autodata.ndtime>'''+convert(varchar(20),@endtime)+''')OR
		(autodata.sttime<'''+convert(varchar(20),@Starttime)+''' and autodata.ndtime>'''+convert(varchar(20),@endtime)+'''))'
		select @strsql = @strsql  + @strPlantID 
		select @strsql = @strsql + ' group by autodata.mc,downcodeinformation.downid )'
		select @strsql = @strsql + ' as t2 inner join #DownTimeData on t2.mc=#DownTimeData.McInterfaceid and t2.downid=#DownTimeData.downid'
		exec (@strsql)
		--*********************************************************************************************************************
		--mod 4
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')='Y'
		BEGIN
			UPDATE #DownTimeData set DownTime =isnull(DownTime,0) - isNull(TT.PPDT ,0)
			FROM(
				--Production PDT
				SELECT autodata.MC,DownID, SUM
					   (CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM #T_autodata AutoData CROSS jOIN #PlannedDownTimes T
				Inner Join DownCodeInformation On AutoData.DCode=DownCodeInformation.InterfaceID
				WHERE autodata.DataType=2 AND T.MachineInterface = AutoData.mc And
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)
				group by autodata.mc,DownID
			) as TT INNER JOIN #DownTimeData ON TT.mc = #DownTimeData.McInterfaceid AND #DownTimeData.DownID=TT.DownId
			Where #DownTimeData.DownTime>0
		END

		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'Y' AND (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD')<>'N'
		BEGIN
			UPDATE #DownTimeData set DownTime =isnull(DownTime,0) - isNull(TT.PPDT ,0)
			FROM(
				--Production PDT
				SELECT autodata.MC,DownId, SUM
					   (CASE
					WHEN autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime  THEN (autodata.loadunload)
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime  AND autodata.ndtime > T.StartTime ) THEN DateDiff(second,T.StartTime,autodata.ndtime)
					WHEN ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime  AND autodata.ndtime > T.EndTime  ) THEN DateDiff(second,autodata.sttime,T.EndTime )
					WHEN ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime ) THEN DateDiff(second,T.StartTime,T.EndTime )
					END ) as PPDT
				FROM #T_autodata AutoData CROSS jOIN #PlannedDownTimes T
				Inner Join DownCodeInformation D ON AutoData.DCode = D.InterfaceID
				WHERE autodata.DataType=2 And T.MachineInterface = AutoData.mc AND D.DownID=(SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Dtime_4m_PLD') AND
					(
					(autodata.sttime >= T.StartTime  AND autodata.ndtime <=T.EndTime)
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime <= T.EndTime AND autodata.ndtime > T.StartTime )
					OR ( autodata.sttime >= T.StartTime   AND autodata.sttime <T.EndTime AND autodata.ndtime > T.EndTime )
					OR ( autodata.sttime < T.StartTime  AND autodata.ndtime > T.EndTime)
					)
				group by autodata.mc,DownId
			) as TT INNER JOIN #DownTimeData ON TT.mc = #DownTimeData.McInterfaceid AND #DownTimeData.DownID=TT.DownId
			Where #DownTimeData.DownTime>0
		END
----------------------------------------------------------------
--------------------output--------------------------------------
		--SELECT
		--Plantid,
		--MachineID,
		--ColorCode,
		--HelpCode1,HelpCode2,HelpCode3,HelpCode4
		--FROM #CockpitData
		--order by Plantid,machineid asc

		SELECT
		Plantid,
		MachineID,
		ColorCode,
		HelpCode1,HelpCode2,HelpCode3,HelpCode4
		FROM #CockpitData
		where (plantid=@PlantID or isnull(@plantid,'')='')
		order by Plantid,machineid asc

	select  Plantinformation.PlantID,Round(isnull(T.OEE,0.00),0) as OEE,Round(isnull(T.AE,0.00),0) as AE,Round(isnull(T.PE,0.00),0) as PE from
		(select plantmachine.PlantID,
		Avg(E.OverallEfficiency) as OEE,
		Avg(E.AvailabilityEfficiency) as AE,
		Avg(E.ProductionEfficiency) as PE from #CockpitData E
		inner join plantmachine
		on  E.MachineID = plantmachine.MachineID
		group by plantmachine.PlantID
		)as T Right outer Join Plantinformation on T.PlantID = plantinformation.PlantID
		where (Plantinformation.plantid=@PlantID or isnull(@plantid,'')='')
		order by plantinformation.PlantID

	

	Select T.DownID,T.Downtime From
	(select DownID,Sum(Downtime)/60 as Downtime from #Downtimedata where downtime>0
	Group by DownID)T Order By T.Downtime desc

END


END
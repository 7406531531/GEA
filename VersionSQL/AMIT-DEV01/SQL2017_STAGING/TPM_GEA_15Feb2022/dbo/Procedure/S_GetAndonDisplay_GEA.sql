/****** Object:  Procedure [dbo].[S_GetAndonDisplay_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[dbo].[S_GetAndonDisplay_GEA] '','GEA Westfalia Seperator India Pvt Ltd','COMPONENTWISE'
*/
CREATE Procedure [dbo].[S_GetAndonDisplay_GEA]
@StartDate datetime='',
@PlantID NVARCHAR(50)='',
@param nvarchar(50)=''
as
begin
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
	[PartsCount] decimal(18,5) NULL ,
	id  bigint not null
)

ALTER TABLE #T_autodata

ADD PRIMARY KEY CLUSTERED
(
	mc,sttime ASC
)ON [PRIMARY]

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


create table #MachinewiseTemp
(
MachineID NVARCHAR(50),
MachineShift float,
MachineDay float,
MachineWeek float,
MachineMonth float,
MachineYear float,
)
create table #ComponentwiseTemp
(
MachineID NVARCHAR(50),
Component NVARCHAR(50),
ShiftQuantity float,
DayQuantity float,
WeekQuantity float,
ShiftQuantity1 float,
DayQuantity1 float,
WeekQuantity1 float,
MonthQuantity float,
YearQuantity float
)

create table #componentInfo
(
MachineID NVARCHAR(50),
ComponentID NVARCHAR(50),
InterfaceID NVARCHAR(50),
ComponentDescription varchar(50)
)
CREATE TABLE #ShiftDefn
(
	ShiftDate datetime,		
	Shiftname nvarchar(20),
	ShftSTtime datetime,
	ShftEndTime datetime,
	shiftid int
)
create table #shift
(
	ShiftDate nvarchar(10), 
	shiftname nvarchar(20),
	Shiftstart datetime,
	Shiftend datetime,
	shiftid int
)
declare @strsql nvarchar(1000)
declare @currTime datetime
declare @startTime datetime
declare @endtime datetime
declare @CompDescription1 nvarchar(500)
declare @CompDescription2 nvarchar(500)
declare @CompDescription3 nvarchar(500)
declare @i int
declare @j int

set @currTime=convert(nvarchar(20),getdate(),120)

INSERT #ShiftDefn(ShiftDate,Shiftname,ShftSTtime,ShftEndTime)    
EXEC s_GetShiftTime @currTime,''

Update #ShiftDefn Set shiftid = isnull(#ShiftDefn.Shiftid,0) + isnull(T1.shiftid,0) from
(Select SD.shiftid ,SD.shiftname from shiftdetails SD
inner join #ShiftDefn S on SD.shiftname=S.shiftname where
running=1 )T1 inner join #ShiftDefn on  T1.shiftname=#ShiftDefn.shiftname

Insert into #shift (ShiftDate,shiftname,Shiftstart,Shiftend,shiftid)
select convert(nvarchar(10),ShiftDate,126),shiftname,ShftSTtime,ShftEndTime,shiftid from #ShiftDefn where @currtime BETWEEN ShftSTtime AND ShftEndTime

if @param='MachineWise'
begin
set @i=0
set @j=5
end

if @param='Componentwise'
begin
set @i=6
set @j=10
end
Declare @T_ST AS Datetime 
Declare @T_ED AS Datetime 

Select @T_ST=DATEFROMPARTS(YEAR(@currTime), 1, 1)
Select @T_ED=max(ShftEndTime) from #ShiftDefn  --@currTime

Select @strsql=''
select @strsql ='insert into #T_autodata '
select @strsql = @strsql + 'SELECT mc, comp, opn, opr, dcode,sttime,'
	select @strsql = @strsql + 'ndtime, datatype, cycletime, loadunload, msttime, PartsCount,id'
select @strsql = @strsql + ' from autodata where (( sttime >='''+ convert(nvarchar(25),@T_ST,120)+''' and ndtime <= '''+ convert(nvarchar(25),@T_ED,120)+''' ) OR '
select @strsql = @strsql + '( sttime <'''+ convert(nvarchar(25),@T_ST,120)+''' and ndtime >'''+ convert(nvarchar(25),@T_ED,120)+''' )OR '
select @strsql = @strsql + '( sttime <'''+ convert(nvarchar(25),@T_ST,120)+''' and ndtime >'''+ convert(nvarchar(25),@T_ST,120)+'''
					and ndtime<='''+convert(nvarchar(25),@T_ED,120)+''' )'
select @strsql = @strsql + ' OR ( sttime >='''+convert(nvarchar(25),@T_ST,120)+''' and ndtime >'''+ convert(nvarchar(25),@T_ED,120)+''' and sttime<'''+convert(nvarchar(25),@T_ED,120)+''' ) )'
print @strsql
exec (@strsql)

select @startTime=DATEFROMPARTS(YEAR(@currTime), 1, 1)
select @endtime=max(ShftEndTime) from #ShiftDefn  --@currTime

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

insert into #componentInfo(MachineID,ComponentID,InterfaceID,ComponentDescription)
select distinct M.machineid,c.componentid,c.interfaceid,M.ComponentDescription from ComponentMaster M
INNER JOIN componentoperationpricing CO ON CO.machineid=M.machineid
INNER JOIN PlantMachine P ON P.MachineID=M.MachineID
INNER JOIN componentinformation C ON C.componentid=CO.componentid and C.Description=M.ComponentDescription
WHERE (P.PlantID=@PlantID) OR (ISNULL(@PlantID,'')='')

--select * from #componentInfo
--return

insert into #MachinewiseTemp(MachineID,MachineShift,MachineDay, MachineWeek,MachineMonth,MachineYear)
select 'Testing',0,0,0,0,0

insert into #MachinewiseTemp(MachineID,MachineShift,MachineDay, MachineWeek,MachineMonth,MachineYear)
select 'Quality In house',0,0,0,0,0


insert into #ComponentwiseTemp(MachineID,Component,ShiftQuantity,ShiftQuantity1,DayQuantity,DayQuantity1,WeekQuantity,WeekQuantity1,MonthQuantity,YearQuantity)
select distinct C.MachineID,componentDescription,0,0,0,0,0,0,0,0 from ComponentMaster c
inner join PlantMachine P ON P.MachineID=C.machineid
WHERE (P.PlantID=@PlantID) OR (ISNULL(@PlantID,'')='')

/*-------------------------------------------------------------Start of Machine(Testing) Decanter Output-------------------------------------------------------------------------------------------------------*/

WHILE @i<=@j
begin
if (@i=0)
begin
select @startTime=min(shiftStart) from #shift
select @endtime=max(shiftEnd) from #shift  --convert(nvarchar(20),@currTime,120)

UPDATE #MachinewiseTemp SET MachineShift = ISNULL(MachineShift,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			where machineinformation.machineid='Testing'
			---mod 2
			GROUP BY mc
		) As T2 Inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #MachinewiseTemp SET MachineShift = ISNULL(MachineShift,0) - ISNULL(T2.comp,0) from(
				select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			where M.machineid='Testing'
			GROUP BY MC
			) as T2 inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'
		END

UPDATE #MachinewiseTemp SET MachineShift = ISNULL(MachineShift,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			where machineinformation.machineid='Quality In house'
			---mod 2
			GROUP BY mc
		) As T2 Inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Quality In house'

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #MachinewiseTemp SET MachineShift = ISNULL(MachineShift,0) - ISNULL(T2.comp,0) from(
				select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			where M.machineid='Quality In house'
			GROUP BY MC
			) as T2 inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Quality In house'
		END

end

if(@i=1)
begin
select @Starttime=min(ShftSTtime) from #ShiftDefn
select @EndTime= max(ShftEndTime) from #ShiftDefn --convert(nvarchar(20),@currTime,120)  


UPDATE #MachinewiseTemp SET MachineDay = ISNULL(MachineDay,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			---mod 2
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			where machineinformation.machineid='Testing'
			---mod 2
			GROUP BY mc
		) As T2 Inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #MachinewiseTemp SET MachineDay = ISNULL(MachineDay,0) - ISNULL(T2.comp,0) from(
				select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			where M.machineid='Testing'
			GROUP BY MC
			) as T2 inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'
		END

		UPDATE #MachinewiseTemp SET MachineDay = ISNULL(MachineDay,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			---mod 2
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			where machineinformation.machineid='Quality In house'
			---mod 2
			GROUP BY mc
		) As T2 Inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Quality In house'

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #MachinewiseTemp SET MachineDay = ISNULL(MachineDay,0) - ISNULL(T2.comp,0) from(
				select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			where M.machineid='Quality In house'
			GROUP BY MC
			) as T2 inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Quality In house'
		END

end

if (@i=3)
begin
select @Starttime=min(weekDate) from Calender where WeekNumber in (select weekNumber from calender where WeekDate=(cast (getdate() as date))) and MonthVal=datepart(mm,getdate()) and YearNo=DATEPART(yyyy,getdate())
--select @endtime=  max(weekDate) from Calender where WeekNumber in (select weekNumber from calender where WeekDate=(cast (getdate() as date))) and MonthVal=datepart(mm,getdate()) and YearNo=DATEPART(yyyy,getdate()) 
--select @endtime=DATEADD(day,1,@endtime)
select @endtime=getdate()


UPDATE #MachinewiseTemp SET MachineWeek = ISNULL(MachineWeek,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			---mod 2
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			where machineinformation.machineid='Testing'
			---mod 2
			GROUP BY mc
		) As T2 Inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #MachinewiseTemp SET MachineWeek = ISNULL(MachineWeek,0) - ISNULL(T2.comp,0) from(
				select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			where M.machineid='Testing'
			GROUP BY MC
			) as T2 inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'
		END

		UPDATE #MachinewiseTemp SET MachineWeek = ISNULL(MachineWeek,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			---mod 2
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			where machineinformation.machineid='Quality In house'
			---mod 2
			GROUP BY mc
		) As T2 Inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Quality In house'

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #MachinewiseTemp SET MachineWeek = ISNULL(MachineWeek,0) - ISNULL(T2.comp,0) from(
				select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			where M.machineid='Quality In house'
			GROUP BY MC
			) as T2 inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Quality In house'
		END

end

if(@i=4)
begin
select @Starttime=convert(nvarchar(20),(DATEFROMPARTS(YEAR(@currTime),MONTH(@currTime),1)),120)
select @EndTime= max(ShftEndTime) from #ShiftDefn --convert(nvarchar(20),@currTime,120)   

UPDATE #MachinewiseTemp SET MachineMonth = ISNULL(MachineMonth,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			---mod 2
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			where machineinformation.machineid='Testing'
			---mod 2
			GROUP BY mc
		) As T2 Inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #MachinewiseTemp SET MachineMonth = ISNULL(MachineMonth,0) - ISNULL(T2.comp,0) from(
				select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			where M.machineid='Testing'
			GROUP BY MC
			) as T2 inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'
		END
end

if(@i=5)
begin
select @Starttime=convert(nvarchar(20),(DATEFROMPARTS(YEAR(@currTime), 1, 1)),120)
select @EndTime= max(ShftEndTime) from #ShiftDefn --convert(nvarchar(20),@currTime,120)   

UPDATE #MachinewiseTemp SET MachineYear = ISNULL(MachineYear,0) + ISNULL(t2.comp,0)
		From
		(
			Select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			---mod 2
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			where machineinformation.machineid='Testing'
			---mod 2
			GROUP BY mc
		) As T2 Inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #MachinewiseTemp SET MachineYear = ISNULL(MachineYear,0) - ISNULL(T2.comp,0) from(
				select mc,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			where M.machineid='Testing'
			GROUP BY MC
			) as T2 inner join #MachinewiseTemp on #MachinewiseTemp.MachineID='Testing'
		END
end
/*-------------------------------------------------------------End of Machine(Testing) Decanter Output-------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------Start of Componentwise(Bowl Shell,Scroll Welded,Bearing Hub) Calculation ---------------------------------------------------------------------*/

if (@i=6)
begin
select @startTime=min(Shiftstart) from #Shift
select @endtime=max(ShiftEnd) from #shift   --convert(nvarchar(20),@currTime,120)

UPDATE #ComponentwiseTemp SET ShiftQuantity = ISNULL(ShiftQuantity,0) + ISNULL(t2.comp,0)
		From
		(
			Select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			inner join #componentInfo c1 on c1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where machineinformation.machineid not in('Quality In house') and o.FinishedOperation=1
			GROUP BY c1.ComponentDescription
		) As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #ComponentwiseTemp SET ShiftQuantity = ISNULL(ShiftQuantity,0) - ISNULL(T2.comp,0) from(
				select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			inner join #componentInfo C1 on C1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where m.machineid not in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
			)  As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription
		END

		UPDATE #ComponentwiseTemp SET ShiftQuantity1 = ISNULL(ShiftQuantity1,0) + ISNULL(t2.comp,0)
		From
		(
			Select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			inner join #componentInfo c1 on c1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where machineinformation.machineid in('Quality In house') and o.FinishedOperation=1
			GROUP BY c1.ComponentDescription
		) As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #ComponentwiseTemp SET ShiftQuantity1 = ISNULL(ShiftQuantity1,0) - ISNULL(T2.comp,0) from(
				select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			inner join #componentInfo C1 on C1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where m.machineid in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
			)  As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription
		END

		end

if (@i=7)
begin
select @Starttime=min(ShftSTtime) from #ShiftDefn
select @EndTime= max(ShftEndTime) from #ShiftDefn -- convert(nvarchar(20),@currTime,120)

UPDATE #ComponentwiseTemp SET DayQuantity = ISNULL(DayQuantity,0) + ISNULL(t2.comp,0)
		From
		(
			Select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			inner join #componentInfo c1 on c1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where machineinformation.machineid not in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
		) As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #ComponentwiseTemp SET DayQuantity = ISNULL(DayQuantity,0) - ISNULL(T2.comp,0) from(
				select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			inner join #componentInfo C1 on C1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where m.machineid not in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
			)  As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription
		END

UPDATE #ComponentwiseTemp SET DayQuantity1 = ISNULL(DayQuantity1,0) + ISNULL(t2.comp,0)
		From
		(
			Select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			inner join #componentInfo c1 on c1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where machineinformation.machineid in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
		) As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #ComponentwiseTemp SET DayQuantity1 = ISNULL(DayQuantity1,0) - ISNULL(T2.comp,0) from(
				select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			inner join #componentInfo C1 on C1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where m.machineid in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
			)  As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription
		END
end


if (@i=8)
begin
select @Starttime=min(weekDate) from Calender where WeekNumber in (select weekNumber from calender where WeekDate=(cast (getdate() as date))) and MonthVal=datepart(mm,getdate()) and YearNo=DATEPART(yyyy,getdate())
--select @endtime=  max(weekDate) from Calender where WeekNumber in (select weekNumber from calender where WeekDate=(cast (getdate() as date))) and MonthVal=datepart(mm,getdate()) and YearNo=DATEPART(yyyy,getdate()) 
SELECT @endtime=GETDATE()

UPDATE #ComponentwiseTemp SET WeekQuantity = ISNULL(WeekQuantity,0) + ISNULL(t2.comp,0)
		From
		(
			Select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			inner join #componentInfo c1 on c1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where machineinformation.machineid not in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
		) As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #ComponentwiseTemp SET WeekQuantity = ISNULL(WeekQuantity,0) - ISNULL(T2.comp,0) from(
				select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			inner join #componentInfo C1 on C1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where m.machineid not in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
			)  As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription
		END

UPDATE #ComponentwiseTemp SET WeekQuantity1 = ISNULL(WeekQuantity1,0) + ISNULL(t2.comp,0)
		From
		(
			Select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			inner join #componentInfo c1 on c1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where machineinformation.machineid in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
		) As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription

		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #ComponentwiseTemp SET WeekQuantity1 = ISNULL(WeekQuantity1,0) - ISNULL(T2.comp,0) from(
				select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			inner join #componentInfo C1 on C1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where m.machineid in('Quality In house') and o.FinishedOperation=1
			GROUP BY ComponentDescription
			)  As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription
		END


end

if (@i=9)
begin
select @startTime=convert(nvarchar(20),(DATEFROMPARTS(YEAR(@currTime),MONTH(@currTime),1)),120)
select @endtime= max(ShftEndTime) from #ShiftDefn --convert(nvarchar(20),@currTime,120)




UPDATE #ComponentwiseTemp SET MonthQuantity = ISNULL(MonthQuantity,0) + ISNULL(t2.comp,0)
		From
		(
			Select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			inner join #componentInfo c1 on c1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			where o.FinishedOperation=1
			GROUP BY ComponentDescription
		) As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription 


		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #ComponentwiseTemp SET MonthQuantity = ISNULL(MonthQuantity,0) - ISNULL(T2.comp,0) from(
				select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			inner join #componentInfo C1 on C1.MachineID=O.machineid AND C1.ComponentID=O.componentid
				where o.FinishedOperation=1
			GROUP BY ComponentDescription
			)  As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription
		END
end

if (@i=10)
begin
select @startTime=convert(nvarchar(20),(DATEFROMPARTS(YEAR(@currTime), 1, 1)),120)
select @endtime= max(ShftEndTime) from #ShiftDefn   --convert(nvarchar(20),@currTime,120)

UPDATE #ComponentwiseTemp SET YearQuantity = ISNULL(YearQuantity,0) + ISNULL(t2.comp,0)
		From
		(
			Select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) As Comp
				   From (select mc,SUM(autodata.partscount)AS OrginalCount,comp,opn from #T_autodata autodata
				   where (autodata.ndtime>@Starttime) and (autodata.ndtime<=@EndTime) and (autodata.datatype=1)
				   Group By mc,comp,opn) as T1
			Inner join componentinformation C on T1.Comp = C.interfaceid
			Inner join ComponentOperationPricing O ON  T1.Opn = O.interfaceid and C.Componentid=O.componentid
			---mod 2
			inner join machineinformation on machineinformation.machineid =O.machineid
			and T1.mc=machineinformation.interfaceid 
			inner join #componentInfo c1 on c1.MachineID=O.machineid AND C1.ComponentID=O.componentid
			---mod 2
				where o.FinishedOperation=1
			GROUP BY ComponentDescription
		) As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription


		--Mod 4 Apply PDT for calculation of Count
		If (SELECT ValueInText From CockpitDefaults Where Parameter ='Ignore_Count_4m_PLD')='Y'
		BEGIN
			UPDATE #ComponentwiseTemp SET YearQuantity = ISNULL(YearQuantity,0) - ISNULL(T2.comp,0) from(
				select C1.ComponentDescription,SUM((CAST(T1.OrginalCount AS Float)/ISNULL(O.SubOperations,1))) as comp From (
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
			inner join #componentInfo C1 on C1.MachineID=O.machineid AND C1.ComponentID=O.componentid
				where o.FinishedOperation=1
			GROUP BY ComponentDescription
			)  As T2 Inner join #ComponentwiseTemp on #ComponentwiseTemp.Component=T2.ComponentDescription
		END
end
set @i=@i+1
end

IF @param='Machinewise'
begin
select M.MachineID,MachineShift ,MachineDay,MachineWeek, MachineMonth,MachineYear from #MachinewiseTemp M
inner join PlantMachine p on p.MachineID=m.MachineID
where (p.PlantID=@PlantID) or (isnull(@PlantID,'')='')
order by m.MachineID desc
end
if @param='ComponentWise'
begin
--select distinct Component,ShiftQuantity,ShiftQuantity1 as QualityShift,DayQuantity,DayQuantity1 as QualityDay,WeekQuantity,WeekQuantity1 as QualityWeek,MonthQuantity,YearQuantity  from #ComponentwiseTemp C
--inner join PlantMachine p on p.MachineID=c.MachineID
--where (p.PlantID=@PlantID) or (isnull(@PlantID,'')='')
--order by Component


select  'Bowl Shell' as Component,sum(T.ShiftQuantity) as MachineShift ,sum(T.ShiftQuantity1) as QualityShift,sum(T.DayQuantity) as MachineDay,sum(T.DayQuantity1) as QualityDay,sum(T.WeekQuantity) as MachineWeek,sum(T.WeekQuantity1) AS QualityWeek,sum(T.MonthQuantity) as MonthQuantity ,sum(T.YearQuantity) as YearQuantity  from 
( SELECT distinct Component,ShiftQuantity,ShiftQuantity1,DayQuantity,DayQuantity1,WeekQuantity,WeekQuantity1,MonthQuantity ,YearQuantity  from #ComponentwiseTemp C 
where Component like '%Bowl Shell%'
) T 
union
--select  'Scroll Body' as Component,sum(T.ShiftQuantity) as MachineShift ,sum(T.ShiftQuantity1) as QualityShift,sum(T.DayQuantity) as MachineDay,sum(T.DayQuantity1) as QualityDay,sum(T.WeekQuantity) as MachineWeek,sum(T.WeekQuantity1) AS QualityWeek,sum(T.MonthQuantity) as MonthQuantity ,sum(T.YearQuantity) as YearQuantity  from 
--( SELECT distinct Component,ShiftQuantity,ShiftQuantity1,DayQuantity,DayQuantity1,WeekQuantity,WeekQuantity1,MonthQuantity ,YearQuantity  from #ComponentwiseTemp C 
--where Component like '%Scroll Body%'
--) T 
--union
select  'Bearing Hub' as Component,sum(T.ShiftQuantity) as MachineShift ,sum(T.ShiftQuantity1) as QualityShift,sum(T.DayQuantity) as MachineDay,sum(T.DayQuantity1) as QualityDay,sum(T.WeekQuantity) as MachineWeek,sum(T.WeekQuantity1) AS QualityWeek,sum(T.MonthQuantity) as MonthQuantity ,sum(T.YearQuantity) as YearQuantity  from  
( SELECT distinct Component,ShiftQuantity,ShiftQuantity1,DayQuantity,DayQuantity1,WeekQuantity,WeekQuantity1,MonthQuantity ,YearQuantity  from #ComponentwiseTemp C 
where Component like '%Bearing Hub%'
) T 
UNION
select  'Scroll Welded' as Component,sum(T.ShiftQuantity) as MachineShift ,sum(T.ShiftQuantity1) as QualityShift,sum(T.DayQuantity) as MachineDay,sum(T.DayQuantity1) as QualityDay,sum(T.WeekQuantity) as MachineWeek,sum(T.WeekQuantity1) AS QualityWeek,sum(T.MonthQuantity) as MonthQuantity ,sum(T.YearQuantity) as YearQuantity  from  
( SELECT distinct Component,ShiftQuantity,ShiftQuantity1,DayQuantity,DayQuantity1,WeekQuantity,WeekQuantity1,MonthQuantity ,YearQuantity  from #ComponentwiseTemp C 
where Component like '%Scroll Welded%'
) T 

end
end
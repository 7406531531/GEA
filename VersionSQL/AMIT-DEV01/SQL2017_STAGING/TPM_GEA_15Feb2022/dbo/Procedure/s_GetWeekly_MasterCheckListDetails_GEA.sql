/****** Object:  Procedure [dbo].[s_GetWeekly_MasterCheckListDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/********************************************************************************
NR0157 - SwathiKS 
Created procedure to Generate Cheklist and Save into "ActivityMasterYearlyData_MGTL" Table
--[dbo].[s_GetWeekly_MasterCheckListDetails_GEA] '','','2019','','View'
--[dbo].[s_GetWeekly_MasterCheckListDetails_GEA] '','','2019','','GenerateFrequencyANDSave'

********************************************************************************/
CREATE PROCEDURE [dbo].[s_GetWeekly_MasterCheckListDetails_GEA]
@Line nvarchar(50)='',
@Machine nvarchar(50)='',
@Year nvarchar(50),
@Frequency nvarchar(50)='',
@param nvarchar(50)='' ----'GenerateFrequencyANDSave' OR 'View'
AS
BEGIN

SET NOCOUNT ON;


create table #Checklist
(
SlNo int,
ActivityID int,
Activity nvarchar(4000),
Method nvarchar(4000),
Criteria nvarchar(4000),
Frequency nvarchar(50),
WeekName nvarchar(50), 
MonthVal int, 
CheckValue int Default 0,
WeekNo int,
Machineid nvarchar(50), 
FreqID int
)

create table #TempCalender
(
WeekDate datetime, 
WeekName nvarchar(50), 
WeekNo int,
MonthVal int, 
YearNo nvarchar(50)
)

create table #Calender
(
WeekDate datetime, 
WeekName nvarchar(50), 
WeekNo int,
MonthVal int, 
YearNo nvarchar(50)
)


Insert into #TempCalender(WeekName, MonthVal, YearNo, weekno)
select cast(DateName(MM,WeekDate) as nvarchar(3)) + '-' + 'Week' +cast(WeekNumber as nvarchar(10)), MonthVal, YearNo,WeekNumber from Calender where YearNo=@Year
order by MonthVal,WeekNumber

Insert into #Calender(WeekName, MonthVal, YearNo, weekno)
select WeekName, MonthVal, YearNo, weekno from 
(select YearNo,WeekName,weekno,MonthVal,row_number() over(partition by weekno order by monthval,weekno) as rn from #TempCalender
)t where rn=1

if @param='GenerateFrequencyANDSave'
BEGIN

	insert into #Checklist(Machineid,ActivityID,Activity,FreqID,Frequency,WeekName,Method,Criteria,CheckValue,WeekNo,MonthVal)
	select M.MachineID,M.ActivityID,M.Activity,F.FreqID,F.Frequency as Frequency,C.WeekName,M.Method,M.Criteria,0,C.weekno,C.MonthVal
	from [ActivityMaster_MGTL] M 
	inner join [ActivityFreq_MGTL] F on M.FreqID=F.FreqID
	Cross join #Calender C
	where (M.Machineid=@Machine or isnull(@machine,'')='') and (F.Frequency=@Frequency or isnull(@frequency,'')='') 
	and F.Frequency<>'Daily'

	update #checklist set CheckValue=1 where Frequency='Weekly'

	update #checklist set CheckValue=1 from
	(select activityid,machineid,max(MonthVal) as MonthVal,Weekno from #Checklist
	where Frequency='Alternate Week' and Weekno%2<>0 group by activityid,machineid,Weekno)T inner join #Checklist on #Checklist.activityid=T.activityid and #Checklist.machineid=T.machineid
	and #Checklist.MonthVal=T.MonthVal and #Checklist.Weekno=T.Weekno where Frequency='Alternate Week'

	update #checklist set CheckValue=1 from
	(select activityid,machineid,MonthVal,max(Weekno) as weekno from #Checklist
	where Frequency='Last week of month' group by activityid,machineid,MonthVal)T inner join #Checklist on #Checklist.activityid=T.activityid and #Checklist.machineid=T.machineid
	and #Checklist.MonthVal=T.MonthVal and #Checklist.Weekno=T.Weekno where Frequency='Last week of month'

	update #checklist set CheckValue=1 from
	(select activityid,machineid,MonthVal,max(Weekno) as weekno from #Checklist
	where Frequency='Quarterly' and monthval%3=0 group by activityid,machineid,MonthVal)T inner join #Checklist on #Checklist.activityid=T.activityid and #Checklist.machineid=T.machineid
	and #Checklist.MonthVal=T.MonthVal and #Checklist.Weekno=T.Weekno where Frequency='Quarterly'

	update #checklist set CheckValue=1 from
	(select activityid,machineid,MonthVal,max(Weekno) AS weekno from #Checklist
	where Frequency='Half yearly' and MonthVal%6=0 group by activityid,machineid,MonthVal)T inner join #Checklist on #Checklist.activityid=T.activityid and #Checklist.machineid=T.machineid
	and #Checklist.MonthVal=T.MonthVal and #Checklist.Weekno=T.Weekno where Frequency='Half yearly'

	update #checklist set CheckValue=1 from
	(select activityid,machineid,MonthVal,max(Weekno) AS weekno from #Checklist
	where Frequency='Yearly' and MonthVal=12 group by activityid,machineid,MonthVal)T inner join #Checklist on #Checklist.activityid=T.activityid and #Checklist.machineid=T.machineid
	and #Checklist.MonthVal=T.MonthVal and #Checklist.Weekno=T.Weekno where Frequency='Yearly'

	Declare @SelectColumnName nvarchar(max)
	Declare @DynamicPivotQuery1 nvarchar(max)
		
	SET @SelectColumnName = STUFF((SELECT  ', ' + (QUOTENAME(weekname)) 
	FROM #calender
	group by weekname,weekno,monthval
	ORDER BY monthval,WeekNo
	FOR XML PATH(''), TYPE
	).value('.', 'nvarchar(MAX)') 
	,1,1,'');

	select @DynamicPivotQuery1=''
	SET @DynamicPivotQuery1 = 
	N'
	SELECT Machineid,ActivityID,Activity as Chekpoints,Method,Criteria,Frequency,FreqID,' + @SelectColumnName + ' 
	FROM (select distinct Machineid,ActivityID,Activity,Method,Criteria,WeekName,CheckValue,Frequency,FreqID
	from #Checklist
	)as s 
	PIVOT (sum(CheckValue)
	FOR [WeekName] IN (' + @SelectColumnName + ')) AS PVTTable2
	order by Activity'
	print(@DynamicPivotQuery1)
	EXEC sp_executesql @DynamicPivotQuery1

	IF EXISTS(Select * from ActivityMasterYearlyData_MGTL where year=@Year and MachineID=@Machine)
	Begin
		Delete From ActivityMasterYearlyData_MGTL where year=@Year and MachineID=@Machine
	END

	Insert into ActivityMasterYearlyData_MGTL(MachineID,ActivityID,Activity,FreqID,year,WeekNo,MonthNo)
	Select Machineid,ActivityID,Activity,FreqID,@YEAR,WeekNo,MonthVal from #Checklist where CheckValue=1
END

if @param='View'
BEGIN

	insert into #Checklist(Machineid,ActivityID,Activity,FreqID,Frequency,WeekName,Method,Criteria,CheckValue,WeekNo,MonthVal)
	select M.MachineID,M.ActivityID,M.Activity,F.FreqID,F.Frequency as Frequency,C.WeekName,M.Method,M.Criteria,0,C.weekno,C.MonthVal
	from [ActivityMaster_MGTL] M 
	inner join [ActivityFreq_MGTL] F on M.FreqID=F.FreqID
	Cross join #Calender C
	where (M.Machineid=@Machine or isnull(@machine,'')='') and (F.Frequency=@Frequency or isnull(@frequency,'')='') 
	and F.Frequency<>'Daily'

	update #Checklist set CheckValue=T.CheckVal from
	(Select AM.ActivityID,AM.FreqID,AM.machineid,AM.year,AM.WeekNo,1 as Checkval,AM.MonthNo from #Checklist C
	inner join [ActivityMasterYearlyData_MGTL] AM on C.Machineid=AM.machineid and C.ActivityID=AM.ActivityID and C.FreqID=AM.FreqID
	and C.WeekNo=AM.WeekNo and C.MonthVal=AM.MonthNo
	where AM.year=@Year)T inner join #Checklist C on C.Machineid=T.Machineid and C.ActivityID=T.ActivityID and C.FreqID=T.FreqID
	and C.WeekNo=T.WeekNo and C.MonthVal=T.MonthNo

	Declare @SelectColumnName1 nvarchar(max)
	Declare @DynamicPivotQuery2 nvarchar(max)
		
	SET @SelectColumnName1 = STUFF((SELECT  ', ' + (QUOTENAME(weekname)) 
	FROM #calender
	group by weekname,weekno,monthval
	ORDER BY monthval,WeekNo
	FOR XML PATH(''), TYPE
	).value('.', 'nvarchar(MAX)') 
	,1,1,'');

	select @DynamicPivotQuery2=''
	SET @DynamicPivotQuery2 = 
	N'
	SELECT Machineid,ActivityID,Activity as Chekpoints,Method,Criteria,Frequency,FreqID,' + @SelectColumnName1 + ' 
	FROM (select distinct Machineid,ActivityID,Activity,Method,Criteria,WeekName,CheckValue,Frequency,FreqID
	from #Checklist
	)as s 
	PIVOT (sum(CheckValue)
	FOR [WeekName] IN (' + @SelectColumnName1 + ')) AS PVTTable2
	order by Activity'
	print(@DynamicPivotQuery2)
	EXEC sp_executesql @DynamicPivotQuery2
END

END
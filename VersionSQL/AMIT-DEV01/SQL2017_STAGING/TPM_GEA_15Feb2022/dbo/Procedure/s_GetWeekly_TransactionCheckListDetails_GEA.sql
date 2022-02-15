/****** Object:  Procedure [dbo].[s_GetWeekly_TransactionCheckListDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/********************************************************************************
NR0157 - SwathiKS 
Created procedure to Save and View Weekly Cheklist Details.
--[dbo].[s_GetWeekly_TransactionCheckListDetails_GEA] 'view','','WFL M80 Mill Turn','2021-07-26',''
--[dbo].[s_GetWeekly_TransactionCheckListDetails_GEA] 'Report','','WFL M80 Mill Turn','2021-07-26',''
--[dbo].[s_GetWeekly_TransactionCheckListDetails_GEA] 'Save','','J-125','2019-04-29','21','1','Week9','1','Testing'

********************************************************************************/
CREATE PROCEDURE [dbo].[s_GetWeekly_TransactionCheckListDetails_GEA]
@Param nvarchar(50)='', ----'Save' OR 'View' OR 'Report'
@Line nvarchar(50)='',
@Machine nvarchar(50)='',
@Date nvarchar(50),
@freqid nvarchar(50)='',
@Activityid nvarchar(50)='',
@weekno nvarchar(10)='',
@ActivityValue nvarchar(50)='',
@Remarks nvarchar(1000)=''
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
CheckValue int,
WeekNo int,
Machineid nvarchar(50), 
FreqID int,
YearNo int,
Remarks nvarchar(1000)
)

create table #Calender
(
WeekDate datetime, 
WeekName nvarchar(50), 
WeekNo int,
MonthVal int, 
YearNo nvarchar(50),
PrevCurrentFutureWeek int
)

Declare @curtime as datetime
Select @curtime=GETDATE()


if @param='Save'
BEGIN

	Insert into #Calender(weekdate,MonthVal, YearNo, weekno,weekname)	
	select [dbo].[f_GetLogicalMonth](max(weekdate),'Start'),MonthVal, YearNo,WeekNumber,'Week' +cast(WeekNumber as nvarchar(10)) from Calender WHERE 'Week' +cast(WeekNumber as nvarchar(10))=@weekno and YearNo=datepart(YYYY,@Date)
	group by MonthVal, YearNo,WeekNumber

	IF NOT EXISTS(Select * from ActivityTransaction_MGTL where machineid=@Machine and ActivityID=@Activityid and Frequency=@freqid and WeekNo=@weekno and datepart(YYYY,ActivityTS)=datepart(YYYY,@Date)) 
	BEGIN
		insert into ActivityTransaction_MGTL(ActivityID, Frequency, ActivityTS, ActivityDoneTS, Machineid, Remarks, WeekNo, ActivityValue)
		Select @ActivityID, @freqid, weekdate, @curtime, @Machine, @Remarks, WeekName, @ActivityValue from #Calender
	END
	ELSE
	BEGIN
		update ActivityTransaction_MGTL set WeekNo=@weekno,ActivityDoneTS=@curtime,ActivityTS=@Date,Remarks=@Remarks,ActivityValue=@ActivityValue
		where machineid=@Machine and ActivityID=@Activityid and Frequency=@freqid and WeekNo=@weekno and datepart(YYYY,ActivityTS)=datepart(YYYY,@Date) --and datepart(MM,ActivityTS)=datepart(MM,@Date)
	END

Return;
END

if @param='View' 
BEGIN
	Insert into #Calender(WeekDate, WeekName, MonthVal, YearNo, weekno)
	select WeekDate,cast(DateName(MM,WeekDate) as nvarchar(3)) + '-' + 'Week' +cast(WeekNumber as nvarchar(10)), MonthVal, YearNo,WeekNumber 
	from Calender where YearNo=datepart(YYYY,@Date) and Monthval=datepart(MM,@Date) order by MonthVal,WeekNumber

	update #Calender set PrevCurrentFutureWeek=case when WeekNo<datepart(Week,@curtime) then 1 
	when WeekNo=datepart(Week,@curtime) then 2  when WeekNo>datepart(Week,@curtime) then 3  end

END

if @param='Report'
BEGIN
	Insert into #Calender(WeekDate, WeekName, MonthVal, YearNo, weekno)
	select WeekDate,cast(DateName(MM,WeekDate) as nvarchar(3)) + '-' + 'Week' +cast(WeekNumber as nvarchar(10)), MonthVal, YearNo,WeekNumber 
	from Calender where YearNo=datepart(YYYY,@Date) order by MonthVal,WeekNumber

	--select m.id,m.MachineID,m.UpdatedBy,e.name as Name,m.UpdatedTS,m.WeekNo,m.YearNo from MaintainanceInfo m 
	--left outer join employeeinformation e on e.employeeid=m.UpdatedBy
	--where MachineID=@Machine AND WeekNo=datepart(Week,@Date) and  YearNo=datepart(YYYY,@Date)
	----select * from MaintainanceInfo where MachineID=@Machine AND WeekNo = (select weekNumber from calender where WeekDate=(cast (@Date as date))) and YearNo=(select YearNo from calender where WeekDate=(cast (@Date as date)))
END


insert into #Checklist(Machineid,ActivityID,Activity,FreqID,Frequency,WeekName,Method,Criteria,WeekNo,MonthVal,YearNo)
select M.MachineID,M.ActivityID,M.Activity,F.FreqID,F.Frequency as Frequency,C.WeekName,M.Method,M.Criteria,C.weekno,C.MonthVal,C.YearNo
from [ActivityMaster_MGTL] M 
inner join [ActivityFreq_MGTL] F on M.FreqID=F.FreqID 
Cross join (Select max(WeekDate) as weekdate, WeekName, MonthVal, YearNo, weekno from #Calender group by WeekName, MonthVal, YearNo, weekno) C
where (M.Machineid=@Machine or isnull(@machine,'')='') and F.Frequency<>'Daily' and M.IsMandatory=1


---By Default ChekValue will be Empty "0" Means Scheduled
update #Checklist set CheckValue=T.ActivityScheduled from
(
select C.MachineID,C.ActivityID,C.FreqID,C.weekno,C.MonthVal,C.YearNo,0 as ActivityScheduled from #Checklist C
inner join ActivityMasterYearlyData_MGTL AY on C.ActivityID=AY.ActivityID and C.FreqID=AY.FreqID and AY.MachineID=C.MachineID and 
C.YearNo=AY.year and C.WeekNo=AY.WeekNo --and AY.MonthNo=C.MonthVal 
)T inner join #Checklist C on C.Machineid=T.Machineid and C.ActivityID=T.ActivityID and C.FreqID=T.FreqID
and C.WeekNo=T.WeekNo and C.MonthVal=T.MonthVal

---"4" means Scheduled For FutureWeek
update #Checklist set CheckValue=4 where checkvalue=0 and WeekNo in(Select distinct WeekNo from #Calender where PrevCurrentFutureWeek=3) 

---"1 or 2 or 3" means Scheduled and activity completed taken from transaction
update #Checklist set CheckValue=T.CheckVal from
(Select C.ActivityID,C.FreqID,C.machineid,C.YearNo,C.WeekNo,max(T.ActivityValue) as Checkval,C.MonthVal from #Checklist C
inner join [ActivityTransaction_MGTL] T on C.Machineid=T.machineid and C.ActivityID=T.ActivityID and C.FreqID=T.Frequency
and 'Week' +cast(C.WeekNo as nvarchar(10))=T.WeekNo and C.YearNo=datepart(YYYY,ActivityTS) --and C.MonthVal=datepart(MM,ActivityTS) 
group by C.ActivityID,C.FreqID,C.machineid,C.YearNo,C.WeekNo,C.MonthVal
)T inner join #Checklist C on C.Machineid=T.Machineid and C.ActivityID=T.ActivityID and C.FreqID=T.FreqID
and C.WeekNo=T.WeekNo and C.MonthVal=T.MonthVal

---"2" means Scheduled but Not Done For Previous Weeks
update #Checklist set CheckValue=2 where CheckValue=0 and WeekNo in(Select distinct WeekNo from #Calender where PrevCurrentFutureWeek=1) 

---"5" means Scheduled but Not Done For the Current Week
update #Checklist set CheckValue=5 where CheckValue=0 and WeekNo in(Select distinct WeekNo from #Calender where PrevCurrentFutureWeek=2) 

update #Checklist set CheckValue=0 where CheckValue IS NULL


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
FROM (select Machineid,ActivityID,Activity,Method,Criteria,WeekName,CheckValue,Frequency,freqid
from #Checklist
)as s 
PIVOT (sum(CheckValue)
FOR [WeekName] IN (' + @SelectColumnName + ')) AS PVTTable2
order by Activity'
print(@DynamicPivotQuery1)
EXEC sp_executesql @DynamicPivotQuery1

if @param='View2'
begin
	select m.id,m.MachineID,m.UpdatedBy,e.name as Name,m.UpdatedTS,m.WeekNo,m.YearNo from MaintainanceInfo m 
	left outer join employeeinformation e on e.employeeid=m.UpdatedBy
	where MachineID=@Machine --AND WeekNo=datepart(Week,@Date) --swathi commented
	and  YearNo=datepart(YYYY,@Date)
	--select * from MaintainanceInfo where MachineID=@Machine AND WeekNo = (select weekNumber from calender where WeekDate=(cast (@Date as date))) and YearNo=(select YearNo from calender where WeekDate=(cast (@Date as date)))
END



END
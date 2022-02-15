/****** Object:  Procedure [dbo].[s_GetDailyCheckListDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/********************************************************************************

NR0157 - SwathiKS 
Created procedure to Generate DAILY Cheklist
--[dbo].[s_GetDailyCheckListDetails_GEA] '','','J-125','Daily','GenerateFrequency'
--[dbo].[s_GetDailyCheckListDetails_GEA] '2019-05-13','','J-125','Daily','View'
--[dbo].[s_GetDailyCheckListDetails_GEA] '2020-04-01','','J-125','Daily','Report'
--[dbo].[s_GetDailyCheckListDetails_GEA] '2021-07-01 00:00:00.000','','Assembly','Daily','Report'

********************************************************************************/
CREATE PROCEDURE [dbo].[s_GetDailyCheckListDetails_GEA]
@Startdate datetime='',
@Line nvarchar(50)='',
@Machine nvarchar(50)='',
@Frequency nvarchar(50)='',
@param nvarchar(50)='' ----'GenerateFrequencyANDSave' OR 'View'
AS
BEGIN

SET NOCOUNT ON;


create table #Checklist
(
ActivityID int,
Activity nvarchar(4000),
Method nvarchar(4000),
Criteria nvarchar(4000),
Frequency nvarchar(50),
TemplateType nvarchar(100), 
CheckValue nvarchar(50),
Machineid nvarchar(50),
FreqID int,
IsMandatory int,
Daystart Datetime,
DayEnd Datetime,
activityTS datetime,
Remarks nvarchar(1000)
)


if @param='GenerateFrequency'
BEGIN
	insert into #Checklist(Machineid,ActivityID,Activity,FreqID,Frequency,Method,Criteria,TemplateType,IsMandatory)
	select M.MachineID,M.ActivityID,M.Activity,F.FreqID,F.Frequency,M.Method,M.Criteria,M.TemplateType,M.IsMandatory
	from [ActivityMaster_MGTL] M 
	inner join [ActivityFreq_MGTL] F on M.FreqID=F.FreqID
	where (M.Machineid=@Machine or isnull(@machine,'')='') and (F.Frequency=@Frequency or isnull(@frequency,'')='') 
	and F.Frequency='Daily'

	Select ROW_number() over(Order by activity) as CheckPointID,Activity as CheckPoints,Method,Criteria,TemplateType,IsMandatory,
	Machineid,ActivityID,FreqID,Frequency from #Checklist
END

if @param='View'
BEGIN

	insert into #Checklist(Machineid,ActivityID,Activity,FreqID,Frequency,Method,Criteria,TemplateType,IsMandatory)
	select M.MachineID,M.ActivityID,M.Activity,F.FreqID,F.Frequency as Frequency,M.Method,M.Criteria,M.TemplateType,M.IsMandatory
	from [ActivityMaster_MGTL] M 
	inner join [ActivityFreq_MGTL] F on M.FreqID=F.FreqID
	where (M.Machineid=@Machine or isnull(@machine,'')='') and (F.Frequency=@Frequency or isnull(@frequency,'')='') 
	and F.Frequency='Daily' and M.IsMandatory=1

	update #Checklist set CheckValue=T.CheckVal,activityTS=T.ActivityTS,Remarks=T.Remarks from
	(Select AM.ActivityID,AM.machineid,AM.Frequency,AM.ActivityValue as Checkval,AM.ActivityTS,AM.Remarks from #Checklist C
	inner join [ActivityTransaction_MGTL] AM on C.Machineid=AM.machineid and C.ActivityID=AM.ActivityID and C.FreqID=AM.Frequency
	and Convert(nvarchar(10),AM.activityts,120)=Convert(nvarchar(10),@Startdate,120))T inner join #Checklist C on C.Machineid=T.Machineid and C.ActivityID=T.ActivityID 
	and C.FreqID=T.Frequency

	Select ROW_number() over(Order by activity) as CheckPointID,ActivityID,Activity as CheckPoints,Method,Criteria,FreqID,Frequency,CheckValue,TemplateType,IsMandatory,Remarks,activityTS,Machineid from #Checklist


	Declare @CountOfMandatory as int,@CountOfTransaction as int
	Select @CountOfMandatory=ISNULL(Count(*),0) from #Checklist where IsMandatory=1 
	Select @CountOfTransaction=ISNULL(Count(*),0) from #Checklist where IsMandatory=1 and [ActivityTS]<>'' and [ActivityTS] is not null

	if @CountOfTransaction=@CountOfMandatory
	BEGIN
		select 'Enable' as 'Procced'
	END
	ELSE
	BEGIN
		select 'Disable' as 'Procced'
	END
END

If @param='Report'
Begin
  create table #Day
  (
	Daystart Datetime,
	DayEnd Datetime
   )

   declare @Curdate as datetime,@Enddate as datetime
   Select @Curdate=@Startdate
   Select @Enddate=dateadd(month,1,dbo.f_GetLogicalDayStart(@Startdate))

   WHILE @Curdate<=@Enddate
   BEGIN
   Insert into #day(Daystart,DayEnd)
   select @Curdate,dateadd(day,1,@Curdate)
   Select @Curdate=dateadd(day,1,@Curdate)
   END

	insert into #Checklist(Machineid,ActivityID,Activity,FreqID,Frequency,Method,Criteria,TemplateType,DayStart,DayEnd)
	select M.MachineID,M.ActivityID,M.Activity,F.FreqID,F.Frequency as Frequency,M.Method,M.Criteria,M.TemplateType,#Day.DayStart,#Day.DayEnd
	from [ActivityMaster_MGTL] M 
	inner join [ActivityFreq_MGTL] F on M.FreqID=F.FreqID
	Cross join #Day
	where (M.Machineid=@Machine or isnull(@machine,'')='') and (F.Frequency=@Frequency or isnull(@frequency,'')='') 
	and F.Frequency='Daily' and M.IsMandatory=1

	update #Checklist set CheckValue=T.CheckVal from
	(Select AM.ActivityID,AM.machineid,AM.Frequency,AM.ActivityValue as Checkval,C.DayStart,C.DayEnd from #Checklist C
	inner join [ActivityTransaction_MGTL] AM on C.Machineid=AM.machineid and C.ActivityID=AM.ActivityID and C.FreqID=AM.Frequency
	and Convert(nvarchar(10),AM.activityts,120)=Convert(nvarchar(10),C.DayStart,120))T inner join #Checklist C on C.Machineid=T.Machineid and C.ActivityID=T.ActivityID 
	and C.FreqID=T.Frequency and Convert(nvarchar(10),T.DayStart,120)=Convert(nvarchar(10),C.DayStart,120)
	
	Declare @SelectColumnName nvarchar(max)
	Declare @DynamicPivotQuery1 nvarchar(max)
		
	SET @SelectColumnName = STUFF((SELECT  ', ' + (QUOTENAME(convert(nvarchar(10),daystart,120))) 
	FROM #Day group by daystart ORDER BY daystart
	FOR XML PATH(''), TYPE
	).value('.', 'nvarchar(MAX)') 
	,1,1,''); 

	select @DynamicPivotQuery1=''
	SET @DynamicPivotQuery1 = 
	N'
	SELECT Machineid,Activity,Method,Criteria,TemplateType,FreqID,Frequency,' + @SelectColumnName + '
	FROM (select Machineid,Activity,Method,Criteria,TemplateType,convert(nvarchar(10),DayStart,120) as DayStart,CheckValue,FreqID,Frequency
	from #Checklist
	)as s 
	PIVOT (Max(CheckValue)
	FOR [DayStart] IN (' + @SelectColumnName + ')) AS PVTTable2
	order by Activity'

	EXEC sp_executesql @DynamicPivotQuery1



	Select @Curdate=@Startdate
	Select @Enddate=dateadd(month,1,dbo.f_GetLogicalDayStart(@Startdate))

   select d.machineid,d.UpdatedBy,e.Name as Name,d.UpdatedTS,d.Role,d.Date from DailyCheckInfo d
   left outer join employeeinformation e on e.Employeeid=d.UpdatedBy
   where MachineID=@Machine and date>=@Curdate and date<=@Enddate

END

END
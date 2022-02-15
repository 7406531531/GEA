/****** Object:  Procedure [dbo].[S_ViewSchedulerDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_ViewSchedulerDetails_GEA] 'WFL M50 Mill Turn','New,Running,Parked,Completed,Pending Inspection Completion','','','',''
CREATE PROCEDURE [dbo].[S_ViewSchedulerDetails_GEA]
@Machineid NVARCHAR(50),
@Status NVARCHAR(500)='',
@ProductionOrder NVARCHAR(50)='',
@MaterialID NVARCHAR(50)='',
@Fromdate DATETIME='',
@ToDate DATETIME=''

AS
BEGIN

SET NOCOUNT ON --added to prevent extra result sets from interfering with SELECT statements.

create table #Scheduler
(
IDD bigint identity(1,1) NOT NULL,
SCHPriority int,
PONumber nvarchar(50),
MaterialID nvarchar(50),
Model nvarchar(50),
ModelDescription nvarchar(50),
Opnno nvarchar(50),
Qty int,
StdCycleTime float,
StdSetupTime float,
ScheduledStarttime datetime,
ScheduledEndtime datetime,
ActualStartTime datetime,
PredictedCompletion datetime,
ActualEndtime datetime,
SCHStatus nvarchar(50),
SCHID bigint,
UserPriority int,
GrnNo nvarchar(50),
Supplier nvarchar(50),
NewProdDevelopment bit,
SamplingQty int
)

Declare @strsql As nvarchar(max)
Select @strsql=''

Declare @StartEnd as nvarchar(1000)
Select @StartEnd=''

If @Fromdate<>'' and @ToDate<>''
BEgin
select @StartEnd= ' and (S.ScheduleStart>='''+ convert(nvarchar(20),@fromdate,120) +''' and S.ScheduleStart<='''+ convert(nvarchar(20),@ToDate,120) +''')'
End


DECLARE @joined NVARCHAR(1000)
select @joined = coalesce(@joined + ',''', '''')+item+'''' from [SplitStrings](@Status, ',')
if @joined = ''''''
set @joined = ''


Select @strsql='
Insert into #Scheduler(SCHPriority,PONumber,MaterialID,Opnno,Model,ModelDescription,Qty,stdcycletime,StdSetupTime,ScheduledStarttime,ScheduledEndtime,
ActualStartTime,PredictedCompletion,SCHStatus,SCHID,UserPriority,GrnNo,Supplier,NewProdDevelopment,SamplingQty)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,
--COP.cycletime,
 CASE WHEN '''+@Machineid+'''=''Quality Incoming'' then COP.cycletime*s.ScheduleQty ELSE cop.cycletime END AS cycletime,
COP.StdSetupTime,
S.ScheduleStart,S.ScheduleEnd,R.ActualStarttime,R.TentativeEndtime,S.Status,S.IDD,S.UserPriority,S.GrnNo,S.Supplier,S.NewProdDevelopment,S.SamplingQty
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
Left outer join RunningScheduleDetails_GEA R on R.Machineid=S.Machineid and R.MaterialID=S.MaterialID and R.OperationNo=S.OperationNo and R.ProductionOrder=S.ProductionOrder
and isnull(R.GrnNo,'''')=isnull(S.GrnNo,'''') '
Select @strsql=@strsql+ ' Where S.Machineid='''+@Machineid+''' And (S.ProductionOrder like '''+ @ProductionOrder + '%' + ''')
And (S.MaterialID like '''+ @MaterialID + '%' + ''') '
Select @strsql=@strsql+ @StartEnd
Select @strsql=@strsql+ ' And S.status=''Running''
Order by S.SchedulePriority'
print(@strsql)
exec(@strsql)

select @strsql=''
Select @strsql='
Insert into #Scheduler(SCHPriority,PONumber,MaterialID,Opnno,Model,ModelDescription,Qty,stdcycletime,StdSetupTime,ScheduledStarttime,ScheduledEndtime,
SCHStatus,SCHID,UserPriority,GrnNo,Supplier,NewProdDevelopment,SamplingQty)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,
--COP.cycletime,
CASE WHEN '''+@Machineid+'''=''Quality Incoming'' then COP.cycletime*s.ScheduleQty ELSE cop.cycletime END AS cycletime,
COP.StdSetupTime,
S.ScheduleStart,S.ScheduleEnd,S.Status,S.IDD,S.UserPriority,S.GrnNo,S.Supplier,S.NewProdDevelopment,S.SamplingQty
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno'
Select @strsql=@strsql+ ' Where S.Machineid='''+@Machineid+''' And (S.ProductionOrder like '''+ @ProductionOrder + '%' + ''')
And (S.MaterialID like '''+ @MaterialID + '%' + ''') '
Select @strsql=@strsql+ @StartEnd
Select @strsql=@strsql+ ' And S.status in(''New'')
Order by S.SchedulePriority'
print(@strsql)
exec(@strsql)

select @strsql=''
Select @strsql='
Insert into #Scheduler(SCHPriority,PONumber,MaterialID,Opnno,Model,ModelDescription,Qty,stdcycletime,StdSetupTime,ScheduledStarttime,ScheduledEndtime,
SCHStatus,SCHID,UserPriority,GrnNo,Supplier,NewProdDevelopment,SamplingQty)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,
--COP.cycletime,
CASE WHEN '''+@Machineid+'''=''Quality Incoming'' then COP.cycletime*s.ScheduleQty ELSE cop.cycletime END AS cycletime,
COP.StdSetupTime,
S.ScheduleStart,S.ScheduleEnd,S.Status,S.IDD,S.UserPriority,S.GrnNo,S.Supplier,S.NewProdDevelopment,S.SamplingQty
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno'
Select @strsql=@strsql+ ' Where S.Machineid='''+@Machineid+''' And (S.ProductionOrder like '''+ @ProductionOrder + '%' + ''')
And (S.MaterialID like '''+ @MaterialID + '%' + ''') '
Select @strsql=@strsql+ @StartEnd
Select @strsql=@strsql+ ' And S.status in(''Parked'')
Order by S.SchedulePriority'
print(@strsql)
exec(@strsql)

select @strsql=''
SELECT @strsql='
Insert into #Scheduler(SCHPriority,PONumber,MaterialID,Opnno,Model,ModelDescription,Qty,stdcycletime,StdSetupTime,ScheduledStarttime,ScheduledEndtime,
SCHStatus,SCHID,ActualStartTime,PredictedCompletion,ActualEndtime,UserPriority,GrnNo,Supplier,NewProdDevelopment,SamplingQty)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,
--COP.cycletime,
CASE WHEN '''+@Machineid+'''=''Quality Incoming'' then COP.cycletime*s.ScheduleQty ELSE cop.cycletime END AS cycletime,
COP.StdSetupTime,
S.ScheduleStart,S.ScheduleEnd,S.Status,S.IDD,S.ActualStartTime,S.TentativeEndtime,S.ActualEndtime,S.UserPriority,S.GrnNo,S.Supplier,S.NewProdDevelopment,S.SamplingQty
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno'
SELECT @strsql=@strsql+ ' Where S.Machineid='''+@Machineid+''' And (S.ProductionOrder like '''+ @ProductionOrder + '%' + ''')
And (S.MaterialID like '''+ @MaterialID + '%' + ''') '
SELECT @strsql=@strsql+ @StartEnd
SELECT @strsql=@strsql+ ' And S.status in(''Pending Inspection Completion'')
Order by S.SchedulePriority'
PRINT(@strsql)
EXEC(@strsql)


SELECT @strsql=''
SELECT @strsql='
Insert into #Scheduler(SCHPriority,PONumber,MaterialID,Opnno,Model,ModelDescription,Qty,stdcycletime,StdSetupTime,ScheduledStarttime,ScheduledEndtime,
SCHStatus,SCHID,ActualStartTime,PredictedCompletion,ActualEndtime,UserPriority,GrnNo,Supplier,NewProdDevelopment,SamplingQty)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,
--COP.cycletime,
CASE WHEN '''+@Machineid+'''=''Quality Incoming'' then COP.cycletime*s.ScheduleQty ELSE cop.cycletime END AS cycletime,
COP.StdSetupTime,
S.ScheduleStart,S.ScheduleEnd,S.Status,S.IDD,S.ActualStartTime,S.TentativeEndtime,S.ActualEndtime,S.UserPriority,S.GrnNo,S.Supplier,S.NewProdDevelopment,S.SamplingQty
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno'
SELECT @strsql=@strsql+ ' Where S.Machineid='''+@Machineid+''' And (S.ProductionOrder like '''+ @ProductionOrder + '%' + ''')
And (S.MaterialID like '''+ @MaterialID + '%' + ''') '
SELECT @strsql=@strsql+ @StartEnd
SELECT @strsql=@strsql+ ' And S.status in(''Completed'')
Order by S.SchedulePriority'
PRINT(@strsql)
EXEC(@strsql)

SELECT @strsql=''
SELECT @strsql= @strsql+
'select SCHPriority,PONumber,MaterialID,Opnno,Model,ModelDescription,Qty, dbo.f_FormatTime(stdcycletime,''mm'') as stdcycletime,
dbo.f_FormatTime(StdSetupTime,''mm'') as StdSetupTime,ScheduledStarttime,ScheduledEndtime,
SCHStatus,SCHID,ActualStartTime,PredictedCompletion,ActualEndtime,UserPriority,GrnNo,Supplier,NewProdDevelopment,SamplingQty from #Scheduler'
IF @Status<>''
BEGIN
SELECT @strsql= @strsql+ ' where SCHStatus in('+ @joined +') '
END
SELECT @strsql= @strsql+ ' Order by idd'
PRINT(@strsql)
EXEC(@strsql)


END
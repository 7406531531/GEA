/****** Object:  Procedure [dbo].[S_ViewAssemblySchedulerDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--ER0506 : SwathiKS : 08/Jun/2021::To handle stdcycletime at suboperation Level.
--[dbo].[S_ViewAssemblySchedulerDetails_GEA] 'Assembly','New,Running,Parked,Completed,Pending Inspection Completion','','','',''
CREATE PROCEDURE [dbo].[S_ViewAssemblySchedulerDetails_GEA]
@Machineid nvarchar(50),
@Status nvarchar(500)='',
@ProductionOrder nvarchar(50)='',
@MaterialID nvarchar(50)='',
@Fromdate datetime='',
@ToDate datetime=''

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
Localorexport nvarchar(50),
SaleOrder nvarchar(50),
ScrollWelded nvarchar(50),
RDDMachines datetime,
FabricationNo nvarchar(50),
Customer nvarchar(50),
Location nvarchar(50),
SubActivities nvarchar(max)
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
ActualStartTime,PredictedCompletion,SCHStatus,SCHID,UserPriority,Localorexport,SaleOrder,ScrollWelded,RDDMachines,FabricationNo,Customer,Location)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,AR.StdCycletime,AR.StdSetupTime, --ER0506
S.ScheduleStart,S.ScheduleEnd,R.ActualStarttime,R.TentativeEndtime,S.Status,S.IDD,S.UserPriority,
S.Localorexport,S.SaleOrder,S.ScrollWelded,S.RDDMachines,S.FabricationNo,S.Customer,S.Location
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
Left outer join RunningScheduleDetails_GEA R on R.Machineid=S.Machineid and R.MaterialID=S.MaterialID and R.OperationNo=S.OperationNo and R.ProductionOrder=S.ProductionOrder
and R.FabricationNo=S.FabricationNo 
inner join (select distinct AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo,SUM(AM.StdCycletime) as StdCycletime,SUM(AM.StdSetupTime) as StdSetupTime from AssemblyActivityMaster_GEA AM
inner join AssemblyActivitySchedules_GEA AR on AR.Machineid=AM.Station and AR.activity=AM.Activity and AR.MaterialID=AM.Componentid
group by AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo) AR on R.Machineid=AR.machineid and R.MaterialID=AR.MaterialID and R.OperationNo=AR.operationno and R.ProductionOrder=AR.ProductionOrder 
AND R.FabricationNo=AR.FabricationNo ' --ER0506
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
SCHStatus,SCHID,UserPriority,Localorexport,SaleOrder,ScrollWelded,RDDMachines,FabricationNo,Customer,Location)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,AR.StdCycletime,AR.StdSetupTime, --ER0506
S.ScheduleStart,S.ScheduleEnd,S.Status,S.IDD,S.UserPriority,
S.Localorexport,S.SaleOrder,S.ScrollWelded,S.RDDMachines,S.FabricationNo,S.Customer,S.Location
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
inner join (select distinct AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo,SUM(AM.StdCycletime) as StdCycletime,SUM(AM.StdSetupTime) as StdSetupTime from AssemblyActivityMaster_GEA AM
inner join AssemblyActivitySchedules_GEA AR on AR.Machineid=AM.Station and AR.activity=AM.Activity and AR.MaterialID=AM.Componentid
group by AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo) AR on S.Machineid=AR.machineid and S.MaterialID=AR.MaterialID and S.OperationNo=AR.operationno and S.ProductionOrder=AR.ProductionOrder 
AND S.FabricationNo=AR.FabricationNo ' --ER0506
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
SCHStatus,SCHID,UserPriority,Localorexport,SaleOrder,ScrollWelded,RDDMachines,FabricationNo,Customer,Location)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,AR.StdCycletime,AR.StdSetupTime, --ER0506
S.ScheduleStart,S.ScheduleEnd,S.Status,S.IDD,S.UserPriority,
S.Localorexport,S.SaleOrder,S.ScrollWelded,S.RDDMachines,S.FabricationNo,S.Customer,S.Location
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
inner join (select distinct AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo,SUM(AM.StdCycletime) as StdCycletime,SUM(AM.StdSetupTime) as StdSetupTime from AssemblyActivityMaster_GEA AM
inner join AssemblyActivitySchedules_GEA AR on AR.Machineid=AM.Station and AR.activity=AM.Activity and AR.MaterialID=AM.Componentid
group by AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo) AR on S.Machineid=AR.machineid and S.MaterialID=AR.MaterialID and S.OperationNo=AR.operationno and S.ProductionOrder=AR.ProductionOrder 
AND S.FabricationNo=AR.FabricationNo ' --ER0506
Select @strsql=@strsql+ ' Where S.Machineid='''+@Machineid+''' And (S.ProductionOrder like '''+ @ProductionOrder + '%' + ''')
And (S.MaterialID like '''+ @MaterialID + '%' + ''') '
Select @strsql=@strsql+ @StartEnd
Select @strsql=@strsql+ ' And S.status in(''Parked'')
Order by S.SchedulePriority'
print(@strsql)
exec(@strsql)

select @strsql=''
Select @strsql='
Insert into #Scheduler(SCHPriority,PONumber,MaterialID,Opnno,Model,ModelDescription,Qty,stdcycletime,StdSetupTime,ScheduledStarttime,ScheduledEndtime,
SCHStatus,SCHID,ActualStartTime,PredictedCompletion,ActualEndtime,UserPriority,Localorexport,SaleOrder,ScrollWelded,RDDMachines,FabricationNo,Customer,Location)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,AR.StdCycletime,AR.StdSetupTime, --ER0506
S.ScheduleStart,S.ScheduleEnd,S.Status,S.IDD,S.ActualStartTime,S.TentativeEndtime,S.ActualEndtime,S.UserPriority,
S.Localorexport,S.SaleOrder,S.ScrollWelded,S.RDDMachines,S.FabricationNo,S.Customer,S.Location
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
inner join (select distinct AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo,SUM(AM.StdCycletime) as StdCycletime,SUM(AM.StdSetupTime) as StdSetupTime from AssemblyActivityMaster_GEA AM
inner join AssemblyActivitySchedules_GEA AR on AR.Machineid=AM.Station and AR.activity=AM.Activity and AR.MaterialID=AM.Componentid
group by AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo) AR on S.Machineid=AR.machineid and S.MaterialID=AR.MaterialID and S.OperationNo=AR.operationno and S.ProductionOrder=AR.ProductionOrder 
AND S.FabricationNo=AR.FabricationNo ' --ER0506
Select @strsql=@strsql+ ' Where S.Machineid='''+@Machineid+''' And (S.ProductionOrder like '''+ @ProductionOrder + '%' + ''')
And (S.MaterialID like '''+ @MaterialID + '%' + ''') '
Select @strsql=@strsql+ @StartEnd
Select @strsql=@strsql+ ' And S.status in(''Pending Inspection Completion'')
Order by S.SchedulePriority'
print(@strsql)
exec(@strsql)


select @strsql=''
Select @strsql='
Insert into #Scheduler(SCHPriority,PONumber,MaterialID,Opnno,Model,ModelDescription,Qty,stdcycletime,StdSetupTime,ScheduledStarttime,ScheduledEndtime,
SCHStatus,SCHID,ActualStartTime,PredictedCompletion,ActualEndtime,UserPriority,Localorexport,SaleOrder,ScrollWelded,RDDMachines,FabricationNo,Customer,Location)
Select S.SchedulePriority,S.ProductionOrder,S.MaterialID,S.OperationNo,substring(C.description,charindex(''['',C.description,1)+1,charindex('']['',C.description)-2) as Model,
substring(C.description,charindex(''['',C.description,2)+1,len(C.description)-charindex('']'',C.description)-2) as description,S.ScheduleQty,AR.StdCycletime,AR.StdSetupTime, --ER0506
S.ScheduleStart,S.ScheduleEnd,S.Status,S.IDD,S.ActualStartTime,S.TentativeEndtime,S.ActualEndtime,S.UserPriority,
S.Localorexport,S.SaleOrder,S.ScrollWelded,S.RDDMachines,S.FabricationNo,S.Customer,S.Location
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
inner join (select distinct AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo,SUM(AM.StdCycletime) as StdCycletime,SUM(AM.StdSetupTime) as StdSetupTime from AssemblyActivityMaster_GEA AM
inner join AssemblyActivitySchedules_GEA AR on AR.Machineid=AM.Station and AR.activity=AM.Activity and AR.MaterialID=AM.Componentid
group by AR.machineid,AR.MaterialID,AR.operationno,AR.ProductionOrder,AR.FabricationNo) AR on S.Machineid=AR.machineid and S.MaterialID=AR.MaterialID and S.OperationNo=AR.operationno and S.ProductionOrder=AR.ProductionOrder 
AND S.FabricationNo=AR.FabricationNo ' --ER0506
Select @strsql=@strsql+ ' Where S.Machineid='''+@Machineid+''' And (S.ProductionOrder like '''+ @ProductionOrder + '%' + ''')
And (S.MaterialID like '''+ @MaterialID + '%' + ''') '
Select @strsql=@strsql+ @StartEnd
Select @strsql=@strsql+ ' And S.status in(''Completed'')
Order by S.SchedulePriority'
print(@strsql)
exec(@strsql)

Update #Scheduler set SubActivities=T1.[Activities] FROM
(
SELECT 
   S.MaterialID,S.Opnno,S.PONumber,S.FabricationNo,
   STUFF((SELECT '; ' + A.Activity
          FROM [dbo].[AssemblyActivitySchedules_GEA] A
          WHERE A.MaterialID=S.MaterialID and A.OperationNo=S.Opnno and A.ProductionOrder=S.PONumber and A.FabricationNo=S.FabricationNo
          FOR XML PATH('')), 1, 1, '') [Activities]
FROM #Scheduler S
GROUP BY S.MaterialID,S.Opnno,S.PONumber,S.FabricationNo
)T1 inner join #Scheduler on #Scheduler.MaterialID=T1.MaterialID and #Scheduler.Opnno=T1.Opnno and #Scheduler.PONumber=T1.PONumber and #Scheduler.FabricationNo=T1.FabricationNo

select @strsql=''
select @strsql= @strsql+
'select SCHPriority,PONumber,MaterialID,Opnno,Model,ModelDescription,Qty, dbo.f_FormatTime(stdcycletime,''mm'') as stdcycletime,
dbo.f_FormatTime(StdSetupTime,''mm'') as StdSetupTime,ScheduledStarttime,ScheduledEndtime,
SCHStatus,SCHID,ActualStartTime,PredictedCompletion,ActualEndtime,UserPriority,
Localorexport,SaleOrder,ScrollWelded,RDDMachines,FabricationNo,Customer,Location,SubActivities from #Scheduler'
If @Status<>''
Begin
select @strsql= @strsql+ ' where SCHStatus in('+ @joined +') '
END
select @strsql= @strsql+ ' Order by idd'
print(@strsql)
exec(@strsql)


END
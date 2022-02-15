/****** Object:  Procedure [dbo].[S_GetAssemblyPOSchedule_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

 

--ER0506 : SwathiKS : 08/Jun/2021::To handle stdcycletime at suboperation Level.

 

--[dbo].[S_GetAssemblyPOSchedule_GEA] 'Assembly','','','',''
--[dbo].[S_GetAssemblyPOSchedule_GEA] 'Assembly','840015887','345','9001','Running,Parked','8062-711','','2021-02-05 11:43:00.000'

 

CREATE PROCEDURE [dbo].[S_GetAssemblyPOSchedule_GEA]
@Machineid nvarchar(50),
@ProductionOrder nvarchar(50)='',
@MaterialID nvarchar(50)='',
@OperationNo nvarchar(50)='',
@ScheduleStatus nvarchar(50)='',
@fabricationNo nvarchar(50)='',
@param nvarchar(50)='',
@CycleStartTS datetime=''
AS
BEGIN

 

SET NOCOUNT ON --added to prevent extra result sets from interfering with SELECT statements.

 

if @Param <>'RunningPOSubActivities'
begin
If ISNULL(@ProductionOrder,'')<>'' and ISNULL(@OperationNo,'')<>'' and ISNULL(@MaterialID,'')<>'' and isnull(@fabricationNo,'')<>''
Begin
Delete From MO Where Machineid=@Machineid
insert into MO(MachineID,PartID,OperationNo,MONumber,LinkNo)
Select @Machineid,@MaterialID,@OperationNo,@ProductionOrder,@fabricationNo
End
end

 

CREATE TABLE #ParkedScheduleDetails_GEA
(
Machineid nvarchar(50),
ProductionOrder nvarchar(50),
MaterialID nvarchar(50),
OperationNo nvarchar(50),
ScheduleQty float,
ScheduleStart datetime,
ScheduleEnd datetime,
ParkedBy nvarchar(50),
ParkedTS datetime,
ReasonForParking nvarchar(50),
Status nvarchar(50),
PendingQty float,
SchedulePriority int,
SelectedForRunning int,
UserPriority int,
FabricationNo nvarchar(50)
)

 

If @param=''
Begin
--TO Get ParkedSchedules into temp table
insert into #ParkedScheduleDetails_GEA(Machineid, ProductionOrder, MaterialID, OperationNo, ScheduleQty, ScheduleStart, ScheduleEnd, ParkedBy, ParkedTS, ReasonForParking, Status, PendingQty, SchedulePriority,SelectedForRunning,FabricationNo)
select T.Machineid, T.ProductionOrder, T.MaterialID, T.OperationNo, ScheduleQty, ScheduleStart, ScheduleEnd, ParkedBy, T.ParkedTS, ReasonForParking, Status, PendingQty, SchedulePriority,SelectedForRunning,T.FabricationNo
from ParkedScheduleDetails_GEA inner join
(Select Machineid,MaterialID,OperationNo,ProductionOrder,P.FabricationNo,Max(ParkedTS) as ParkedTS from ParkedScheduleDetails_GEA P
where P.SelectedForRunning=2 group by Machineid,MaterialID,OperationNo,ProductionOrder,P.FabricationNo)T on T.ParkedTS=ParkedScheduleDetails_GEA.ParkedTS

 


-- --ER0506 TO GET RUNNING SCHEDULE GRID 1
Select S.SchedulePriority,S.Machineid,S.ProductionOrder,S.MaterialID,S.OperationNo,
substring(C.description,charindex('[',C.description,1)+1,charindex('][',C.description)-2) as Model,
substring(C.description,charindex('[',C.description,2)+1,len(C.description)-charindex(']',C.description)-2) as ModelDescription,
case when @ScheduleStatus='Parked' then P.PendingQty else S.Scheduleqty end as ScheduleQty,ISNULL(T.StdSetupTime,0) as StdSetupTime,ISNULL(T.StdCycletime,0) as CycleTime,
S.ScheduleStart,S.ScheduleEnd,R.ActualStarttime,R.TentativeEndtime,R.CycleRuntime,S.UserPriority,S.FabricationNo
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
inner join MO on S.Machineid=MO.Machineid and S.MaterialID=MO.PartID and S.OperationNo=MO.OperationNo and S.ProductionOrder=MO.MONumber and S.FabricationNo=MO.LinkNo
Left outer join RunningScheduleDetails_GEA R on R.Machineid=MO.Machineid and R.MaterialID=MO.PartID and R.OperationNo=MO.OperationNo and R.ProductionOrder=MO.MONumber and R.FabricationNo=MO.LinkNo
Left outer join #ParkedScheduleDetails_GEA P on MO.Machineid=P.Machineid and MO.PartID=P.MaterialID and MO.OperationNo=P.OperationNo and MO.MONumber=P.ProductionOrder and MO.LinkNo=P.FabricationNo
Left outer join (Select R.Machineid,R.MaterialID,R.OperationNo,R.ProductionOrder,R.FabricationNo,SUM(AM.StdSetupTime) as StdSetupTime,SUM(AM.StdCycletime) as StdCycletime from AssemblyActivitySchedules_GEA AR
inner join RunningScheduleDetails_GEA R on R.Machineid=AR.machineid and R.MaterialID=AR.MaterialID and R.OperationNo=AR.operationno and R.ProductionOrder=AR.ProductionOrder
AND R.FabricationNo=AR.FabricationNo
inner join AssemblyActivityMaster_GEA AM on AR.Machineid=AM.Station and AR.activity=AM.Activity and AR.MaterialID=AM.Componentid
group by R.Machineid,R.MaterialID,R.OperationNo,R.ProductionOrder,R.FabricationNo)T
on R.Machineid=T.machineid and R.MaterialID=T.MaterialID and R.OperationNo=T.operationno and R.ProductionOrder=T.ProductionOrder AND R.FabricationNo=T.FabricationNo
Where MO.Machineid=@Machineid AND M.Process in('Assembly','Packing','Testing')
-- --ER0506 TO GET RUNNING SCHEDULE GRID 1

 

--TO GET TOP 6 NEW SCHEDULES GRID 2
Select TOP 6 S.SchedulePriority,S.Machineid,S.ProductionOrder,S.MaterialID,S.OperationNo,
substring(C.description,charindex('[',C.description,1)+1,charindex('][',C.description)-2) as Model,
substring(C.description,charindex('[',C.description,2)+1,len(C.description)-charindex(']',C.description)-2) as ModelDescription,
S.ScheduleQty,S.ScheduleStart,S.ScheduleEnd,S.Status,S.UserPriority,S.FabricationNo
From ScheduleDetails_GEA S
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
Where COP.Machineid=@Machineid and S.Status not in('Pending Inspection Completion','Completed','Parked')
and NOT EXISTS (Select Machineid,PartID,OperationNo,MONumber,LinkNo from MO Where S.Machineid=MO.Machineid and S.MaterialID=MO.PartID and S.OperationNo=MO.OperationNo
and S.ProductionOrder=MO.MONumber and S.FabricationNo=MO.LinkNo)
--and NOT EXISTS (Select Machineid,MaterialID,OperationNo,ProductionOrder from #ParkedScheduleDetails_GEA P Where S.Machineid=P.Machineid and S.MaterialID=P.MaterialID and S.OperationNo=P.OperationNo and S.ProductionOrder=P.ProductionOrder)
Order by S.SchedulePriority

 

--TO GET PARKED SCHEDULEs GRID 3

 

--TO Get ParkedSchedules into temp table
DELETE FROM #ParkedScheduleDetails_GEA

 

insert into #ParkedScheduleDetails_GEA(Machineid, ProductionOrder, MaterialID, OperationNo, ScheduleQty, ScheduleStart, ScheduleEnd, ParkedBy, ParkedTS, ReasonForParking, Status, PendingQty, SchedulePriority,SelectedForRunning,FabricationNo)
select T.Machineid, T.ProductionOrder, T.MaterialID, T.OperationNo, ScheduleQty, ScheduleStart, ScheduleEnd, ParkedBy, T.ParkedTS, ReasonForParking, Status, PendingQty, SchedulePriority,SelectedForRunning,T.FabricationNo
from ParkedScheduleDetails_GEA inner join
(Select Machineid,MaterialID,OperationNo,ProductionOrder,Max(ParkedTS) as ParkedTS,P.FabricationNo from ParkedScheduleDetails_GEA P
where P.SelectedForRunning=1 group by Machineid,MaterialID,OperationNo,ProductionOrder,P.FabricationNo)T on T.ParkedTS=ParkedScheduleDetails_GEA.ParkedTS

 

Select P.SchedulePriority,SD.UserPriority,P.Machineid,P.ProductionOrder,P.MaterialID,P.OperationNo,
substring(C.description,charindex('[',C.description,1)+1,charindex('][',C.description)-2) as Model,
substring(C.description,charindex('[',C.description,2)+1,len(C.description)-charindex(']',C.description)-2) as ModelDescription,P.ScheduleQty,
P.ScheduleStart,P.ScheduleEnd,emp.[Name],P.ParkedTS,P.ReasonForParking,P.PendingQty,P.FabricationNo
From #ParkedScheduleDetails_GEA P
inner join machineinformation M on P.Machineid=M.machineid
inner join ScheduleDetails_GEA SD on SD.ProductionOrder=P.ProductionOrder and SD.FabricationNo=P.FabricationNo and SD.Machineid=P.Machineid
inner join componentinformation C on C.componentid=P.MaterialID
inner join employeeinformation emp on p.ParkedBy = emp.Employeeid
inner join componentoperationpricing COP on P.Machineid=COP.machineid and P.MaterialID=COP.componentid and P.OperationNo=COP.operationno
Where COP.Machineid=@Machineid
and NOT EXISTS (Select Machineid,PartID,OperationNo,MONumber,LinkNo from MO
Where P.Machineid=MO.Machineid and P.MaterialID=MO.PartID and P.OperationNo=MO.OperationNo and P.ProductionOrder=MO.MONumber and P.FabricationNo=MO.LinkNo)
Order by P.SchedulePriority,P.ParkedTS
END

 

If @param='RunningPOSubActivities'
Begin

 

create table #activity
(
ProductionOrder nvarchar(50),
MaterialID nvarchar(50),
OperationNo nvarchar(50),
LastActivity nvarchar(50),
FabricationNo nvarchar(50),
Activity nvarchar(50),
Operator nvarchar(50),
ActivityTS datetime
)

 

Insert into #activity(MaterialID,OperationNo,ProductionOrder,FabricationNo,activity)
Select A.MaterialID,A.OperationNo,A.ProductionOrder,A.FabricationNo,A.Activity from AssemblyActivitySchedules_GEA A
where A.Machineid=@Machineid and A.MaterialID=@MaterialID and A.OperationNo=@OperationNo and A.ProductionOrder=@ProductionOrder and A.FabricationNo=@fabricationNo
order by A.Activity

 

If @ScheduleStatus='Parked'
Begin
Update #activity set LastActivity=T1.event,Operator=T1.Operator,ActivityTS=T1.eventTS from(
Select A1.Activity,A1.event,A1.Operator,T.eventTS from AssemblyActivityTransaction_GEA A1 inner join
(Select A.Activity,MAX(A.EventTS) as eventTS from AssemblyActivityTransaction_GEA A
where A.Machineid=@Machineid and A.MaterialID=@MaterialID and A.OperationNo=@OperationNo and A.ProductionOrder=@ProductionOrder and A.FabricationNo=@fabricationNo
group by A.Activity
)T on A1.Activity=T.Activity and A1.eventTS=T.eventTS)T1 inner join #activity on #activity.Activity=T1.Activity
End
Else
Begin
Update #activity set LastActivity=T1.event,Operator=T1.Operator,ActivityTS=T1.eventTS from(
Select A1.Activity,A1.event,A1.Operator,T.eventTS from AssemblyActivityTransaction_GEA A1 inner join
(Select A.Activity,MAX(A.EventTS) as eventTS from AssemblyActivityTransaction_GEA A
where A.Machineid=@Machineid and A.MaterialID=@MaterialID and A.OperationNo=@OperationNo and A.ProductionOrder=@ProductionOrder and A.FabricationNo=@fabricationNo
and A.CycleStart=@CycleStartTS
group by A.Activity
)T on A1.Activity=T.Activity and A1.eventTS=T.eventTS)T1 inner join #activity on #activity.Activity=T1.Activity
End

 

Select * from #activity order by Activity
END

 


END
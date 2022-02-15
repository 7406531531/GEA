/****** Object:  Procedure [dbo].[S_GetPOSchedule_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_GetPOSchedule_GEA] 'WFL M50 Mill Turn','','','',''
CREATE PROCEDURE [dbo].[S_GetPOSchedule_GEA] 
@Machineid NVARCHAR(50),
@ProductionOrder NVARCHAR(50)='',
@MaterialID NVARCHAR(50)='',
@OperationNo NVARCHAR(50)='',
@ScheduleStatus NVARCHAR(50)='',
@GrnNo NVARCHAR(50)=''
AS
BEGIN

SET NOCOUNT ON --added to prevent extra result sets from interfering with SELECT statements.


IF ISNULL(@ProductionOrder,'')<>'' AND ISNULL(@OperationNo,'')<>'' AND ISNULL(@MaterialID,'')<>''
BEGIN
	DELETE FROM MO WHERE Machineid=@Machineid

	INSERT INTO MO(MachineID,PartID,OperationNo,MONumber,GrnNo)
	SELECT @Machineid,@MaterialID,@OperationNo,@ProductionOrder,@GrnNo
END

CREATE TABLE #ParkedScheduleDetails_GEA
(
	Machineid NVARCHAR(50),
	ProductionOrder NVARCHAR(50),
	GrnNo NVARCHAR(50),
	MaterialID NVARCHAR(50),
	OperationNo NVARCHAR(50),
	ScheduleQty FLOAT,
	ScheduleStart DATETIME,
	ScheduleEnd DATETIME,
	ParkedBy NVARCHAR(50),
	ParkedTS DATETIME,
	ReasonForParking NVARCHAR(50),
	Status NVARCHAR(50),
	PendingQty FLOAT,
	SchedulePriority INT,
	SelectedForRunning INT,
	UserPriority INT

) 

--TO Get ParkedSchedules into temp table
INSERT INTO #ParkedScheduleDetails_GEA(Machineid, ProductionOrder,GrnNo, MaterialID, OperationNo, ScheduleQty, ScheduleStart, ScheduleEnd, ParkedBy, ParkedTS, ReasonForParking, Status, PendingQty, SchedulePriority,SelectedForRunning)
SELECT T.Machineid, T.ProductionOrder,t.GrnNo,T.MaterialID, T.OperationNo, ScheduleQty, ScheduleStart, ScheduleEnd, ParkedBy, T.ParkedTS, ReasonForParking, Status, PendingQty, SchedulePriority,SelectedForRunning
 FROM ParkedScheduleDetails_GEA INNER JOIN
(SELECT Machineid,MaterialID,OperationNo,ProductionOrder,ISNULL(GrnNo,'') AS GrnNo,MAX(ParkedTS) AS ParkedTS FROM ParkedScheduleDetails_GEA P
WHERE P.SelectedForRunning=2 GROUP BY Machineid,MaterialID,OperationNo,ProductionOrder,ISNULL(grnno,''))T ON T.ParkedTS=ParkedScheduleDetails_GEA.ParkedTS


--TO GET RUNNING SCHEDULE GRID 1
SELECT S.SchedulePriority,S.Machineid,S.ProductionOrder,S.MaterialID,S.OperationNo,s.GrnNo,
SUBSTRING(C.description,CHARINDEX('[',C.description,1)+1,CHARINDEX('][',C.description)-2) AS Model,
SUBSTRING(C.description,CHARINDEX('[',C.description,2)+1,LEN(C.description)-CHARINDEX(']',C.description)-2) AS ModelDescription,
--CASE WHEN @ScheduleStatus='Parked' THEN P.PendingQty ELSE S.Scheduleqty END AS ScheduleQty,COP.StdSetupTime,COP.cycletime,
CASE when @ScheduleStatus='Parked' then P.PendingQty else S.Scheduleqty end as ScheduleQty,COP.StdSetupTime,
CASE WHEN (@Machineid='Quality Incoming' AND @ScheduleStatus NOT IN ('Parked')) then COP.cycletime*s.ScheduleQty
WHEN (@Machineid='Quality Incoming' AND @ScheduleStatus='Parked') THEN COP.cycletime*p.PendingQty 
ELSE cop.cycletime END AS cycletime,
S.ScheduleStart,S.ScheduleEnd,R.ActualStarttime,R.TentativeEndtime,R.CycleRuntime,S.UserPriority
FROM ScheduleDetails_GEA S
INNER JOIN machineinformation M ON S.Machineid=M.machineid
INNER JOIN componentinformation C ON C.componentid=S.MaterialID
INNER JOIN componentoperationpricing COP ON S.Machineid=COP.machineid AND S.MaterialID=COP.componentid AND S.OperationNo=COP.operationno 
INNER JOIN MO ON S.Machineid=MO.Machineid and S.MaterialID=MO.PartID and S.OperationNo=MO.OperationNo and S.ProductionOrder=MO.MONumber AND ISNULL(s.GrnNo,'')=ISNULL(mo.GrnNo,'')
Left outer join RunningScheduleDetails_GEA R on R.Machineid=MO.Machineid and R.MaterialID=MO.PartID and R.OperationNo=MO.OperationNo and R.ProductionOrder=MO.MONumber AND ISNULL(r.GrnNo,'')=ISNULL(mo.GrnNo,'')
Left outer join #ParkedScheduleDetails_GEA P on MO.Machineid=P.Machineid and MO.PartID=P.MaterialID and MO.OperationNo=P.OperationNo and MO.MONumber=P.ProductionOrder AND ISNULL(mo.GrnNo,'')=ISNULL(p.GrnNo,'')
WHERE MO.Machineid=@Machineid 

--TO GET TOP 6 NEW SCHEDULES GRID 2
Select TOP 6 S.SchedulePriority,S.Machineid,S.ProductionOrder,S.MaterialID,S.OperationNo,s.GrnNo,
substring(C.description,charindex('[',C.description,1)+1,charindex('][',C.description)-2) as Model,
substring(C.description,charindex('[',C.description,2)+1,len(C.description)-charindex(']',C.description)-2) as ModelDescription,
S.ScheduleQty,S.ScheduleStart,S.ScheduleEnd,S.Status,S.UserPriority
From ScheduleDetails_GEA S 
inner join machineinformation M on S.Machineid=M.machineid
inner join componentinformation C on C.componentid=S.MaterialID
inner join componentoperationpricing COP on S.Machineid=COP.machineid and S.MaterialID=COP.componentid and S.OperationNo=COP.operationno
Where COP.Machineid=@Machineid and S.Status not in('Pending Inspection Completion','Completed','Parked')
and NOT EXISTS (Select Machineid,PartID,OperationNo,MONumber,ISNULL(GrnNo,'') from MO Where S.Machineid=MO.Machineid and S.MaterialID=MO.PartID and S.OperationNo=MO.OperationNo and S.ProductionOrder=MO.MONumber AND ISNULL(s.GrnNo,'')=ISNULL(mo.GrnNo,''))
--and NOT EXISTS (Select Machineid,MaterialID,OperationNo,ProductionOrder from #ParkedScheduleDetails_GEA P Where S.Machineid=P.Machineid and S.MaterialID=P.MaterialID and S.OperationNo=P.OperationNo and S.ProductionOrder=P.ProductionOrder)
Order by S.SchedulePriority

--TO GET PARKED SCHEDULEs GRID 3

--TO Get ParkedSchedules into temp table
DELETE FROM #ParkedScheduleDetails_GEA

insert into #ParkedScheduleDetails_GEA(Machineid, ProductionOrder, GrnNo,MaterialID, OperationNo, ScheduleQty, ScheduleStart, ScheduleEnd, ParkedBy, ParkedTS, ReasonForParking, Status, PendingQty, SchedulePriority,SelectedForRunning)
select T.Machineid, T.ProductionOrder,t.GrnNo,T.MaterialID, T.OperationNo, ScheduleQty, ScheduleStart, ScheduleEnd, ParkedBy, T.ParkedTS, ReasonForParking, Status, PendingQty, SchedulePriority,SelectedForRunning
 from ParkedScheduleDetails_GEA inner join
(Select Machineid,MaterialID,OperationNo,ProductionOrder,ISNULL(GrnNo,'') AS GrnNo, MAX(ParkedTS) as ParkedTS from ParkedScheduleDetails_GEA P
where P.SelectedForRunning=1 group by Machineid,MaterialID,OperationNo,ProductionOrder,ISNULL(GrnNo,''))T on T.ParkedTS=ParkedScheduleDetails_GEA.ParkedTS

Select P.SchedulePriority,SG.UserPriority,P.Machineid,P.ProductionOrder,P.MaterialID,P.OperationNo,p.GrnNo,
substring(C.description,charindex('[',C.description,1)+1,charindex('][',C.description)-2) as Model,
substring(C.description,charindex('[',C.description,2)+1,len(C.description)-charindex(']',C.description)-2) as ModelDescription,P.ScheduleQty,
P.ScheduleStart,P.ScheduleEnd,emp.[Name],P.ParkedTS,P.ReasonForParking,P.PendingQty
From #ParkedScheduleDetails_GEA P
inner join machineinformation M on P.Machineid=M.machineid
inner join ScheduleDetails_GEA SG on SG.ProductionOrder = P.ProductionOrder and SG.MaterialID=P.MaterialID and SG.OperationNo=P.OperationNo and SG.Machineid=p.Machineid AND ISNULL(sg.GrnNo,'')=ISNULL(p.GrnNo,'')
inner join componentinformation C on C.componentid=P.MaterialID
inner join employeeinformation emp on p.ParkedBy = emp.Employeeid
inner join componentoperationpricing COP on P.Machineid=COP.machineid and P.MaterialID=COP.componentid and P.OperationNo=COP.operationno
Where COP.Machineid=@Machineid 
and NOT EXISTS (Select Machineid,PartID,OperationNo,MONumber,GrnNo from MO Where P.Machineid=MO.Machineid and P.MaterialID=MO.PartID and P.OperationNo=MO.OperationNo and P.ProductionOrder=MO.MONumber
AND ISNULL(p.GrnNo,'')=ISNULL(mo.GrnNo,''))
Order by P.SchedulePriority,P.ParkedTS


END
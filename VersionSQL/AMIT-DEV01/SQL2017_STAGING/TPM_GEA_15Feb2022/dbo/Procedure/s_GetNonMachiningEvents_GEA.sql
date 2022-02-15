/****** Object:  Procedure [dbo].[s_GetNonMachiningEvents_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/********************************************************************************
NR0157 - SwathiKS
Created procedure to insert and Non-Machining Events into rawdata.
--[dbo].[s_GetNonMachiningEvents_GEA] 'CycleStart','CNC-01','COMP-01','1','PCT','PO1','234','2020-07-04 17:01:00','','',''
--[dbo].[s_GetNonMachiningEvents_GEA] 'DownStart','CNC-01','COMP-01','1','PCT','PO1','234','2020-07-04 17:10:00','','DT01','ICD'
--[dbo].[s_GetNonMachiningEvents_GEA] 'SendDown','CNC-01','COMP-01','1','PCT','PO1','234','','2020-07-04 17:15:00','DT01','ICD'
--[dbo].[s_GetNonMachiningEvents_GEA] 'CycleEND','Assembly','1111-2222-333','9001','PCT','P001','F001','2021-02-05 11:43:00.000','2021-02-05 12:43:00.000','','','1'
--[dbo].[s_GetNonMachiningEvents_GEA] 'SendDown','CNC-01','COMP-01','1','PCT','PO1','234','','2020-06-05 17:30:00','DT01','BCD'
--[dbo].[s_GetNonMachiningEvents_GEA] 'Spindleoff','WFL M80 Mill Turn','','','','','','2020-09-04 14:10:00','','',''
--exec s_GetNonMachiningEvents_GEA @mc=N'Balancing',@comp=N'8175-6517-400',@opn=N'70',@slno=N'567',@PONO=N'TEST-BAL',@opr=N'112',@sttime=N'2021-07-27 16:01:15',@ndtime=N'2021-07-27 16:01:28',@Dcode=N'',@event=N'CycleEnd',@Qty=N'1',@type=N''
exec s_GetNonMachiningEvents_GEA @mc=N'Balancing',@comp=N'8175-6517-460',@opn=N'70',@slno=NULL,@PONO=N'iuyiuy',@opr=N'112',@sttime=N'2021-07-27 16:42:34',@ndtime=N'2021-07-27 16:42:40',@Dcode=N'',@event=N'CycleEnd',@Qty=N'1',@type=N''
********************************************************************************/
CREATE PROCEDURE [dbo].[s_GetNonMachiningEvents_GEA]
@event NVARCHAR(50),
@mc NVARCHAR(50),
@comp NVARCHAR(50),
@opn NVARCHAR(50),
@opr NVARCHAR(50),
@PONO NVARCHAR(50),
@slno NVARCHAR(50), --For Balancing it is Priority For Assembly it is FabricationNo
@sttime DATETIME,
@ndtime DATETIME,
@Dcode NVARCHAR(50),
@type NVARCHAR(50),
@qty DECIMAL(18,3)='0',
@GrnNo NVARCHAR(50)=''

AS
BEGIN

SET NOCOUNT ON;

Declare @minterface as nvarchar(50),@ip as nvarchar(50)
Declare @compinterface as nvarchar(50)
Declare @opninterface as nvarchar(50),@oprinterface as nvarchar(50)

select @minterface=InterfaceID,@ip=IP from machineinformation where machineid=@mc
select @compinterface=InterfaceID from componentinformation where componentid=@comp
select @opninterface=InterfaceID from componentoperationpricing where machineid=@mc and componentid=@comp and operationno=@opn
select @oprinterface=interfaceid from employeeinformation where Employeeid=@opr
select @Dcode=interfaceid from downcodeinformation where downid=@Dcode

Declare @RunningMachine as nvarchar(50),@Runningcomponent as nvarchar(50),@RunningOpn as nvarchar(50),@RunningProcess as nvarchar(50) --FOR GEA

Declare @Localorexport nvarchar(50)
Declare @SaleOrder nvarchar(50)
Declare @ScrollWelded nvarchar(50)
Declare @RDDMachines nvarchar(50)
Declare @Customer nvarchar(50)  
Declare @Location nvarchar(50)

If @event='CycleStart'
Begin

--If Exists(Select * from NonMachiningEvents_GEA where Machineid=@mc)
--Begin
-- Delete From NonMachiningEvents_GEA Where Machineid=@mc
--END

--Insert into NonMachiningEvents_GEA(Machineid,LastEventType,CycleStartTS,LastEventTS)
--Select @mc,@event,@sttime,@sttime

update NonMachiningEvents_GEA set CycleStartTS=@sttime,LastEventType=@event,LastEventTS=@sttime where Machineid=@mc

Insert into RawData(DataType, IPAddress, Mc, Comp, Opn, Opr, Sttime, Status, WorkOrderNumber, SPLString3,SPLString4)
Select '11',@ip,@minterface,@compinterface,@opninterface,@oprinterface,@sttime,11,@PONO,@slno,@GrnNo

--For GEA
Select @RunningMachine=Machineid from machineinformation where InterfaceID=@minterface
select @RunningProcess=process from machineinformation where InterfaceID=@minterface
select @Runningcomponent=componentid from componentinformation where interfaceid=@compinterface
select @RunningOpn=operationno from componentoperationpricing where machineid=@RunningMachine and componentid=@Runningcomponent and InterfaceID=@opninterface

update ScheduleDetails_GEA set Status='Running' where Machineid=@RunningMachine and Materialid=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO 
and status in('New','Parked') and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')

INSERT INTO RunningScheduleDetails_GEA(Machineid, ProductionOrder, MaterialID, OperationNo,FabricationNo,GrnNo)
SELECT Machineid, ProductionOrder, MaterialID, OperationNo, FabricationNo,GrnNo FROM ScheduleDetails_GEA 
WHERE Machineid=@RunningMachine AND Materialid=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
AND Status='Running'
--For GEA

END

If @event='SpindleOn' ---Datatype 41
Begin

--update NonMachiningEvents_GEA set CycleStartTS=@sttime,LastEventType=@event,LastEventTS=@sttime where Machineid=@mc

Insert into RawData(DataType, IPAddress, Mc, Sttime, Status)
Select '41',@ip,@minterface,@sttime,0
End

If @event='SpindleOff' --Datatype 40
Begin

--update NonMachiningEvents_GEA set CycleStartTS=@sttime,LastEventType=@event,LastEventTS=@sttime where Machineid=@mc

Insert into RawData(DataType, IPAddress, Mc, Sttime, Status)
Select '40',@ip,@minterface,@sttime,0
End

If @event='DownStart'--'Pause'
Begin

update NonMachiningEvents_GEA set DownStartTS=@sttime,LastEventType=@event,LastEventTS=@sttime,DownReason=@Dcode where Machineid=@mc

INSERT INTO RawData(DataType, IPAddress, Mc, Comp, Opn, Opr, SPLSTRING2,Sttime, Status, WorkOrderNumber, SPLString3,SPLString4)
SELECT '22',@ip,@minterface,@compinterface,@opninterface,@oprinterface,@Dcode,@sttime,0,@PONO,@slno,@GrnNo
END

If @event='SendDown'
Begin

Select @sttime=case when @type='ICD' then PauseTS when @type='BCD' then LastEventTS END from NonMachiningEvents_GEA where Machineid=@mc

update NonMachiningEvents_GEA set DownEndTS=@ndtime,LastEventType=@event,LastEventTS=@ndtime,DownReason=@Dcode where Machineid=@mc

INSERT INTO RawData(DataType, IPAddress, Mc, Comp, Opn, Opr, SPLSTRING2,Sttime, ndtime,Status, WorkOrderNumber, SPLString3,SPLString4)
SELECT CASE WHEN @type='ICD' THEN '42' WHEN @type='BCD' THEN '2' END,@ip,@minterface,@compinterface,@opninterface,@oprinterface,@Dcode,@sttime,@ndtime,0,@PONO,@slno,@GrnNo
END

IF @event='CycleEnd'
BEGIN
update NonMachiningEvents_GEA set CycleEndTS=@ndtime,LastEventType=@event,LastEventTS=@ndtime where Machineid=@mc

Insert into RawData(DataType, IPAddress, Mc, Comp, Opn, Opr, SPLSTRING1,Sttime, ndtime,Status, WorkOrderNumber, SPLString3,SPLString4)
Select '1',@ip,@minterface,@compinterface,@opninterface,@oprinterface,@qty,@sttime,@ndtime,0,@PONO,@slno,@GrnNo

---For GEA
Select @RunningMachine=Machineid from machineinformation where InterfaceID=@minterface
select @Runningcomponent=componentid from componentinformation where interfaceid=@compinterface
select @RunningProcess=process from machineinformation where InterfaceID=@minterface
select @RunningOpn=operationno from componentoperationpricing where machineid=@RunningMachine and componentid=@Runningcomponent and InterfaceID=@opninterface

If Exists(select * from rawdata R
inner join machineinformation M on M.InterfaceID=R.mc
inner join componentinformation C on R.Comp=C.InterfaceID
inner join componentoperationpricing O on M.machineid=O.machineid and C.componentid=O.componentid and O.InterfaceID=R.Opn
where DataType=1 and M.InterfaceID=@minterface and C.InterfaceID=@compinterface and O.InterfaceID=@opninterface and R.WorkOrderNumber=@PONO and R.SPLString3=@slno AND ISNULL(R.SPLString4,'')=ISNULL(@GrnNo,'')
and sttime>=(select max(sttime) from rawdata where DataType=11 and mc= @minterface and comp=@compinterface and opn= @opninterface and WorkOrderNumber = @PONO
and SPLString3=@slno AND ISNULL(SPLString4,'')=ISNULL(@GrnNo,'')))
Begin


IF EXISTS(SELECT * FROM ParkedScheduleDetails_GEA P inner join(SELECT MAX(PARKEDTS) as ParkedTS FROM ParkedScheduleDetails_GEA
where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND isnull(GrnNo,'')=isnull(@GrnNo,''))T on T.ParkedTS=P.ParkedTS
where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') and P.SelectedForRunning=1)
BEGIN
	Delete From RunningScheduleDetails_GEA where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
END
ELSE
BEGIN
	IF EXISTS(SELECT * FROM ParkedScheduleDetails_GEA P INNER JOIN(SELECT MAX(PARKEDTS) AS ParkedTS FROM ParkedScheduleDetails_GEA
	WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))T ON T.ParkedTS=P.ParkedTS
	WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') AND P.SelectedForRunning=2)
	BEGIN

			If Exists(Select * from FinalInspectionTransaction_GEA F where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrderNo=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') )
			Begin
				update ScheduleDetails_GEA set Status='Completed' where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
				update ScheduleDetails_GEA set ActualStarttime=@sttime,ActualEndtime=@ndtime,TentativeEndtime=(Select TentativeEndtime from RunningScheduleDetails_GEA where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') ) 
				where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
				Delete From RunningScheduleDetails_GEA where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
				UPDATE ParkedScheduleDetails_GEA SET SelectedForRunning=3 WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
			END
			ELSE
			BEGIN
				IF @RunningProcess='Assembly' or @RunningProcess='Testing' or @RunningProcess='Packing' or @RunningProcess='Balancing'
				Begin
					update ScheduleDetails_GEA set Status='Completed' where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(grnno,'')=ISNULL(@grnno,'')
				End
				ELSE
				BEGIN
					--update ScheduleDetails_GEA set Status='Pending Inspection Completion' where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'')
					UPDATE ScheduleDetails_GEA SET Status='Completed' WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
				END
				update ScheduleDetails_GEA set ActualStarttime=@sttime,ActualEndtime=@ndtime,TentativeEndtime=(Select TentativeEndtime from RunningScheduleDetails_GEA where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) 
				where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
				Delete From RunningScheduleDetails_GEA where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
				UPDATE ParkedScheduleDetails_GEA SET SelectedForRunning=3 WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
			END
	END
	ELSE
	BEGIN

		IF EXISTS(SELECT * FROM FinalInspectionTransaction_GEA F WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrderNo=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))
		Begin

			update ScheduleDetails_GEA set Status='Completed' where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
			update ScheduleDetails_GEA set ActualStarttime=@sttime,ActualEndtime=@ndtime,TentativeEndtime=(Select TentativeEndtime from RunningScheduleDetails_GEA where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) 
			where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
			DELETE FROM RunningScheduleDetails_GEA WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
		END
		ELSE
		BEGIN
			IF @RunningProcess='Assembly' or @RunningProcess='Testing' or @RunningProcess='Packing' or @RunningProcess='Balancing'
			Begin
				update ScheduleDetails_GEA set Status='Completed' where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
			End
			ELSE
			BEGIN
				--update ScheduleDetails_GEA set Status='Pending Inspection Completion' where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'')
				UPDATE ScheduleDetails_GEA SET Status='Completed' WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
			END

			update ScheduleDetails_GEA set ActualStarttime=@sttime,ActualEndtime=@ndtime,TentativeEndtime=(Select TentativeEndtime from RunningScheduleDetails_GEA where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))
			where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
			DELETE FROM RunningScheduleDetails_GEA WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
		END
	END
END
END
Else
BEGIN

IF NOT EXISTS(SELECT * FROM FinalInspectionTransaction_GEA WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrderNo=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))
BEGIN

	IF @RunningProcess='Assembly' or @RunningProcess='Testing' or @RunningProcess='Packing' or @RunningProcess='Balancing'
	Begin
		update ScheduleDetails_GEA set Status='Completed' where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
		DELETE FROM RunningScheduleDetails_GEA WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') --added on 27/07/2021
	END
	ELSE
	BEGIN
		--update ScheduleDetails_GEA set Status='Pending Inspection Completion' where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'')
		update ScheduleDetails_GEA set Status='Completed' where MachineID=@RunningMachine and MaterialID=@Runningcomponent and OperationNo=@RunningOpn and ProductionOrder=@PONO and isnull(FabricationNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
		DELETE FROM RunningScheduleDetails_GEA WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') --added on 30/11/2021
	END
	UPDATE ScheduleDetails_GEA SET ActualStarttime=@sttime,ActualEndtime=@ndtime,TentativeEndtime=(SELECT TentativeEndtime FROM RunningScheduleDetails_GEA WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') )
	WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
END

END
---For GEA

Delete From MO where MachineID=@RunningMachine and PartID=@Runningcomponent and OperationNo=@RunningOpn and MONumber=@PONO and isnull(LinkNo,'')=isnull(@slno,'') AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')

IF @RunningProcess='Assembly'
BEGIN
	
	Declare @SchedulePriority as int,@UserPriority as int
	Select @SchedulePriority=ISNULL(Max(SchedulePriority),1),@UserPriority=ISNULL(MAX(UserPriority),1) from ScheduleDetails_GEA where Machineid='Testing'

	--IF EXISTS(SELECT * FROM ScheduleDetails_GEA WHERE Status='Completed' AND MachineID='Assembly' AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,''))
	IF EXISTS(SELECT * FROM ScheduleDetails_GEA WHERE Status='Completed' AND MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,''))

	BEGIN
		--SELECT @Localorexport=Localorexport, @SaleOrder=SaleOrder, @ScrollWelded=ScrollWelded, @RDDMachines=RDDMachines, @Customer=customer, @Location=Location FROM ScheduleDetails_GEA WHERE MachineID='Assembly' AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'')

		SELECT @Localorexport=Localorexport, @SaleOrder=SaleOrder, @ScrollWelded=ScrollWelded, @RDDMachines=RDDMachines, @Customer=customer, @Location=Location FROM ScheduleDetails_GEA WHERE MachineID=@RunningMachine AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'')


		INSERT INTO ScheduleDetails_GEA(Machineid, ProductionOrder, MaterialID, OperationNo, ScheduleQty, Status,SchedulePriority, UpdatedBy, UpdatedTS, UserPriority, 
		Localorexport, SaleOrder, ScrollWelded, RDDMachines, FabricationNo, Customer, Location)
		SELECT 'Testing', @PONO, @Runningcomponent, 9002, 1,'New',@SchedulePriority, 'Service', GETDATE(),@UserPriority, 
		@Localorexport, @SaleOrder, @ScrollWelded, @RDDMachines, @slno, @Customer, @Location

		INSERT INTO [dbo].[AssemblyActivitySchedules_GEA](
		[Machineid],[ProductionOrder],[FabricationNo],[MaterialID],[OperationNo],[Activity],[UpdatedBy],[UpdatedTS])
		SELECT DISTINCT S.Machineid,S.ProductionOrder,S.FabricationNo,S.MaterialID,S.OperationNo,A.Activity,'Service',GETDATE() FROM ScheduleDetails_GEA S
		CROSS JOIN [dbo].[AssemblyActivityMaster_GEA] A
		WHERE S.Machineid='Testing' AND A.Station=S.Machineid AND A.IsDefault=1
		AND NOT EXISTS(SELECT * FROM [dbo].[AssemblyActivitySchedules_GEA] A1 WHERE A1.Machineid=S.Machineid AND S.MaterialID=A1.MaterialID
		AND S.OperationNo=A1.OperationNo AND S.ProductionOrder=A1.ProductionOrder AND S.FabricationNo=A1.FabricationNo AND A.Activity=A1.Activity)

		INSERT INTO ScheduleCalculateMethod_GEA(Machineid, CalculatePlan, UpdatedBy, UpdatedTS, Status, ServiceUpdatedTS)
		SELECT 'Testing', 1, @opr, GETDATE(), 0, GETDATE()
	END
END

IF @RunningProcess='Testing'
BEGIN
	SELECT @SchedulePriority=ISNULL(MAX(SchedulePriority),1),@UserPriority=ISNULL(MAX(UserPriority),1) FROM ScheduleDetails_GEA WHERE Machineid='Packing'

	IF EXISTS(SELECT * FROM ScheduleDetails_GEA WHERE Status='Completed' AND MachineID='Testing' AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,''))
	BEGIN
		SELECT @Localorexport=Localorexport, @SaleOrder=SaleOrder, @ScrollWelded=ScrollWelded, @RDDMachines=RDDMachines, @Customer=customer, @Location=Location FROM ScheduleDetails_GEA WHERE MachineID='Testing' AND MaterialID=@Runningcomponent AND OperationNo=@RunningOpn AND ProductionOrder=@PONO AND ISNULL(FabricationNo,'')=ISNULL(@slno,'')

		INSERT INTO ScheduleDetails_GEA(Machineid, ProductionOrder, MaterialID, OperationNo, ScheduleQty, Status,SchedulePriority, UpdatedBy, UpdatedTS, UserPriority, 
		Localorexport, SaleOrder, ScrollWelded, RDDMachines, FabricationNo, Customer, Location)
		SELECT 'Packing', @PONO, @Runningcomponent, 9003, 1,'New',@SchedulePriority, 'Service', GETDATE(),@UserPriority, 
		@Localorexport, @SaleOrder, @ScrollWelded, @RDDMachines, @slno, @Customer, @Location
	
		INSERT INTO [dbo].[AssemblyActivitySchedules_GEA](
		[Machineid],[ProductionOrder],[FabricationNo],[MaterialID],[OperationNo],[Activity],[UpdatedBy],[UpdatedTS])
		SELECT DISTINCT S.Machineid,S.ProductionOrder,S.FabricationNo,S.MaterialID,S.OperationNo,A.Activity,'Service',GETDATE() FROM ScheduleDetails_GEA S
		CROSS JOIN [dbo].[AssemblyActivityMaster_GEA] A
		WHERE S.Machineid='Packing' AND A.Station=S.Machineid AND A.IsDefault=1
		AND NOT EXISTS(SELECT * FROM [dbo].[AssemblyActivitySchedules_GEA] A1 WHERE A1.Machineid=S.Machineid AND S.MaterialID=A1.MaterialID
		AND S.OperationNo=A1.OperationNo AND S.ProductionOrder=A1.ProductionOrder AND S.FabricationNo=A1.FabricationNo AND A.Activity=A1.Activity)

		INSERT INTO ScheduleCalculateMethod_GEA(Machineid, CalculatePlan, UpdatedBy, UpdatedTS, Status, ServiceUpdatedTS)
		SELECT 'Packing', 1, @opr, GETDATE(), 0, GETDATE()
	END
END

END

END
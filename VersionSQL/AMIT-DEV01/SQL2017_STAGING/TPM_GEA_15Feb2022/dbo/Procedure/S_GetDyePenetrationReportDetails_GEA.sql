/****** Object:  Procedure [dbo].[S_GetDyePenetrationReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[dbo].[S_GetDyePenetrationReportDetails_GEA] @PartNo=N'8175-6517-400',@ProductionOrderNo=N'PRODSEPTTEST0002',@Param=N'View',@MachineID=N'Quality In house'
[dbo].[S_GetDyePenetrationReportDetails_GEA] @PartNo=N'8175-6517-400',@ProductionOrderNo=N'876876',@Param=N'View',@MachineID=N''

*/
CREATE PROCEDURE [dbo].[S_GetDyePenetrationReportDetails_GEA]
@ID BIGINT=0,
@UnmachinedPartNo NVARCHAR(50)='',
@PartNo NVARCHAR(50)='',
@ProductID NVARCHAR(50)='',
@MaterialNo NVARCHAR(50)='',
@SerialNo NVARCHAR(50)='',
@ProductionOrderNo NVARCHAR(50)='',
@QBNo NVARCHAR(50)='',
@SheetNo NVARCHAR(50)='',
@Charge1 NVARCHAR(50)='',
@Charge2 NVARCHAR(50)='',
@Charge3 NVARCHAR(50)='',
@ConsecutiveNo NVARCHAR(50)='',
@SeqOfOperation NVARCHAR(50)='',
@Faultless NVARCHAR(50)='',
@FaultlessAfterRework NVARCHAR(50)='',
@Remarks NVARCHAR(500)='',
@NoOfExaminer NVARCHAR(50)='',
@NameOfExaminer NVARCHAR(50)='',
@Date DATETIME='',
@Confirmation INT=0,
@GrnNo NVARCHAR(50)='',
@Place NVARCHAR(50)='',
@MachineID NVARCHAR(50)='',
@Param NVARCHAR(50)=''

AS
BEGIN

IF @Param='View'
BEGIN
	SELECT SDG.*,SUBSTRING(C.description,CHARINDEX('[',C.description,2)+1,LEN(C.description)-CHARINDEX(']',C.description)-2) AS ModelDescription FROM ScheduleDetails_GEA SDG
	INNER JOIN componentinformation C ON C.componentid=SDG.MaterialID
	WHERE ProductionOrder=@ProductionOrderNo AND MaterialID=@PartNo
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	AND (Machineid=@MachineID ) AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

	----select * from DyePenetrationReportDetails_GEA
	--select A1.ID,isnull(A2.UnmachinedPartNo,A1.UnmachinedPartNo)as UnmachinedPartNo,A1.PartNo,A1.ProductID,isnull(A2.SerialNo,A1.SerialNo)as SerialNo,A1.ProductionOrderNo,
	--isnull(A2.MaterialNo,A1.MaterialNo) as MaterialNo,A1.QBNo,A1.SheetNo,A1.Charge1,A1.Charge2,A1.Charge3,A1.ConsecutiveNo,A1.SeqOfOperation,A1.Faultless,
	--A1.FaultlessAfterRework,A1.Remarks,A1.NoOfExaminer,A1.NameOfExaminer,A1.Date,A1.Place,A1.Confirmation,A1.MachineID 
	--into #Temp 
	--from DyePenetrationReportDetails_GEA A1
	--left join (select * from HardnessReportDetails_GEA where (PartNo=@PartNo or isnull(@PartNo,'')='')
	--and (ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')) A2 on A1.ProductionOrderNo=A2.ProductionOrderNo and A1.PartNo=A2.PartNo
	--where (A1.PartNo=@PartNo or isnull(@PartNo,'')='')
	--and (A1.ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
	--and (A1.MachineID=@MachineID )

	IF EXISTS(SELECT * FROM HardnessReportDetails_GEA WHERE (PartNo=@PartNo) AND (ProductionOrderNo=@ProductionOrderNo) AND (Machineid=@MachineID) AND (ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')))
	BEGIN
		SELECT A2.ID,ISNULL(A1.UnmachinedPartNo,A2.UnmachinedPartNo)AS UnmachinedPartNo,A2.PartNo,A2.ProductID,ISNULL(A1.SerialNo,A2.SerialNo)AS SerialNo,A2.ProductionOrderNo,ISNULL(A2.GrnNo,'') AS GrnNo,
		ISNULL(A1.MaterialNo,A2.MaterialNo) AS MaterialNo,A2.QBNo,A2.SheetNo,A2.Charge1,A2.Charge2,A2.Charge3,A2.ConsecutiveNo,A2.SeqOfOperation,A2.Faultless,
		A2.FaultlessAfterRework,A2.Remarks,A2.NoOfExaminer,A2.NameOfExaminer,A2.Date,A2.Place,A2.Confirmation,A2.MachineID 
		FROM HardnessReportDetails_GEA A1
		LEFT JOIN (SELECT * FROM DyePenetrationReportDetails_GEA WHERE (PartNo=@PartNo OR ISNULL(@PartNo,'')='')
		AND (ProductionOrderNo=@ProductionOrderNo OR ISNULL(@ProductionOrderNo,'')='')
		AND (Machineid=@MachineID) AND (ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) ) A2 ON A1.ProductionOrderNo=A2.ProductionOrderNo AND A1.PartNo=A2.PartNo AND ISNULL(A1.grnno,'')=ISNULL(A2.grnno,'')
		where (A1.PartNo=@PartNo or isnull(@PartNo,'')='')
		and (A1.ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
		and (A1.MachineID=@MachineID )
		AND ((ISNULL(A1.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')
		return
	END
	ELSE
	BEGIN
		select A1.ID,isnull(A2.UnmachinedPartNo,A1.UnmachinedPartNo)as UnmachinedPartNo,A1.PartNo,A1.ProductID,isnull(A2.SerialNo,A1.SerialNo)as SerialNo,A1.ProductionOrderNo,ISNULL(A1.GrnNo,'') AS GrnNo,
		isnull(A2.MaterialNo,A1.MaterialNo) as MaterialNo,A1.QBNo,A1.SheetNo,A1.Charge1,A1.Charge2,A1.Charge3,A1.ConsecutiveNo,A1.SeqOfOperation,A1.Faultless,
		A1.FaultlessAfterRework,A1.Remarks,A1.NoOfExaminer,A1.NameOfExaminer,A1.Date,A1.Place,A1.Confirmation,A1.MachineID 
		from DyePenetrationReportDetails_GEA A1
		left join (select * from HardnessReportDetails_GEA where (PartNo=@PartNo or isnull(@PartNo,'')='')
		and (ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
		and (Machineid=@MachineID) AND (ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))) A2 on A1.ProductionOrderNo=A2.ProductionOrderNo and A1.PartNo=A2.PartNo AND ISNULL(A1.grnno,'')=ISNULL(A2.grnno,'')
		where (A1.PartNo=@PartNo or isnull(@PartNo,'')='')
		and (A1.ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
		and (A1.MachineID=@MachineID )
		AND ((ISNULL(A1.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')
	END
	
	--select A1.ID,A1.UnmachinedPartNo as UnmachinedPartNo,A1.PartNo,A1.ProductID,A1.SerialNo as SerialNo,A1.ProductionOrderNo,
	--A1.MaterialNo as MaterialNo,A1.QBNo,A1.SheetNo,A1.Charge1,A1.Charge2,A1.Charge3,A1.ConsecutiveNo,A1.SeqOfOperation,A1.Faultless,
	--A1.FaultlessAfterRework,A1.Remarks,A1.NoOfExaminer,A1.NameOfExaminer,A1.Date,A1.Place,A1.Confirmation,A1.MachineID  
	--from #Temp A1 
	--left join employeeinformation A2 on A1.NameOfExaminer=A2.Employeeid
END

IF @Param='Save'
BEGIN
	IF NOT EXISTS(select * from DyePenetrationReportDetails_GEA where PartNo=@PartNo  and ProductionOrderNo=@ProductionOrderNo and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') and ID=@ID )
	BEGIN
		INSERT INTO DyePenetrationReportDetails_GEA(UnmachinedPartNo,PartNo,ProductID,MaterialNo,SerialNo,ProductionOrderNo,QBNo,SheetNo,Charge1,Charge2,Charge3,ConsecutiveNo,SeqOfOperation,Faultless,FaultlessAfterRework,
		Remarks,NoOfExaminer,NameOfExaminer,[Date],Place,Confirmation,MachineID,GrnNo)
		Values(@UnmachinedPartNo,@PartNo,@ProductID,@MaterialNo,@SerialNo,@ProductionOrderNo,@QBNo,@SheetNo,@Charge1,@Charge2,@Charge3,@ConsecutiveNo,@SeqOfOperation,@Faultless,@FaultlessAfterRework,
		@Remarks,@NoOfExaminer,@NameOfExaminer,@Date,@Place,@Confirmation,@MachineID,@GrnNo)
	END
	ELSE
	BEGIN
		Update DyePenetrationReportDetails_GEA
		SET UnmachinedPartNo=@UnmachinedPartNo, MaterialNo=@MaterialNo, SerialNo=@SerialNo, QBNo=@QBNo, SheetNo=@SheetNo, Charge1=@Charge1, Charge2=@Charge2, Charge3=@Charge3, SeqOfOperation=@SeqOfOperation, Faultless=@Faultless, FaultlessAfterRework=@FaultlessAfterRework, Remarks=@Remarks, NoOfExaminer=@NoOfExaminer, NameOfExaminer=@NameOfExaminer, [Date]=@Date , Place=@Place ,Confirmation=@Confirmation
		where PartNo=@PartNo  and ProductionOrderNo=@ProductionOrderNo AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') and MachineID=@MachineID and ID=@ID
	END
END
END
/****** Object:  Procedure [dbo].[S_GetHardnessReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE Procedure [dbo].[S_GetHardnessReportDetails_GEA]
@ID bigint=0,
@UnmachinedPartNo nvarchar(50)='',
@PartNo nvarchar(50)='',
@ProductID nvarchar(50)='',
@MaterialNo nvarchar(50)='',
@SerialNo nvarchar(50)='',
@ProductionOrderNo nvarchar(50)='',
@QBNo nvarchar(50)='',
@SheetNo nvarchar(20)='',
@TestLoad nvarchar(50)='',
@DiaOfBall nvarchar(50)='',
@ConversionFactor nvarchar(50)='',
@TensileStrengt nvarchar(50)='',
@Charge nvarchar(50)='',
@ConsecutiveNo nvarchar(50)='',
@LotNo nvarchar(50)='',
@HardnessNo_0D nvarchar(50)='',
@HardnessNo_90D nvarchar(50)='',
@HardnessNo_180D nvarchar(50)='',
@HardnessNo_270D nvarchar(50)='',
@Remarks nvarchar(500)='',
@NameOfExaminer nvarchar(50)='',
@Date datetime='',
@Place nvarchar(50)='',
@Confirmation int=0,
@GrnNo NVARCHAR(50)='',
@MachineID nvarchar(50)='',

@Param nvarchar(50)=''

AS
BEGIN

IF @Param='View'
BEGIN
	select SDG.*,substring(C.description,charindex('[',C.description,2)+1,len(C.description)-charindex(']',C.description)-2) as ModelDescription from ScheduleDetails_GEA SDG
	inner join componentinformation C on C.componentid=SDG.MaterialID
	where ProductionOrder=@ProductionOrderNo and MaterialID=@PartNo
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	and Machineid=@MachineID AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

	--Select distinct UnmachinedPartNo,PartNo,ProductID,MaterialNo,SerialNo,ProductionOrderNo,QBNo,SheetNo,TestLoad,DiaOfBall,ConversionFactor,TensileStrengt,NameOfExaminer,[Date],Place,Confirmation from HardnessReportDetails_GEA
	--where (PartNo=@PartNo or isnull(@PartNo,'')='')
	----and (ProductID=@ProductID or isnull(@ProductID,'')='')
	--and (ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')

	--Select distinct ID,Charge,ConsecutiveNo,LotNo,HardnessNo_0D,HardnessNo_90D,HardnessNo_180D,HardnessNo_270D,Remarks,NameOfExaminer,[Date],Place,Confirmation from HardnessReportDetails_GEA
	--where (PartNo=@PartNo or isnull(@PartNo,'')='')
	----and (ProductID=@ProductID or isnull(@ProductID,'')='')
	--and (ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')

	Select A1.ID,A1.UnmachinedPartNo,A1.PartNo,A1.ProductID,A1.MaterialNo,A1.SerialNo,A1.ProductionOrderNo,ISNULL(A1.GrnNo,'') AS GrnNo,A1.QBNo,A1.SheetNo,A1.TestLoad,A1.DiaOfBall,A1.ConversionFactor,A1.TensileStrengt,A1.Charge,A1.ConsecutiveNo,A1.LotNo,
	A1.HardnessNo_0D,A1.HardnessNo_90D,A1.HardnessNo_180D,A1.HardnessNo_270D,A1.Remarks,A2.Name as NameOfExaminer,A1.Date,A1.Place,A1.Confirmation,A1.MachineID from HardnessReportDetails_GEA A1
	left join employeeinformation A2 on A1.NameOfExaminer=A2.Employeeid
	where (PartNo=@PartNo or isnull(@PartNo,'')='')
	and (ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	and Machineid=@MachineID AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

END

IF @Param='Save'
BEGIN
	IF NOT EXISTS(select * from HardnessReportDetails_GEA where PartNo=@PartNo and ProductionOrderNo=@ProductionOrderNo and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') and ID=@ID)
	BEGIN
		INSERT INTO HardnessReportDetails_GEA(UnmachinedPartNo,PartNo,ProductID,MaterialNo,SerialNo,ProductionOrderNo,QBNo,SheetNo,TestLoad,DiaOfBall,ConversionFactor,TensileStrengt,Charge,ConsecutiveNo,LotNo,HardnessNo_0D,
		HardnessNo_90D,HardnessNo_180D,HardnessNo_270D,Remarks,NameOfExaminer,[Date],Place,Confirmation,MachineID,GrnNo)
		values(@UnmachinedPartNo,@PartNo,@ProductID,@MaterialNo,@SerialNo,@ProductionOrderNo,@QBNo,@SheetNo,@TestLoad,@DiaOfBall,@ConversionFactor,@TensileStrengt,@Charge,@ConsecutiveNo,@LotNo,@HardnessNo_0D,
		@HardnessNo_90D,@HardnessNo_180D,@HardnessNo_270D,@Remarks,@NameOfExaminer,@Date,@Place,@Confirmation,@MachineID,@GrnNo)
	END
	ELSE
	BEGIN
		Update HardnessReportDetails_GEA
		SET UnmachinedPartNo=@UnmachinedPartNo, MaterialNo=@MaterialNo, SerialNo=@SerialNo, QBNo=@QBNo, SheetNo=@SheetNo, TestLoad=@TestLoad, DiaOfBall=@DiaOfBall, ConversionFactor=@ConversionFactor, TensileStrengt=@TensileStrengt, ConsecutiveNo=@ConsecutiveNo, LotNo=@LotNo, HardnessNo_0D=@HardnessNo_0D, HardnessNo_90D=@HardnessNo_90D, HardnessNo_180D=@HardnessNo_180D, HardnessNo_270D=@HardnessNo_270D, Remarks=@Remarks, NameOfExaminer=@NameOfExaminer, [Date]=@Date, Place=@Place , Confirmation=@Confirmation
		where PartNo=@PartNo and ProductionOrderNo=@ProductionOrderNo and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') and ID=@ID
	END
END

END
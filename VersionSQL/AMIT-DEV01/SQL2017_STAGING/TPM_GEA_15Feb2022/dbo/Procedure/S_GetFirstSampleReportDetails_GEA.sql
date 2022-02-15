/****** Object:  Procedure [dbo].[S_GetFirstSampleReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[S_GetFirstSampleReportDetails_GEA]
@ID bigint=0,
@PartNo   nvarchar (50) ='',
@ProductionOrderNo   nvarchar (50) ='',
@Inspection1  bit=0,
@Inspection2  bit=0,
@Inspection3  bit=0,
@InspectionDate   datetime  ='',
@Reason_NewSupplier  bit=0,
@Reason_NewPart  bit=0,
@Reason_AmendedSpecific  bit=0,
@Reason_Amended  bit=0,
@Reason_Other  bit=0,
@Reason_RepetativeInspection  bit=0,
@Supplier   nvarchar (50) ='',
@Material nvarchar(50)='',
@NoOfSamples nvarchar(50)='',
@DocumentType1  bit =0,
@DocumentType2  bit=0,
@DocumentType3  bit=0,
@InputStockUsed1   bit=0,
@InputStockUsed2  bit=0,
@InputStockUsed3  nvarchar(50)='',
@InspectionCarriedBit   bit=0,
@Comment   nvarchar (300) ='',
@Date   datetime  ='',
@Signature nvarchar(50)='',
@Material_MechanicalTest bit=0,
@Material_AnalysisCheck bit=0,
@Material_Structure bit=0,
@Material_Other bit=0,
@GEAComments nvarchar(250)='',
@Dimension_Check bit=0,
@Dimension_Check1 bit=0,
@Dimension_Check2 bit=0,
@Dimension_Check3 bit=0,
@GEAReasonForRejection nvarchar(200)='',
@RejDate datetime='',
@RejSignature nvarchar(50)='',
@RevNo   nvarchar (50) ='',
@RevDate   datetime  ='',
@Confirmation   int  =0,

@MeasuringComment nvarchar(250)='',
@MeasuringCommentBit bit=0,
@MeasuringCommentDate datetime='',
@MeasuringCommentSignature nvarchar(50)='',

@IAWStandard nvarchar(50)='',
@SetValue nvarchar(50)='',
@AsIsValueSupplier nvarchar(50)='',
@Ok nvarchar(50)='',
@NOk nvarchar(50)='',
@AsIsValueGEA nvarchar(50)='',
@AssessmentOfDeviation nvarchar(50)='',

@MachineID nvarchar(50)='',
@Param nvarchar(50)='',
@GrnNo NVARCHAR(50)=''

AS
BEGIN

IF @Param='View'
BEGIN
select SDG.*,substring(C.description,charindex('[',C.description,2)+1,len(C.description)-charindex(']',C.description)-2) as ModelDescription from ScheduleDetails_GEA SDG
	inner join componentinformation C on C.componentid=SDG.MaterialID
	where ProductionOrder=@ProductionOrderNo and MaterialID=@PartNo
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	and Machineid=@MachineID AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

	select * into #Temp from FirstSampleReportDetails_GEA
	where (PartNo=@PartNo or isnull(@PartNo,'')='')
	and (ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	and Machineid=@MachineID AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

	Update #Temp Set [Signature]=T1.Name
	From(
	select distinct A1.[Signature],A2.Name from #Temp A1
	left join employeeinformation A2 on A1.[Signature]=A2.Employeeid
	)T1 inner join #Temp T2 on T1.[Signature]=T2.[Signature]

	Update #Temp Set RejSignature=T1.Name
	From(
	select distinct A1.RejSignature,A2.Name from #Temp A1
	left join employeeinformation A2 on A1.RejSignature=A2.Employeeid
	)T1 inner join #Temp T2 on T1.RejSignature=T2.RejSignature

	Update #Temp Set MeasuringCommentSignature=T1.Name
	From(
	select distinct A1.MeasuringCommentSignature,A2.Name from #Temp A1
	left join employeeinformation A2 on A1.MeasuringCommentSignature=A2.Employeeid
	)T1 inner join #Temp T2 on T1.MeasuringCommentSignature=T2.MeasuringCommentSignature

	select * from #Temp

	select A1.ID,A1.PartNo,A1.ProductionOrderNo,A1.Supplier,A1.IAWStandard,A1.SetValue,A1.AsIsValueSupplier,A1.Ok,A1.NOk,A1.AsIsValueGEA,A1.AssessmentOfDeviation,A1.Comment,A1.Date,A2.Name as Signature,A1.RevNo,A1.RevDate,A1.Confirmation,A1.MachineID,ISNULL(A1.GrnNo,'') AS GrnNo
	from FirstSampleMeasuringReportDetails_GEA A1
	left join employeeinformation A2 on A1.Signature=A2.Employeeid
	where (A1.PartNo=@PartNo or isnull(@PartNo,'')='')
	and (A1.ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
	--and (A1.Machineid=@MachineID and isnull(@MachineID,'')='')
	and A1.Machineid=@MachineID AND ((ISNULL(a1.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

	select A1.ID,A1.PartNo,A1.ProductionOrderNo,A1.Supplier,A1.IAWStandard,A1.SetValue,A1.AsIsValueSupplier,A1.Ok,A1.NOk,A1.AsIsValueGEA,A1.AssessmentOfDeviation,A1.Comment,A1.Date,A2.Name as Signature,A1.RevNo,A1.RevDate,A1.Confirmation,A1.MachineID,ISNULL(A1.GrnNo,'') AS GrnNo
	from FirstSampleMeasuringReportDetails1_GEA A1
	left join employeeinformation A2 on A1.Signature=A2.Employeeid
	where (A1.PartNo=@PartNo or isnull(@PartNo,'')='')
	and (A1.ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
	--and (A1.Machineid=@MachineID and isnull(@MachineID,'')='')
	and A1.Machineid=@MachineID AND ((ISNULL(a1.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

END

IF @Param='Save'
BEGIN
	IF NOT EXISTS(select * from FirstSampleReportDetails_GEA where PartNo=@PartNo and  ProductionOrderNo=@ProductionOrderNo and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))
	BEGIN
		INSERT INTO FirstSampleReportDetails_GEA(PartNo,ProductionOrderNo, Inspection1, Inspection2, Inspection3, InspectionDate, Reason_NewSupplier, Reason_NewPart, Reason_AmendedSpecific, Reason_Amended, Reason_Other, Reason_RepetativeInspection,
		 Supplier,Material,NoOfSamples, DocumentType1, DocumentType2,DocumentType3, InputStockUsed1, InputStockUsed2, InputStockUsed3, InspectionCarriedBit, Comment, [Date], [Signature], Material_MechanicalTest, Material_AnalysisCheck,Material_Structure, Material_Other, GEAComments,
		 Dimension_Check, Dimension_Check1, Dimension_Check2, Dimension_Check3, GEAReasonForRejection, RejDate, RejSignature, RevNo, RevDate, Confirmation,MeasuringComment,MeasuringCommentBit,MeasuringCommentDate,MeasuringCommentSignature,
		 IAWStandard,MachineID,GrnNo)
		Values(@PartNo,@ProductionOrderNo,@Inspection1,@Inspection2,@Inspection3,@InspectionDate,@Reason_NewSupplier,@Reason_NewPart,@Reason_AmendedSpecific,@Reason_Amended,@Reason_Other,@Reason_RepetativeInspection,
		@Supplier,@Material,@NoOfSamples,@DocumentType1,@DocumentType2,@DocumentType3,@InputStockUsed1,@InputStockUsed2,@InputStockUsed3,@InspectionCarriedBit,@Comment,@Date,@Signature,@Material_MechanicalTest,@Material_AnalysisCheck,@Material_Structure,@Material_Other,@GEAComments,
		@Dimension_Check,@Dimension_Check1,@Dimension_Check2,@Dimension_Check3,@GEAReasonForRejection,@RejDate,@RejSignature,@RevNo,@RevDate,@Confirmation,@MeasuringComment,@MeasuringCommentBit,@MeasuringCommentDate,@MeasuringCommentSignature,
		@IAWStandard,@MachineID,@GrnNo)
	END
	ELSE
	BEGIN
		Update FirstSampleReportDetails_GEA
		SET Inspection1=@Inspection1, Inspection2=@Inspection2,Inspection3=@Inspection3,InspectionDate=@InspectionDate,Reason_NewSupplier=@Reason_NewSupplier,Reason_NewPart=@Reason_NewPart,
		Reason_AmendedSpecific=@Reason_AmendedSpecific,Reason_Amended=@Reason_Amended,Reason_Other=@Reason_Other,Reason_RepetativeInspection=@Reason_RepetativeInspection,
		Supplier=@Supplier,Material=@Material,NoOfSamples=@NoOfSamples,DocumentType1=@DocumentType1,DocumentType2=@DocumentType2,DocumentType3=@DocumentType3,InputStockUsed1=@InputStockUsed1,InputStockUsed2=@InputStockUsed2,InputStockUsed3=@InputStockUsed3,
		InspectionCarriedBit=@InspectionCarriedBit,Comment=@Comment,[Date]=@Date,[Signature]=@Signature,Material_MechanicalTest=@Material_MechanicalTest,Material_AnalysisCheck=@Material_AnalysisCheck,Material_Structure=@Material_Structure,Material_Other=@Material_Other,GEAComments=@GEAComments,
		Dimension_Check=@Dimension_Check,Dimension_Check1=@Dimension_Check1,Dimension_Check2=@Dimension_Check2,Dimension_Check3=@Dimension_Check3,GEAReasonForRejection=@GEAReasonForRejection,RejDate=@RejDate,RejSignature=@RejSignature,RevNo=@RevNo,RevDate=@RevDate,Confirmation=@Confirmation,
		MeasuringComment=@MeasuringComment, MeasuringCommentBit=@MeasuringCommentBit, MeasuringCommentDate=@MeasuringCommentDate, MeasuringCommentSignature=@MeasuringCommentSignature,IAWStandard=@IAWStandard
		where  PartNo=@PartNo and  ProductionOrderNo=@ProductionOrderNo and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
	END
END

IF @Param='SaveMeasuringDetails'
BEGIN
	IF NOT EXISTS(select * from FirstSampleMeasuringReportDetails_GEA where PartNo=@PartNo and  ProductionOrderNo=@ProductionOrderNo and Supplier=@Supplier and MachineID=@MachineID and ID=@ID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))
	BEGIN
		INSERT INTO FirstSampleMeasuringReportDetails_GEA(PartNo,ProductionOrderNo,Supplier,IAWStandard,SetValue,AsIsValueSupplier,Ok,NOk,AsIsValueGEA,AssessmentOfDeviation,Comment,[Date],[Signature],RevNo,RevDate,Confirmation,MachineID,GrnNo)
		values(@PartNo,@ProductionOrderNo,@Supplier,@IAWStandard,@SetValue,@AsIsValueSupplier,@Ok,@NOk,@AsIsValueGEA,@AssessmentOfDeviation,@MeasuringComment,@MeasuringCommentDate,@MeasuringCommentSignature,@RevNo,@RevDate,@Confirmation,@MachineID,@GrnNo)
	END
	ELSE
	BEGIN
		Update FirstSampleMeasuringReportDetails_GEA
		SET IAWStandard=@IAWStandard, SetValue=@SetValue, AsIsValueSupplier=@AsIsValueSupplier, Ok=@ok, NOk=@NOk, AsIsValueGEA=@AsIsValueGEA, AssessmentOfDeviation=@AssessmentOfDeviation,
		Comment=@MeasuringComment, [Date]=@MeasuringCommentDate, [Signature]=@MeasuringCommentSignature, RevNo=@RevNo, RevDate=@RevDate, Confirmation=@Confirmation
		where PartNo=@PartNo and  ProductionOrderNo=@ProductionOrderNo and Supplier=@Supplier and ID=@ID and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
	END
END

IF @Param='SaveMeasuringDetails1'
BEGIN
	IF NOT EXISTS(select * from FirstSampleMeasuringReportDetails1_GEA where PartNo=@PartNo and  ProductionOrderNo=@ProductionOrderNo and Supplier=@Supplier and ID=@ID and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))
	BEGIN
		INSERT INTO FirstSampleMeasuringReportDetails1_GEA(PartNo,ProductionOrderNo,Supplier,IAWStandard,SetValue,AsIsValueSupplier,Ok,NOk,AsIsValueGEA,AssessmentOfDeviation,Comment,[Date],[Signature],RevNo,RevDate,Confirmation,MachineID)
		values(@PartNo,@ProductionOrderNo,@Supplier,@IAWStandard,@SetValue,@AsIsValueSupplier,@Ok,@NOk,@AsIsValueGEA,@AssessmentOfDeviation,@MeasuringComment,@MeasuringCommentDate,@MeasuringCommentSignature,@RevNo,@RevDate,@Confirmation,@MachineID)
	END
	ELSE
	BEGIN
		Update FirstSampleMeasuringReportDetails1_GEA
		SET IAWStandard=@IAWStandard, SetValue=@SetValue, AsIsValueSupplier=@AsIsValueSupplier, Ok=@ok, NOk=@NOk, AsIsValueGEA=@AsIsValueGEA, AssessmentOfDeviation=@AssessmentOfDeviation,
		Comment=@MeasuringComment, [Date]=@MeasuringCommentDate, [Signature]=@MeasuringCommentSignature, RevNo=@RevNo, RevDate=@RevDate, Confirmation=@Confirmation
		where PartNo=@PartNo and  ProductionOrderNo=@ProductionOrderNo and Supplier=@Supplier and ID=@ID and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
	END
END


END
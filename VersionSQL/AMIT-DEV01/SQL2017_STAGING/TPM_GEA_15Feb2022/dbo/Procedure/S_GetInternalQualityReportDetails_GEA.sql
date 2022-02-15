/****** Object:  Procedure [dbo].[S_GetInternalQualityReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
S_GetInternalQualityReportDetails_GEA 'pr5','pa5','part5','','desss5','r5','d5','mAT5','b5','bo5','Vish5','vish5','good5','Vish5','2022-01-02 00:00:00','yes','yes','1','m5','VIEW'
S_GetInternalQualityReportDetails_GEA 'pr6','pa6','part6','','desssssss6','r6','d6','mAT6','b6','bo6','Vish6','vish6','good6','Vish6','2021-12-23 00:00:00','yes','yes','1','m6','Save'
*/

CREATE procedure [dbo].[S_GetInternalQualityReportDetails_GEA]
@ProductionOrderNo nvarchar(50)='',
@PartNo nvarchar(50)='',
@PartDescription nvarchar(100)='',
@NrNo nvarchar(50)='',
@IssueDescription nvarchar(200)='',
@RawMaterialPartNo nvarchar(50)='',
@DrawingNo nvarchar(50)='',
@Material nvarchar(50)='',
@BatchNo nvarchar(50)='',
@BowlSeries nvarchar(50)='',
@LoginName nvarchar(50)='',
@CarriedOutBy nvarchar(50)='',
@Reason nvarchar(50)='',
@IssuedBy nvarchar(50)='', 
@Date datetime='',
@QASignature nvarchar(50)='',
@HeadOfProdSignature nvarchar(50)='',
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


	select * into #Temp from InternalQualityReportDetails_GEA 
	where (PartNo=@PartNo or isnull(@PartNo,'')='')
	and (ProductionOrderNo=@ProductionOrderNo or isnull(@ProductionOrderNo,'')='')
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	and Machineid=@MachineID and ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

	Update #Temp set LoginName=T1.Name
	From(
	select distinct A1.LoginName,A2.Name from #Temp A1
	left join employeeinformation A2 on A1.LoginName=A2.Employeeid
	)T1 inner join #Temp T2 on T1.LoginName=T2.LoginName

	Update #Temp set IssuedBy=T1.Name
	From(
	select distinct A1.IssuedBy,A2.Name from #Temp A1
	left join employeeinformation A2 on A1.IssuedBy=A2.Employeeid
	)T1 inner join #Temp T2 on T1.IssuedBy=T2.IssuedBy

	Update #Temp set QASignature=T1.Name
	From(
	select distinct A1.QASignature,A2.Name from #Temp A1
	left join employeeinformation A2 on A1.QASignature=A2.Employeeid
	)T1 inner join #Temp T2 on T1.QASignature=T2.QASignature

	Update #Temp set HeadOfProdSignature=T1.Name
	From(
	select distinct A1.HeadOfProdSignature,A2.Name from #Temp A1
	left join employeeinformation A2 on A1.HeadOfProdSignature=A2.Employeeid
	)T1 inner join #Temp T2 on T1.HeadOfProdSignature=T2.HeadOfProdSignature

	select * from #Temp

END



IF @Param='Save'
BEGIN
if @NrNo=''
begin
declare @NrNumber int
select @NrNumber=(select isnull(max(cast(NrNo as int)),322987) from InternalQualityReportDetails_GEA where datepart(year,date)=datepart(year,@Date) AND (Date > '2022-01-01 06:00:00.00') )
select @NrNumber=@NrNumber+1
end

	IF NOT EXISTS(select * from InternalQualityReportDetails_GEA where PartNo=@PartNo  and ProductionOrderNo=@ProductionOrderNo and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))
	BEGIN
		INSERT INTO InternalQualityReportDetails_GEA(ProductionOrderNo,PartNo,PartDescription,NrNo,IssueDescription,RawMaterialPartNo,DrawingNo,Material,BatchNo,BowlSeries,LoginName,CarriedOutBy,Reason,IssuedBy,[Date],QASignature,
		HeadOfProdSignature,Confirmation,MachineID,GrnNo)
		Values(@ProductionOrderNo,@PartNo,@PartDescription,@NrNumber,@IssueDescription,@RawMaterialPartNo,@DrawingNo,@Material,@BatchNo,@BowlSeries,@LoginName,@CarriedOutBy,@Reason,@IssuedBy,@Date,@QASignature,
		@HeadOfProdSignature,@Confirmation,@MachineID,@GrnNo)
		print 'inserted Successfully'
	END
	ELSE
	BEGIN
		Update InternalQualityReportDetails_GEA
		SET IssueDescription=@IssueDescription, RawMaterialPartNo=@RawMaterialPartNo, DrawingNo=@DrawingNo, Material=@Material, BatchNo=@BatchNo, BowlSeries=@BowlSeries, LoginName=@LoginName, CarriedOutBy=@CarriedOutBy, Reason=@Reason, IssuedBy=@IssuedBy, [Date]=@Date, QASignature=@QASignature ,HeadOfProdSignature=@HeadOfProdSignature, Confirmation=@Confirmation
		where PartNo=@PartNo  and ProductionOrderNo=@ProductionOrderNo and MachineID=@MachineID and NrNo=@NrNo AND GrnNo=@GrnNo
		print 'Updated Successfully'
	END
END
END
/****** Object:  Procedure [dbo].[S_ValidateInspection_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_ValidateInspection_GEA] 'View','26220001','1010','PO1','1234','Operator','Plan001'

CREATE  PROCEDURE [dbo].[S_ValidateInspection_GEA]
@Param nvarchar(50)='',
@PartID nvarchar(50),
@OpnNo nvarchar(50),
@PONo nvarchar(50),
@SlNo nvarchar(50),
@InspectedBy nvarchar(50),
@PlanAndRevNo nvarchar(50)
WITH RECOMPILE
AS
BEGIN

SET NOCOUNT ON;

Declare @ApplyToOpr as int
Declare @ApplyToQA as int
Declare @IsmandatoryForOperator as int
Declare @IsmandatoryForQA as int
Declare @count as int

create table #Characteristic
(
CharacteristicID nvarchar(50),
datatype nvarchar(50)
)



Select @ApplyToOpr=Count(AppliesToOpr) from SPC_Characteristic where ComponentID=@PartID and OperationNo=@OpnNo and AppliesToOpr='True' and PlanNoAndRevNo=@PlanAndRevNo

Select @ApplyToQA=Count(AppliesToQuality) from SPC_Characteristic where ComponentID=@PartID and OperationNo=@OpnNo and AppliesToQuality='True' and PlanNoAndRevNo=@PlanAndRevNo

Select @IsmandatoryForOperator=Count(IsMandatoryForOpr) from SPC_Characteristic where ComponentID=@PartID and OperationNo=@OpnNo and AppliesToOpr='True' and IsMandatoryForOpr='True' and PlanNoAndRevNo=@PlanAndRevNo

Select @IsmandatoryForQA=Count(IsMandatoryForQuality) from SPC_Characteristic where ComponentID=@PartID and OperationNo=@OpnNo and AppliesToQuality='True' and IsMandatoryForQuality='True' and PlanNoAndRevNo=@PlanAndRevNo

If @InspectedBy='Operator'
begin

	insert into #Characteristic(CharacteristicID,datatype)
	select CharacteristicID,dbo.udf_GetNumeric(datatype) from SPC_Characteristic where ComponentID=@PartID and OperationNo=@OpnNo and AppliesToOpr='True' and IsMandatoryForOpr='True' and PlanNoAndRevNo=@PlanAndRevNo

	update #Characteristic set datatype=1 where datatype='' or datatype is null

	select @Count=ISNULL(count(*),0) from InspectionTransaction_GEA I
	inner join #Characteristic C on I.CharacteristicSlNo=C.CharacteristicID
	where MaterialID=@PartID and OperationNo=@OpnNo and ProductionOrderNo=@PONo and SerialNo=@SlNo and InspectedBy='Operator' and isnull(InspectionValue1,'')<>''
	and isnull(InspectionValue2,'')<>'' and C.datatype=2 and I.PlanAndRevNo=@PlanAndRevNo

	select @Count=@Count+ISNULL(count(*),0) from InspectionTransaction_GEA I
	inner join #Characteristic C on I.CharacteristicSlNo=C.CharacteristicID
	where MaterialID=@PartID and OperationNo=@OpnNo and ProductionOrderNo=@PONo and SerialNo=@SlNo and InspectedBy='Operator' and isnull(InspectionValue1,'')<>''
	and C.datatype=1 and I.PlanAndRevNo=@PlanAndRevNo

	IF @Count=@ApplyToOpr or @count=@IsmandatoryForOperator
	Begin
		Select 'Allowed' as IsAllowed
	End
	Else
	Begin
		Select 'Not Allowed' as IsAllowed
	End
End

If @InspectedBy='QA Engineer'
begin
	insert into #Characteristic(CharacteristicID,datatype)
	select CharacteristicID,dbo.udf_GetNumeric(datatype) from SPC_Characteristic where ComponentID=@PartID and OperationNo=@OpnNo and AppliesToQuality='True' and IsMandatoryForQuality='True' and PlanNoAndRevNo=@PlanAndRevNo

	update #Characteristic set datatype=1 where datatype='' or datatype is null


	select @Count=ISNULL(count(*),0) from InspectionTransaction_GEA I
	inner join #Characteristic C on I.CharacteristicSlNo=C.CharacteristicID
	where MaterialID=@PartID and OperationNo=@OpnNo and ProductionOrderNo=@PONo and SerialNo=@SlNo and InspectedBy='QA Engineer' and isnull(InspectionValue1,'')<>''
	and isnull(InspectionValue2,'')<>'' and C.datatype=2 and I.PlanAndRevNo=@PlanAndRevNo

	select @Count=@Count+ISNULL(count(*),0) from InspectionTransaction_GEA I
	inner join #Characteristic C on I.CharacteristicSlNo=C.CharacteristicID
	where MaterialID=@PartID and OperationNo=@OpnNo and ProductionOrderNo=@PONo and SerialNo=@SlNo and InspectedBy='QA Engineer' and isnull(InspectionValue1,'')<>''
	and C.datatype=1 and I.PlanAndRevNo=@PlanAndRevNo

	IF @Count=@ApplyToQA or @count=@IsmandatoryForQA
	Begin
		Select 'Allowed' as IsAllowed
	End
	Else
	Begin
		Select 'Not Allowed' as IsAllowed
	End
End


END
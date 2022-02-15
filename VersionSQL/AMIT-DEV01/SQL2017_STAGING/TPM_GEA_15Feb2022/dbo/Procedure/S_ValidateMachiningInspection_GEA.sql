/****** Object:  Procedure [dbo].[S_ValidateMachiningInspection_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_ValidateMachiningInspection_GEA] 'yyyy','8441-6521-000','WFL M80 Mill Turn','30','SIR-037','3445'
--exec S_ValidateMachiningInspection_GEA @productOrder=N'yyyy',@MaterialID =N'8441-6521-000',@MachineID =N'WFL M80 Mill Turn',@Operation =N'20',@Inspection =N'SIR-037',@Slno =N''
--exec S_ValidateMachiningInspection_GEA @productOrder=N'yyyy',@MaterialID =N'8441-6521-000',@MachineID =N'WFL M80 Mill Turn',@Operation =N'30',@Inspection =N'SIR-037',@Slno =N'3445'
CREATE PROCEDURE [dbo].[S_ValidateMachiningInspection_GEA]
@productOrder nvarchar(50),
@MaterialID nvarchar(50),
@MachineID nvarchar(50),
@Operation nvarchar(50),
@Inspection nvarchar(50),
@Slno nvarchar(50)
WITH RECOMPILE
AS
BEGIN

SET NOCOUNT ON;

Declare @MasterCount as int
Declare @TransactionCount as int


Select @MasterCount=Count(distinct CharacteristicID) from SPC_Characteristic
where ComponentID=@MaterialID and OperationNo=@Operation and PlanNoAndRevNo=@Inspection and IsEnabled='True' and IsMandatoryForOpr='True'

Select @TransactionCount=Count(CharacteristicSlno) from [dbo].[InspectionTransaction_GEA] I
inner join SPC_Characteristic S on S.ComponentID=I.MaterialID and S.OperationNo=I.OperationNo and S.PlanNoAndRevNo=I.PlanAndRevNo and S.CharacteristicID=I.CharacteristicSlNo
where I.Machineid=@MachineID and I.MaterialID=@MaterialID and I.OperationNo=@Operation and I.PlanAndRevNo=@Inspection and I.ProductionOrderNo=@productOrder
and (isnull(I.inspectionvalue1,' ') <>' ') and S.IsEnabled='True' and S.IsMandatoryForOpr='True'


IF @MasterCount=0
Begin
Select 'Completed' as InspectionStatus
return;
END
ELSE IF @MasterCount=@TransactionCount
BEGIN
Select 'Completed' as InspectionStatus
return;
END
ELSE
BEGIN
Select 'Pending' as InspectionStatus
return;
END

END
/****** Object:  Procedure [dbo].[S_ValidateQualityInspection_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_ValidateInspection_GEA] 'View','26220001','1010','PO1','1234','Operator','Plan001'

CREATE PROCEDURE [dbo].[S_ValidateQualityInspection_GEA]
@productOrder nvarchar(50),
@MaterialID nvarchar(50),
@MachineID nvarchar(50),
@Operation nvarchar(50),
@Inspection nvarchar(50),
@GrnNO NVARCHAR(50)

WITH RECOMPILE
AS
BEGIN

SET NOCOUNT ON;

Declare @MasterCount as int
Declare @TransactionCount as int

SELECT @MasterCount = 0
SELECT @TransactionCount = 0

--Select @MasterCount=Count(distinct CharacteristicID)*5 from QualityIncomingMaster_GEA
--where ComponentID=@MaterialID and OperationNo=@Operation and PlanNoAndRevNo=@Inspection and ismandatory='True'

--Select @TransactionCount=Count(CharacteristicSlno) from QualityTransaction_GEA
--where Machineid=@MachineID and MaterialID=@MaterialID and OperationNo=@Operation and PlanAndRevNo=@Inspection and ProductionOrderNo=@productOrder
--and (isnull(inspectionvalue1,' ') <>' ' and isnull(InspectionValue2,' ') <> ' ')

Select @MasterCount=Count(distinct CharacteristicID) from QualityIncomingMaster_GEA
where ComponentID=@MaterialID and OperationNo=@Operation and PlanNoAndRevNo=@Inspection and ismandatory='True'

Select @TransactionCount=Count(A1.CharacteristicSlno) from QualityTransaction_GEA A1
inner join (Select distinct * from QualityIncomingMaster_GEA
where ComponentID=@MaterialID  and OperationNo=@Operation and PlanNoAndRevNo=@Inspection and ismandatory='True'
) A2 on A1.MaterialID=A2.ComponentID and A1.OperationNo=A2.OperationNo and A1.PlanAndRevNo=A2.PlanNoAndRevNo and A1.CharacteristicSlNo=A2.CharacteristicID
where (A1.MachineID=@MachineID or isnull(@MachineID,'')='') and A1.ProductionOrderNo=@productOrder AND ISNULL(A1.GrNNO,'')=ISNULL(@grNNO,'') and A1.BatchID=1 
and (isnull(A1.inspectionvalue1,' ') <>' ')


IF @MasterCount=0 
Begin
Select 'Completed' as InspectionStatus
END
ELSE IF @MasterCount=@TransactionCount
BEGIN
Select 'Completed' as InspectionStatus
END
Else
BEGIN
Select 'Pending' as InspectionStatus
end

END
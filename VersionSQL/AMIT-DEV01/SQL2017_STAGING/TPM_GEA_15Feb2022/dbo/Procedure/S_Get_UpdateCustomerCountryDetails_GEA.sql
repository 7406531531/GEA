/****** Object:  Procedure [dbo].[S_Get_UpdateCustomerCountryDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[S_Get_UpdateCustomerCountryDetails_GEA]
@ProductionOrderNo nvarchar(50)='',
@FabricationNo nvarchar(50)='',
@scrollNo nvarchar(50)='',
@Customer nvarchar(50)='',
@Location nvarchar(50)='',
@RDDMachines nvarchar(50)='',
@SaleOrder nvarchar(50)=''
AS
BEGIN

update ScheduleDetails_GEA set ScrollWelded=@scrollNo,SaleOrder=@SaleOrder,RDDMachines=@RDDMachines,Customer=@Customer,Location=@Location
where ProductionOrder=@ProductionOrderNo and FabricationNo=@FabricationNo

update MachineDataAssemblyAccessories_GEA set Customer=@Customer,Country=@Location,ScrollNo=@scrollNo,BowlNo=@scrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

update MachineDataAssemblyDescription_GEA set Customer=@Customer,@Location=@Location,ScrollNo=@scrollNo,BowlNo=@scrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

update MachineDataAssemblySpecification_GEA set Customer=@Customer,Country=@Location,ScrollNo=@scrollNo,BowlNo=@scrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

update ElectrotechnicalTransaction_GEA set Customer=@Customer,Country=@Location,ScrollNo=@scrollNo,BowlNo=@scrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

update DecanterChecklistTransaction_GEA set Customer=@Customer,Country=@Location,ScrollNo=@scrollNo,BowlNo=@ScrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

update NoiseMeasurementTransaction_GEA set Customer=@Customer,Country=@Location,ScrollNo=@scrollNo,BowlNo=@scrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

update VibrationTestProtocolTransaction_GEA set Customer=@Customer,Country=@Location,ScrollNo=@scrollNo,BowlNo=@scrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

update DecanterChecklistPackingTransaction_GEA set Customer=@Customer,Country=@Location,ScrollNo=@scrollNo,BowlNo=@scrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

update DecanterFinalTestingPackingTransaction_GEA set Customer=@Customer,Country=@Location,ScrollNo=@scrollNo,BowlNo=@scrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

update BlueCardTransaction_GEA set Customer=@Customer,Country=@Location,ScrollNo=@scrollNo,BowlNo=@scrollNo,MachineNo=@scrollNo
where OrderNo=@ProductionOrderNo and FabricationNo=@FabricationNo

end
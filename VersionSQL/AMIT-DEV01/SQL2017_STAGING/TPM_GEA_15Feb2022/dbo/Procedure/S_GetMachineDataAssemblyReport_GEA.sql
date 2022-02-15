/****** Object:  Procedure [dbo].[S_GetMachineDataAssemblyReport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
-- Author:		Raksha R
-- Create date: 12 Jan 2021

[dbo].[S_GetMachineDataAssemblyReport_GEA] '','','','','','',''
exec [S_GetMachineDataAssemblyReport_GEA] @MaterialID=N'',@OrderNo=N'840016568',@MachineID=N'Assembly',@FabricationNumber=N'8062-771',@param='view',@startdate=''
*/
CREATE procedure [dbo].[S_GetMachineDataAssemblyReport_GEA]
@StartDate datetime='',
@EndDate datetime='',
@MachineID nvarchar(50)='',
@OrderNo nvarchar(50)='',
@Param nvarchar(50)='',
@FabricationNumber nvarchar(50)='',
@MaterialID nvarchar(50)=''

AS 
BEGIN

	select TOP 1 * from ScheduleDetails_GEA where ProductionOrder=@OrderNo and FabricationNo=@FabricationNumber and (MaterialID=@MaterialID or isnull(@MaterialID,'')='') and (Machineid=@MachineID or isnull(@MachineID,'')='') 

	select A1.ParameterID,A2.PartNo,A2.SerialNo,A2.Speed,A2.Density,A2.Stamps,A2.Name as UpdatedBy,A2.UpdatedTS,employeeinformation.Name as TechnicianName ,
	A2.Confirmation,A2.MachineType,A2.FormatNo,A2.RevNo from MachineDataAssemblyMaster_GEA A1
	left join (select MachineType,ParameterID,PartNo,SerialNo,Speed,Density,Stamps,Name,UpdatedTS,TechnicianName,Confirmation,FormatNo,RevNo from MachineDataAssemblyDescription_GEA 
	left join employeeinformation on employeeinformation.Employeeid=MachineDataAssemblyDescription_GEA.UpdatedBy
	where MachineID=@MachineID and OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	left join employeeinformation on employeeinformation.Employeeid=A2.TechnicianName
	where A1.Type='Description'
	

	--select A1.ParameterID,A2.VibrationPickUp,A2.TempFiller,A2.AutoLube,A2.Flushing,A2.Name as UpdatedBy,A2.UpdatedTS,employeeinformation.Name as TechnicianName,A2.Confirmation,A2.MachineType,A2.FormatNo,A2.RevNo from MachineDataAssemblyMaster_GEA A1
	--left join (select MachineType,ParameterID,VibrationPickUp,TempFiller,AutoLube,Flushing,Name,UpdatedTS,TechnicianName,Confirmation,FormatNo,RevNo from MachineDataAssemblyAccessories_GEA 
	--left join employeeinformation on employeeinformation.Employeeid=MachineDataAssemblyAccessories_GEA.UpdatedBy
	--where MachineID=@MachineID  and OrderNo=@OrderNo and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	--left join employeeinformation on employeeinformation.Employeeid=A2.TechnicianName
	--where A1.Type='Accessories'

	select A1.ParameterID,A2.VibrationPickUp,A2.TempFiller,A2.AutoLube,A2.Flushing,A2.EnsureLocitte,A2.Name as UpdatedBy,A2.UpdatedTS,employeeinformation.Name as TechnicianName,A2.Confirmation,A2.MachineType,A2.FormatNo,A2.RevNo from MachineDataAssemblyMaster_GEA A1
	left join (select MachineType,ParameterID,VibrationPickUp,TempFiller,AutoLube,Flushing,EnsureLocitte,Name,UpdatedTS,TechnicianName,Confirmation,FormatNo,RevNo from MachineDataAssemblyAccessories_GEA 
	left join employeeinformation on employeeinformation.Employeeid=MachineDataAssemblyAccessories_GEA.UpdatedBy
	where MachineID=@MachineID  and OrderNo=@OrderNo and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	left join employeeinformation on employeeinformation.Employeeid=A2.TechnicianName
	where A1.Type='Accessories'
	

	select A1.ParameterID,A2.MainMotor,A2.SecondaryMotor,A2.Name as UpdatedBy,A2.UpdatedTS,employeeinformation.Name as TechnicianName,A2.Confirmation,A2.MachineType,A2.FormatNo,A2.RevNo,A1.SpecificationDT from MachineDataAssemblyMaster_GEA A1
	left join (select MachineType,ParameterID,MainMotor,SecondaryMotor,Name,UpdatedTS,TechnicianName,Confirmation,FormatNo,RevNo  from MachineDataAssemblySpecification_GEA
	left join employeeinformation on employeeinformation.Employeeid=MachineDataAssemblySpecification_GEA.UpdatedBy
	where MachineID=@MachineID and OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	left join employeeinformation on employeeinformation.Employeeid=A2.TechnicianName
	where A1.Type='Specifications'
	
END
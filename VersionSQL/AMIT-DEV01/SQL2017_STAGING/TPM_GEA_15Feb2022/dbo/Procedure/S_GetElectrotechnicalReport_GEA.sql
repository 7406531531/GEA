/****** Object:  Procedure [dbo].[S_GetElectrotechnicalReport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
-- Author:		Raksha R
-- Create date: 12 Jan 2021

[dbo].[S_GetElectrotechnicalReport_GEA] '','','','PROD1234567890','','FAB1234567890',''
*/
CREATE procedure [dbo].[S_GetElectrotechnicalReport_GEA]
@StartDate datetime='',
@EndDate datetime='',
@MachineID nvarchar(50)='',
@OrderNo nvarchar(50)='',
@Param nvarchar(50)='',
@FabricationNumber nvarchar(50)='',
@MaterialID nvarchar(50)=''

AS 
BEGIN

	select TOP 1 * from ScheduleDetails_GEA where ProductionOrder=@OrderNo and FabricationNo=@FabricationNumber and (MaterialID=@MaterialID or isnull(@MaterialID,'')='') and Machineid=@MachineID 

	--select A1.HeaderID,A1.SubHeaderID,A1.ValueInText,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.Confirmation,A2.MachineType,A2.FormatNo,A2.RevNo from ElectrotechnicalMaster_GEA A1
	--left join (select HeaderID,SubHeaderID,Checked,MachineType,Name,UpdatedTS,Confirmation,FormatNo,RevNo  from ElectrotechnicalTransaction_GEA
	--left join employeeinformation on employeeinformation.Employeeid=ElectrotechnicalTransaction_GEA.UpdatedBy
	--where MachineID=@MachineID and OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.HeaderID=A2.HeaderID and A1.SubHeaderID=A2.SubHeaderID

	select A1.HeaderID,A1.SubHeaderID,A1.ValueInText,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo from ElectrotechnicalMaster_GEA A1
	left join (select HeaderID,SubHeaderID,Checked,MachineType,Name,UpdatedTS,Confirmation,FormatNo,RevNo  from ElectrotechnicalTransaction_GEA
	left join employeeinformation on employeeinformation.Employeeid=ElectrotechnicalTransaction_GEA.UpdatedBy
	where MachineID=@MachineID and OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.HeaderID=A2.HeaderID and A1.SubHeaderID=A2.SubHeaderID
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	

END
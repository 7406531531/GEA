/****** Object:  Procedure [dbo].[S_GetDecanterChecklistPackingReport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_GetDecanterChecklistPackingReport_GEA] '','','','PROD1234567890','','FAB1234567890',''

CREATE Procedure [dbo].[S_GetDecanterChecklistPackingReport_GEA]
@StartDate datetime='',
@EndDate datetime='',
@MachineID nvarchar(50)='',
@OrderNo nvarchar(50)='',
@Param nvarchar(50)='',
@FabricationNumber nvarchar(50)='',
@MaterialID nvarchar(50)=''
As
Begin
	select TOP 1 * from ScheduleDetails_GEA where ProductionOrder=@OrderNo and FabricationNo=@FabricationNumber and (MaterialID=@MaterialID or isnull(@MaterialID,'')='') and (Machineid=@MachineID or ISNULL(@MachineID,'')='')   

    select A1.ID,A1.ParameterID,A1.Enabled,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedBy as EmployeeID,A2.UpdatedTS,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo from DecanterChecklistPackingMaster_GEA as A1
	left join (select ParameterID,Checked,MachineType,Name,UpdatedBy,UpdatedTS,Confirmation,FormatNo,RevNo from DecanterChecklistPackingTransaction_GEA 
	left join employeeinformation on employeeinformation.Employeeid=DecanterChecklistPackingTransaction_GEA.UpdatedBy
	where MachineID=@MachineID and OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ID=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
END
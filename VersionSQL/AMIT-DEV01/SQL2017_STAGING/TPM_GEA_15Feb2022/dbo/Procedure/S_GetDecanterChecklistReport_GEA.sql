/****** Object:  Procedure [dbo].[S_GetDecanterChecklistReport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_GetDecanterChecklistReport_GEA] '','','','458524555','','145522',''

CREATE Procedure [dbo].[S_GetDecanterChecklistReport_GEA]
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
		
	select A1.ID,A1.Parameter,A1.CheckedBy,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedBy as EmployeeID,A2.UpdatedTS,A2.Confirmation,A3.MachineType,A3.BalancingProductionOrder,A2.FormatNo,A2.RevNo,A2.Amps from DecanterChecklistMaster_GEA as A1
	left join (select ParameterID,Checked,MachineType,Name,UpdatedBy,UpdatedTS,Confirmation,FormatNo,RevNo,Amps from DecanterChecklistTransaction_GEA 
	left join employeeinformation on employeeinformation.Employeeid=DecanterChecklistTransaction_GEA.UpdatedBy
	where MachineID=@MachineID and OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ID=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType,BalancingProductionOrder from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3


END
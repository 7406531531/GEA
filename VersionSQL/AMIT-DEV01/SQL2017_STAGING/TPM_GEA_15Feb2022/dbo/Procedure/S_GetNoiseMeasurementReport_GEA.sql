/****** Object:  Procedure [dbo].[S_GetNoiseMeasurementReport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_GetNoiseMeasurementReport_GEA] '','','','PROD1234567890','','FAB1234567890',''

CREATE Procedure [dbo].[S_GetNoiseMeasurementReport_GEA]
@StartDate datetime='',
@EndDate datetime='',
@MachineID nvarchar(50)='',
@OrderNo nvarchar(50)='',
@Param nvarchar(50)='',
@FabricationNumber nvarchar(50)='',
@MaterialID nvarchar(50)=''
as
Begin

	select TOP 1 * from ScheduleDetails_GEA where ProductionOrder=@OrderNo and FabricationNo=@FabricationNumber and (MaterialID=@MaterialID or isnull(@MaterialID,'')='') and  (Machineid=@MachineID or ISNULL(@MachineID,'')='') 

	select * from NoiseMeasurementFormulaMaster_GEA

	select A1.ID,A1.ParameterID,A1.ValueInText,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo,A2.MaterialID,A2.Remarks from NoiseMeasurementMaster_GEA  as A1
	left join (select ParameterID,Checked,MachineType,Name,UpdatedTS,Confirmation,FormatNo,RevNo,MaterialID,Remarks from NoiseMeasurementTransaction_GEA  
	left join employeeinformation on employeeinformation.Employeeid=NoiseMeasurementTransaction_GEA.UpdatedBy
	where MachineID=@MachineID  and OrderNo=@OrderNo  and FabricationNo=@FabricationNumber ) A2 on A1.ValueInText=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.ParameterID in('1','2','3','4','5')

	select A1.ID,A1.ParameterID,A1.ValueInText,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo,A2.MaterialID,A2.Remarks from NoiseMeasurementMaster_GEA  as A1
	left join (select ParameterID,Checked,MachineType,Name,UpdatedTS,Confirmation,FormatNo,RevNo,MaterialID,Remarks from NoiseMeasurementTransaction_GEA  
	left join employeeinformation on employeeinformation.Employeeid=NoiseMeasurementTransaction_GEA.UpdatedBy
	where MachineID=@MachineID  and OrderNo=@OrderNo  and FabricationNo=@FabricationNumber ) A2 on A1.ValueInText=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.ParameterID in('6','7','8','9','10','11','12','13','14')

	
End
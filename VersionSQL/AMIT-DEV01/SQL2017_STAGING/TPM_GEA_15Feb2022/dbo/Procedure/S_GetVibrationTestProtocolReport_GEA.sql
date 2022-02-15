/****** Object:  Procedure [dbo].[S_GetVibrationTestProtocolReport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
-- Author:		Raksha R
-- Create date: 19 Feb 2021

[dbo].[S_GetVibrationTestProtocolReport_GEA] '','','','','','',''
exec S_GetVibrationTestProtocolReport_GEA @MaterialID=N'245',@OrderNo=N'A111',@MachineID=N'Testing',@FabricationNumber=N'A111'
*/
CREATE procedure [dbo].[S_GetVibrationTestProtocolReport_GEA]
@StartDate datetime='',
@EndDate datetime='',
@MachineID nvarchar(50)='',
@OrderNo nvarchar(50)='',
@Param nvarchar(50)='',
@FabricationNumber nvarchar(50)='',
@MaterialID nvarchar(50)=''

AS 
BEGIN

	select TOP 1 * from ScheduleDetails_GEA where ProductionOrder=@OrderNo and FabricationNo=@FabricationNumber and (MaterialID=@MaterialID or isnull(@MaterialID,'')='') and  (Machineid=@MachineID or ISNULL(@MachineID,'')='')  

	select A1.ParameterID,A2.ParameterValue,A2.Name as UpdatedBy,A2.UpdatedTS,A2.Confirmation,A3.MachineType,employeeinformation.Name as SignatureBy,A2.SignatureTS from VibrationTestProtocolMaster_GEA A1
	left join (select MachineType,ParameterID,ParameterValue,Name,UpdatedTS,Confirmation,SignatureBy,SignatureTS from VibrationTestProtocolTransaction_GEA
	left join employeeinformation on employeeinformation.Employeeid=VibrationTestProtocolTransaction_GEA.UpdatedBy
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber and MachineID=@MachineID ) A2 on A1.ParameterID=A2.ParameterID
	left join employeeinformation on employeeinformation.Employeeid=A2.SignatureBy
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.Type='ConditionAndRemark'

	select A1.ParameterID,HorizontalMin,HorizontalMax,VerticalMin,VerticalMax,AxialMin,AxialMax,A2.Name as UpdatedBy,A2.UpdatedTS,A2.Confirmation,A3.MachineType,employeeinformation.Name as SignatureBy,A2.SignatureTS from VibrationTestProtocolMaster_GEA A1
	left join (select MachineType,ParameterID,HorizontalMin,HorizontalMax,VerticalMin,VerticalMax,AxialMin,AxialMax,Name,UpdatedTS,Confirmation,SignatureBy,SignatureTS from VibrationTestProtocolTransaction_GEA 
	left join employeeinformation on employeeinformation.Employeeid=VibrationTestProtocolTransaction_GEA.UpdatedBy
	where OrderNo=@OrderNo and FabricationNo=@FabricationNumber and MachineID=@MachineID) A2 on A1.ParameterID=A2.ParameterID
	left join employeeinformation on employeeinformation.Employeeid=A2.SignatureBy
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.Type='MeasuredValues'

	select machineid,FabricationNo,MaterialID,OrderNo,ParameterID, n1.Checked as checked 
	into #FinalTemp
	from NoiseMeasurementTransaction_GEA n1
	where   FabricationNo=@FabricationNumber and OrderNo=@OrderNo and  (MaterialID=@MaterialID or isnull(@MaterialID,'')='') and  (Machineid=@MachineID or ISNULL(@MachineID,'')='')
	and ParameterID in ('Trommeldrehzahl / Bowl speed:','Differenzdrehzahl / Differential speed:','Motortyp / Motor type:','Drehzahl / Speed:','Zulaufleistung / Capacity:')


	update #FinalTemp Set checked=T1.checked
	From(
	select machineid,FabricationNo,MaterialID,OrderNo,ParameterID, (cast(n1.Checked as float)*1000)  as checked  from NoiseMeasurementTransaction_GEA n1
	where   FabricationNo=@FabricationNumber and OrderNo=@OrderNo and  (MaterialID=@MaterialID or isnull(@MaterialID,'')='') and  (Machineid=@MachineID or ISNULL(@MachineID,'')='')
	and ParameterID in ('Zulaufleistung / Capacity:')
	)T1 inner join #FinalTemp T2 on T1.MachineID=T2.MachineID and T1.FabricationNo=T2.FabricationNo and T1.MaterialID=T2.MaterialID and T1.OrderNo=T2.OrderNo and T1.ParameterID=T2.ParameterID

	select * from #FinalTemp
	return

	--select machineid,FabricationNo,MaterialID,OrderNo,ParameterID,case when ParameterID='Zulaufleistung / Capacity:' then (cast(n1.Checked as float)*1000) else n1.Checked end as checked  from NoiseMeasurementTransaction_GEA n1
	--where   FabricationNo=@FabricationNumber and OrderNo=@OrderNo and  (MaterialID=@MaterialID or isnull(@MaterialID,'')='') and  (Machineid=@MachineID or ISNULL(@MachineID,'')='')
	--and ParameterID in ('Trommeldrehzahl / Bowl speed:','Differenzdrehzahl / Differential speed:','Motortyp / Motor type:','Drehzahl / Speed:','Zulaufleistung / Capacity:')


	
END
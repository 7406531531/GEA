/****** Object:  Procedure [dbo].[S_GetBlueCardReport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
-- Author:		Raksha R
-- Create date: 22 Feb 2021

[dbo].[S_GetBlueCardReport_GEA] '','','','Test 4','8062-678','packing'
*/
CREATE procedure [dbo].[S_GetBlueCardReport_GEA]
@StartDate datetime='',
@EndDate datetime='',
@MachineID nvarchar(50)='',
@OrderNo nvarchar(50)='',
@FabricationNumber nvarchar(50)='',
@MaterialID nvarchar(50)=''

AS 
BEGIN

	select top 1 * from ScheduleDetails_GEA where ProductionOrder=@OrderNo and FabricationNo=@FabricationNumber and (MaterialID=@MaterialID or isnull(@MaterialID,'')='') and (Machineid=@MachineID or isnull(@MachineID,'')='')
	

	select A1.ParameterID,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.ApprovedBy,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo from BlueCardMaster_GEA A1
	left join (select MachineType,ParameterID,Checked,Name,UpdatedTS,ApprovedBy,Confirmation,FormatNo,RevNo from BlueCardTransaction_GEA 
	left join employeeinformation on employeeinformation.Employeeid=BlueCardTransaction_GEA.UpdatedBy
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.Type='Assembly1'
	
	--select A1.ParameterID,A2.PartNo,A2.[CheckNo(Series+SerialNo)],A2.[OverSpeed/UDP],A2.[Dye-Pen Test],A2.MaxStamped,A2.PermStamped,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.ApprovedBy,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo  from BlueCardMaster_GEA A1
	--left join (select MachineType,ParameterID,PartNo,[CheckNo(Series+SerialNo)],[OverSpeed/UDP],[Dye-Pen Test],MaxStamped,PermStamped,Checked,Name,UpdatedTS,ApprovedBy,Confirmation,FormatNo,RevNo from BlueCardTransaction_GEA 
	--left join employeeinformation on employeeinformation.Employeeid=BlueCardTransaction_GEA.UpdatedBy
	--where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	--Cross join (select distinct OrderNo,FabricationNo,MachineType  from MachineDataAssemblyDescription_GEA
	--where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	--where A1.Type='Assembly2'

	select distinct A1.ParameterID,isnull(A2.OrderNo,A3.OrderNo) as OrderNo,isnull(A2.FabricationNo,A3.FabricationNo) as FabricationNo,A2.PartNo,A2.[CheckNo(Series+SerialNo)],A2.[OverSpeed/UDP],A2.[Dye-Pen Test],A2.MaxStamped,A2.PermStamped,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.ApprovedBy,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo into #output2  from BlueCardMaster_GEA A1
	left join (select OrderNo,FabricationNo,MachineType,ParameterID,PartNo,[CheckNo(Series+SerialNo)],[OverSpeed/UDP],[Dye-Pen Test],MaxStamped,PermStamped,Checked,Name,UpdatedTS,ApprovedBy,Confirmation,FormatNo,RevNo from BlueCardTransaction_GEA 
	left join employeeinformation on employeeinformation.Employeeid=BlueCardTransaction_GEA.UpdatedBy
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType  from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.Type='Assembly2'

	Update #output2 set PartNo=T1.PartNo, [CheckNo(Series+SerialNo)]=T1.SerialNo
	from(
	select distinct OrderNo,FabricationNo,MachineType,ParameterID,PartNo,SerialNo from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber and ParameterID in ('Bowl')
	)T1 inner join #output2 T2 on T1.OrderNo=T2.OrderNo and T1.FabricationNo=T2.FabricationNo and T2.ParameterID='Bowl shell, Welded'
	where isnull(T2.PartNo,'')='' and isnull(T2.[CheckNo(Series+SerialNo)],'')=''


	Update #output2 set PartNo=T1.PartNo, [CheckNo(Series+SerialNo)]=T1.SerialNo
	from(
	select distinct OrderNo,FabricationNo,MachineType,ParameterID,PartNo,SerialNo from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber and ParameterID in ('Bearing Hub') 
	)T1 inner join #output2 T2 on T1.OrderNo=T2.OrderNo and T1.FabricationNo=T2.FabricationNo and T1.ParameterID=T2.ParameterID
	where isnull(T2.PartNo,'')='' and isnull(T2.[CheckNo(Series+SerialNo)],'')=''

	Select A1.* from #output2 A1
	inner join (select * from BlueCardMaster_GEA where [Type]='Assembly2') A2 on A1.ParameterID=A2.ParameterID
	Order by A2.ID asc

	select A1.ParameterID,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.ApprovedBy,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo from BlueCardMaster_GEA A1
	left join (select MachineType,ParameterID,Checked,Name,UpdatedTS,ApprovedBy,Confirmation,FormatNo,RevNo from BlueCardTransaction_GEA 
	left join employeeinformation on employeeinformation.Employeeid=BlueCardTransaction_GEA.UpdatedBy
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.Type='Assembly3'

	select A1.ParameterID,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.ApprovedBy,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo from BlueCardMaster_GEA A1
	left join (select MachineType,ParameterID,Checked,Name,UpdatedTS,ApprovedBy,Confirmation,FormatNo,RevNo from BlueCardTransaction_GEA 
	left join employeeinformation on employeeinformation.Employeeid=BlueCardTransaction_GEA.UpdatedBy
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.Type='Testing'

	select A1.ParameterID,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.ApprovedBy,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo from BlueCardMaster_GEA A1
	left join (select MachineType,ParameterID,Checked,Name,UpdatedTS,ApprovedBy,Confirmation,FormatNo,RevNo from BlueCardTransaction_GEA 
	left join employeeinformation on employeeinformation.Employeeid=BlueCardTransaction_GEA.UpdatedBy
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.Type='Packing'

	select A1.ParameterID,A2.Checked,A2.Name as UpdatedBy,A2.UpdatedTS,A2.Name as ApprovedBy,A2.Confirmation,A3.MachineType,A2.FormatNo,A2.RevNo from BlueCardMaster_GEA A1
	left join (select MachineType,ParameterID,Checked,Name,UpdatedTS,ApprovedBy,Confirmation,FormatNo,RevNo from BlueCardTransaction_GEA 
	left join employeeinformation on employeeinformation.Employeeid=BlueCardTransaction_GEA.ApprovedBY
	where  OrderNo=@OrderNo  and FabricationNo=@FabricationNumber) A2 on A1.ParameterID=A2.ParameterID
	Cross join (select distinct OrderNo,FabricationNo,MachineType from MachineDataAssemblyDescription_GEA
	where OrderNo=@OrderNo  and FabricationNo=@FabricationNumber)A3
	where A1.Type='Remarks'
END
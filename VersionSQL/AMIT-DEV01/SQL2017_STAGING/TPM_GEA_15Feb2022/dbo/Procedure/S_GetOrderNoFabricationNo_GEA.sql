/****** Object:  Procedure [dbo].[S_GetOrderNoFabricationNo_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[S_GetOrderNoFabricationNo_GEA] 'Assembly-1'
*/
CREATE PROCEDURE [dbo].[S_GetOrderNoFabricationNo_GEA]
@Param nvarchar(50)=''

AS
BEGIN

CREATE TABLE #Temp
(
	OrderNo nvarchar(50),
	FabricationNo nvarchar(50),
	Confirmation bit default 0
)

DECLARE @Process nvarchar(50)
SELECT @Process=''
select @process=(select process from machineinformation where machineid=@Param)

IF @Process='Assembly'
BEGIN
	INSERT into #Temp(OrderNo,FabricationNo,Confirmation)
	select distinct T1.OrderNo,T1.FabricationNo,T1.Confirmation from MachineDataAssemblyAccessories_GEA T1
	inner join ElectrotechnicalTransaction_GEA T2 on T1.MachineNo=T2.MachineNo and T1.MachineID=T2.MachineID
	and T1.OrderNo=T2.OrderNo and T1.FabricationNo=T2.FabricationNo
	where T1.Confirmation=1 and T2.Confirmation=1 and t1.MachineID=@Param

	Update #Temp set Confirmation=0

	update #Temp set Confirmation=isnull(T1.Confirmation,1)
	from(
	select Distinct A1.OrderNo,A1.FabricationNo,A1.Confirmation from BlueCardTransaction_GEA A1
	inner join #Temp A2 on A1.OrderNo=A2.OrderNo and A1.FabricationNo=A2.FabricationNo
	where A1.ParameterID in ('Discrepancies if any') and A1.Confirmation = 2
	)T1 inner join #temp T2 on T1.OrderNO=T2.OrderNo and T1.FabricationNo=T2.FabricationNo

	Delete from #Temp where Confirmation=1

	Select distinct OrderNo,FabricationNo from #Temp
END

IF @Process='Testing'
BEGIN
	INSERT into #Temp(OrderNo,FabricationNo,Confirmation)
	select distinct T1.OrderNo,T1.FabricationNo,T1.Confirmation from DecanterChecklistTransaction_GEA T1
	inner join NoiseMeasurementTransaction_GEA T2 on 
	T1.OrderNo=T2.OrderNo and T1.FabricationNo=T2.FabricationNo
	inner join VibrationTestProtocolTransaction_GEA T3 on 
	T1.OrderNo=T3.OrderNo and T1.FabricationNo=T3.FabricationNo
	where T1.Confirmation=1 and T2.Confirmation=1 and T3.Confirmation=1

	Update #Temp set Confirmation=0
	update #Temp set Confirmation=isnull(T1.Confirmation,1)
	from(
	select Distinct A1.OrderNo,A1.FabricationNo,A1.Confirmation from BlueCardTransaction_GEA A1
	inner join #Temp A2 on A1.OrderNo=A2.OrderNo and A1.FabricationNo=A2.FabricationNo
	where A1.ParameterID in ('Discrepancies if any') and A1.Confirmation = 2
	)T1 inner join #temp T2 on T1.OrderNO=T2.OrderNo and T1.FabricationNo=T2.FabricationNo

	Delete from #Temp where Confirmation=1

	Select distinct OrderNo,FabricationNo from #Temp
END

IF @Process='Packing'
BEGIN
	INSERT into #Temp(OrderNo,FabricationNo,Confirmation)
	select distinct T1.OrderNo,T1.FabricationNo,T1.Confirmation from DecanterChecklistPackingTransaction_GEA T1
	inner join DecanterFinalTestingPackingTransaction_GEA T2 on T1.MachineNo=T2.MachineNo and T1.MachineID=T2.MachineID
	and T1.OrderNo=T2.OrderNo and T1.FabricationNo=T2.FabricationNo
	where T1.Confirmation=1 and T2.Confirmation=1
	Update #Temp set Confirmation=0
	update #Temp set Confirmation=isnull(T1.Confirmation,1)
	from(
	select Distinct A1.OrderNo,A1.FabricationNo,A1.Confirmation from BlueCardTransaction_GEA A1
	inner join #Temp A2 on A1.OrderNo=A2.OrderNo and A1.FabricationNo=A2.FabricationNo
	where A1.ParameterID in ('Discrepancies if any') and A1.Confirmation = 2
	)T1 inner join #temp T2 on T1.OrderNO=T2.OrderNo and T1.FabricationNo=T2.FabricationNo

	Delete from #Temp where Confirmation=1

	Select distinct OrderNo,FabricationNo from #Temp
END

END
/****** Object:  Procedure [dbo].[S_GetNonMachiningReportCompletionDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[dbo].[S_GetNonMachiningReportCompletionDetails_GEA] '840016798','8062-824'
[dbo].[S_GetNonMachiningReportCompletionDetails_GEA] '2021-04-01 00:00:00','2021-11-10 00:00:00'

*/

CREATE procedure  [dbo].[S_GetNonMachiningReportCompletionDetails_GEA]
--@OrderNo nvarchar(50)='',
--@FabricationNo nvarchar(50)=''

@StartDate datetime='',
@EndDate datetime=''

AS
BEGIN

Create table #ProdOrderAndFabrication
(
	ProductionOrder nvarchar(50),
	FabricationNo nvarchar(50)
)

Insert into #ProdOrderAndFabrication(ProductionOrder,FabricationNo)
select distinct ProductionOrder,FabricationNo from ScheduleDetails_GEA 
inner join machineinformation m on m.machineid=ScheduleDetails_GEA.Machineid
where m.Process='Assembly' and ScheduleStart>=@StartDate and ScheduleEnd<=@EndDate

Create table #Temp1
(
	ProductionOrder nvarchar(50),
	FabricationNo nvarchar(50),
	Department nvarchar(50),
	[Assembly] nvarchar(10) default '0',
	Testing nvarchar(10) default '0',
	Packing nvarchar(10) default '0',
	Balancing nvarchar(10) default '0',
	SortOrder int
)

Create table #Temp2
(
	ProductionOrder nvarchar(50),
	FabricationNo nvarchar(50),
	Department nvarchar(50),
	[Assembly] nvarchar(10) default '0',
	Testing nvarchar(10) default '0',
	Packing nvarchar(10) default '0',
	Balancing nvarchar(10) default '0',
	SortOrder int
)

Create table #Temp3
(
	ProductionOrder nvarchar(50),
	FabricationNo nvarchar(50),
	Department nvarchar(50),
	[Assembly] nvarchar(10) default '0',
	Testing nvarchar(10) default '0',
	Packing nvarchar(10) default '0',
	Balancing nvarchar(10) default '0',
	SortOrder int
)

Insert into #Temp1(ProductionOrder,FabricationNo,Department,SortOrder)
select distinct ProductionOrder,FabricationNo,'Operator',1 from #ProdOrderAndFabrication

Update #Temp1 set [Assembly]=T1.Checked
From(
select distinct SD.ProductionOrder,SD.FabricationNo,(case when isnull(MDA.Confirmation,0)=1 and isnull(ET.Confirmation,0)=1 then 1
else 0
end
) as Checked from #ProdOrderAndFabrication SD
left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from MachineDataAssemblyAccessories_GEA 
where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication) 
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication) ) MDA on SD.ProductionOrder = MDA.OrderNo and SD.FabricationNo = MDA.FabricationNo 
left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from ElectrotechnicalTransaction_GEA 
where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication) 
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication) ) ET on SD.ProductionOrder = ET.OrderNo and SD.FabricationNo = ET.FabricationNo 
)T1 inner join #Temp1 T2 on T1.ProductionOrder=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo

Update #Temp1 set Testing=T1.Checked
From(
select distinct SD.ProductionOrder,SD.FabricationNo,
(case when isnull(MDA.Confirmation,0)=1 and isnull(ET.Confirmation,0)=1 and isnull(VTP.Confirmation,0)=1 then 1
else 0
end
) as Checked from #ProdOrderAndFabrication SD
left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from DecanterChecklistTransaction_GEA 
inner join DecanterChecklistMaster_GEA on DecanterChecklistMaster_GEA.ID = DecanterChecklistTransaction_GEA.ParameterID 
where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication) 
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication)  and CheckedBy='Operator') MDA on SD.ProductionOrder = MDA.OrderNo and SD.FabricationNo = MDA.FabricationNo 
left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from NoiseMeasurementTransaction_GEA 
where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication) 
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication)) ET on SD.ProductionOrder = ET.OrderNo and SD.FabricationNo = ET.FabricationNo 
left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from VibrationTestProtocolTransaction_GEA 
where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication) 
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication) ) VTP on SD.ProductionOrder = VTP.OrderNo and SD.FabricationNo = VTP.FabricationNo 
)T1 inner join #Temp1 T2 on T1.ProductionOrder=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo

Update #Temp1 set Packing=T1.Checked
from(
select distinct SD.ProductionOrder,SD.FabricationNo,
(case when isnull(MDA.Confirmation,0)=1 and isnull(ET.Confirmation,0)=1  then 1
else 0
end
) as Checked from #ProdOrderAndFabrication SD
left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from DecanterChecklistPackingTransaction_GEA 
where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication) 
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication)) MDA on SD.ProductionOrder = MDA.OrderNo and SD.FabricationNo = MDA.FabricationNo 
left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from DecanterFinalTestingPackingTransaction_GEA 
where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication) 
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication) ) ET on SD.ProductionOrder = ET.OrderNo and SD.FabricationNo = ET.FabricationNo 
)T1 inner join #Temp1 T2 on T1.ProductionOrder=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo

Update #Temp1 set Balancing=T1.Confirmed
from(
select distinct A2.OrderNo,A1.Productionno,A1.Confirmed from BalancingReportTransaction A1
inner join (select distinct OrderNo,BalancingProductionOrder from MachineDataAssemblyDescription_GEA 
where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication)
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication)
)A2 on A1.Productionno=A2.BalancingProductionOrder
)T1 inner join #Temp1 T2 on T1.OrderNo=T2.ProductionOrder 

Insert into #Temp2(ProductionOrder,FabricationNo,Department,SortOrder)
select distinct ProductionOrder,FabricationNo,'Quality',2 from #ProdOrderAndFabrication


Update #Temp2 set [Assembly]=T1.Checked, Testing=T1.Checked, Balancing='-' ,Packing=T1.Checked
--Update #Temp2 set [Assembly]=T1.Checked, Testing=T1.Checked, Balancing=T1.Checked ,Packing='-'
from(
select distinct OrderNo,FabricationNo,
(case when Confirmation=2 then 1 else 0 end) as Checked 
from BlueCardTransaction_GEA where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication)
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication)
and ParameterID='Discrepancies if any' 
)T1 inner join #Temp1 T2 on T1.OrderNo=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo

Insert into #Temp3(ProductionOrder,FabricationNo,Department,SortOrder)
select distinct ProductionOrder,FabricationNo,'Logistics',3 from #ProdOrderAndFabrication


Update #Temp3 set Packing=T1.Checked, [Assembly]='-', Testing='-', Balancing='-'
from(
select distinct OrderNo,FabricationNo,Confirmation as Checked 
from BlueCardTransaction_GEA where OrderNo in (select distinct ProductionOrder from #ProdOrderAndFabrication)
and FabricationNo in (select distinct FabricationNo from #ProdOrderAndFabrication)
and ParameterID in ('Responsibility of Packing' ,'Responsibility of Shipping')
)T1 inner join #Temp1 T2 on T1.OrderNo=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo


select distinct ProductionOrder,FabricationNo,Department,[Assembly],Testing,Packing,Balancing,SortOrder from
(select distinct ProductionOrder,FabricationNo,Department,[Assembly],Testing,Packing,Balancing,SortOrder from #Temp1
Union
select distinct ProductionOrder,FabricationNo,Department,[Assembly],Testing,Packing,Balancing,SortOrder from #Temp2
Union
select distinct ProductionOrder,FabricationNo,Department,[Assembly],Testing,Packing,Balancing,SortOrder from #Temp3
)T1
order by T1.ProductionOrder,T1.FabricationNo,T1.SortOrder

END

-------Old code

--Insert into #Temp1(ProductionOrder,FabricationNo,Department,SortOrder)
--select @OrderNo,@FabricationNo,'Operator',1

--Update #Temp1 set [Assembly]=T1.Checked
--From(
--select distinct SD.ProductionOrder,SD.FabricationNo,(case when isnull(MDA.Confirmation,0)=1 and isnull(ET.Confirmation,0)=1 then 1
--else 0
--end
--) as Checked from ScheduleDetails_GEA SD
--left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from MachineDataAssemblyAccessories_GEA where OrderNo=@OrderNo and FabricationNo = @FabricationNo ) MDA on SD.ProductionOrder = MDA.OrderNo and SD.FabricationNo = MDA.FabricationNo 
--left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from ElectrotechnicalTransaction_GEA where OrderNo=@OrderNo and FabricationNo = @FabricationNo ) ET on SD.ProductionOrder = ET.OrderNo and SD.FabricationNo = ET.FabricationNo 
--where SD.ProductionOrder=@OrderNo and SD.FabricationNo = @FabricationNo 
--)T1 inner join #Temp1 T2 on T1.ProductionOrder=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo


--Update #Temp1 set Testing=T1.Checked
--From(
--select distinct SD.ProductionOrder,SD.FabricationNo,
--(case when isnull(MDA.Confirmation,0)=1 and isnull(ET.Confirmation,0)=1 and isnull(VTP.Confirmation,0)=1 then 1
--else 0
--end
--) as Checked from ScheduleDetails_GEA SD
--left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from DecanterChecklistTransaction_GEA inner join DecanterChecklistMaster_GEA on DecanterChecklistMaster_GEA.ID = DecanterChecklistTransaction_GEA.ParameterID where OrderNo=@OrderNo and FabricationNo = @FabricationNo  and CheckedBy='Operator') MDA on SD.ProductionOrder = MDA.OrderNo and SD.FabricationNo = MDA.FabricationNo 
--left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from NoiseMeasurementTransaction_GEA where OrderNo=@OrderNo and FabricationNo = @FabricationNo) ET on SD.ProductionOrder = ET.OrderNo and SD.FabricationNo = ET.FabricationNo 
--left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from VibrationTestProtocolTransaction_GEA where OrderNo=@OrderNo and FabricationNo = @FabricationNo ) VTP on SD.ProductionOrder = VTP.OrderNo and SD.FabricationNo = VTP.FabricationNo 
--where SD.ProductionOrder=@OrderNo and SD.FabricationNo = @FabricationNo 
--)T1 inner join #Temp1 T2 on T1.ProductionOrder=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo


--Update #Temp1 set Packing=T1.Checked
--from(
--select distinct SD.ProductionOrder,SD.FabricationNo,
--(case when isnull(MDA.Confirmation,0)=1 and isnull(ET.Confirmation,0)=1  then 1
--else 0
--end
--) as Checked from ScheduleDetails_GEA SD
--left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from DecanterChecklistPackingTransaction_GEA where OrderNo=@OrderNo and FabricationNo = @FabricationNo) MDA on SD.ProductionOrder = MDA.OrderNo and SD.FabricationNo = MDA.FabricationNo 
--left join (select Distinct MachineID,FabricationNo,OrderNo,Confirmation from DecanterFinalTestingPackingTransaction_GEA where OrderNo=@OrderNo and FabricationNo = @FabricationNo ) ET on SD.ProductionOrder = ET.OrderNo and SD.FabricationNo = ET.FabricationNo 
--where SD.ProductionOrder=@OrderNo and SD.FabricationNo = @FabricationNo 
--)T1 inner join #Temp1 T2 on T1.ProductionOrder=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo

--Update #Temp1 set Packing=T1.Confirmed
--from(
--select distinct Productionno,Confirmed from BalancingReportTransaction where Productionno=@OrderNo 
--)T1 inner join #Temp1 T2 on T1.Productionno=T2.ProductionOrder 

--Insert into #Temp2(ProductionOrder,FabricationNo,Department,SortOrder)
--select @OrderNo,@FabricationNo,'Quality',2


--Update #Temp2 set [Assembly]=T1.Checked, Testing=T1.Checked, Balancing=T1.Checked ,Packing='-'
--from(
--select distinct OrderNo,FabricationNo,
--(case when Confirmation=2 then 1 else 0 end) as Checked 
--from BlueCardTransaction_GEA where OrderNo=@OrderNo and FabricationNo=@FabricationNo
--and ParameterID='Discrepancies if any' 
--)T1 inner join #Temp1 T2 on T1.OrderNo=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo

--Insert into #Temp3(ProductionOrder,FabricationNo,Department,SortOrder)
--select @OrderNo,@FabricationNo,'Logistics',3


--Update #Temp3 set Packing=T1.Checked, [Assembly]='-', Testing='-', Balancing='-'
--from(
--select distinct OrderNo,FabricationNo,Confirmation as Checked 
--from BlueCardTransaction_GEA where OrderNo=@OrderNo and FabricationNo=@FabricationNo
--and ParameterID in ('Responsibility of Packing' ,'Responsibility of Shipping')
--)T1 inner join #Temp1 T2 on T1.OrderNo=T2.ProductionOrder and T1.FabricationNo=t2.FabricationNo


--select distinct ProductionOrder,FabricationNo,Department,[Assembly],Testing,Packing,Balancing,SortOrder from
--(select distinct ProductionOrder,FabricationNo,Department,[Assembly],Testing,Packing,Balancing,SortOrder from #Temp1
--Union
--select distinct ProductionOrder,FabricationNo,Department,[Assembly],Testing,Packing,Balancing,SortOrder from #Temp2
--Union
--select distinct ProductionOrder,FabricationNo,Department,[Assembly],Testing,Packing,Balancing,SortOrder from #Temp3
--)T1
--order by T1.SortOrder
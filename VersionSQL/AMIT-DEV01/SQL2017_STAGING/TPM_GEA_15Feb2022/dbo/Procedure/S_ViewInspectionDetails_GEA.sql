/****** Object:  Procedure [dbo].[S_ViewInspectionDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_ViewInspectionDetails_GEA] 'LiveView','','PO1','1234',' 63.5 BASE REWORK','1','','','','','','','',''
--[dbo].[S_ViewInspectionDetails_GEA] 'HistoryView','','PO1','1234','GEAR CASE','1010','J-125','','','','','','',''
--[dbo].[S_ViewInspectionDetails_GEA] 'Insert','','PO1','1234',' 63.5 BASE REWORK','1','J-125','PR1','1','10','20','Operator','PCT','Testing'
--[dbo].[S_ViewInspectionDetails_GEA] 'Insert','','PO1','1234',' 63.5 BASE REWORK','1','J-125','PR1','1','15','20','QA Engineer','AMIT','corrected'

CREATE PROCEDURE [dbo].[S_ViewInspectionDetails_GEA]
@Param nvarchar(50)='',
@SearchDate datetime='',
@ProdOrderNo nvarchar(50)='',
@SlNo nvarchar(50)='',
@PartID nvarchar(50)='',
@OpnNo nvarchar(50)='',
@MachineID nvarchar(50)='',
@PlanAndRevNo nvarchar(50)='',
@CharacteristicSlNo nvarchar(50)='',
@val1 nvarchar(50)='',
@val2 nvarchar(50)='',
@InspectedBy nvarchar(50)='',
@OprInspectorName nvarchar(50)='',
@Remarks nvarchar(500)=''
WITH RECOMPILE
AS
BEGIN

SET NOCOUNT ON;

create table #InspecDetails
(
idd int default 0,
MachineID nvarchar(50),
PartID nvarchar(50),
PlanAndRevNo nvarchar(50),
OpnNo nvarchar(50),
ProdOrderNo nvarchar(50),
Slno nvarchar(50),
CharacteristicSlNo nvarchar(50),
CharacteristicCode nvarchar(50),
InsByOpr nvarchar(50),
InsByQAEngg nvarchar(50),
OprTS nvarchar(50),
QAEnggTS nvarchar(50),
OprValue1 nvarchar(50),
OprValue2 nvarchar(50),
QAValue1 nvarchar(50),
QAValue2 nvarchar(50),
InspectedBy nvarchar(50),
InspectorName nvarchar(50),
Oprname nvarchar(50),
OprRemarks nvarchar(500),
QARemarks nvarchar(500),
AppliesToOpr bit,
AppliesToQA bit,
IsMandatoryForOpr bit,
IsMandatoryForQA bit,
datatype nvarchar(50),
Sdate datetime,
ShiftName nvarchar(50),
RowNumber int,
LSL nvarchar(50),
USL nvarchar(50)
)

declare @curtime as datetime
select @curtime=getdate()


If @Param='Insert'
Begin

IF NOT EXISTS(Select * From InspectionTransaction_GEA where MachineID=@Machineid and MaterialID=@PartID and ProductionOrderNo=@ProdOrderNo
and OperationNo=@OpnNo and SerialNo=@SlNo and CharacteristicSlNo=@CharacteristicSlNo and PlanAndRevNo=@PlanAndRevNo and InspectedBy=@InspectedBy)
Begin
Insert into InspectionTransaction_GEA(MachineID, MaterialID, ProductionOrderNo, OperationNo, SerialNo, PlanAndRevNo, CharacteristicSlNo, InspectionValue1, InspectionValue2, InspectedBy, InspectedTS, OprInspectorName, Remarks)
SELECT @MachineID, @PartID, @ProdOrderNo, @OpnNo, @SlNo, @PlanAndRevNo, @CharacteristicSlNo, @val1, @val2, @InspectedBy, @curtime, @OprInspectorName, @Remarks

END
ELSE
BEGIN
Update InspectionTransaction_GEA SET InspectionValue1=@val1,InspectionValue2=@val2,InspectedTS=@curtime,OprInspectorName=@OprInspectorName,Remarks=@Remarks
where MachineID=@Machineid and MaterialID=@PartID and ProductionOrderNo=@ProdOrderNo and OperationNo=@OpnNo and PlanAndRevNo=@PlanAndRevNo and SerialNo=@SlNo and CharacteristicSlNo=@CharacteristicSlNo and InspectedBy=@InspectedBy
END
END

IF @param='LiveView'
BEGIN

Insert into #InspecDetails(MachineID,PartID,OpnNo,ProdOrderNo,CharacteristicSlNo,CharacteristicCode,PlanAndRevNo,Slno,datatype,AppliesToOpr,AppliesToQA,IsMandatoryForOpr,IsMandatoryForQA,LSL,USL)
Select @MachineID,ComponentID,OperationNo,@ProdOrderNo,CharacteristicID,CharacteristicCode,PlanNoAndRevNo,@Slno,
datatype,AppliesToOpr,AppliesToQuality,IsMandatoryForOpr,IsMandatoryForQuality,LSL,USL from SPC_Characteristic
where ComponentID=@PartID and OperationNo=@OpnNo
and (PlanNoAndRevNo=@PlanAndRevNo or ISNULL(@PlanAndRevNo,'')='')

Update #InspecDetails SET OprName=T.opr,OprValue1=T.InspectionValue1,OprValue2=T.InspectionValue2,OprTS=T.TS,OprRemarks=t.Remarks From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,I.CharacteristicSlNo,I.PlanAndRevNo,I.Slno,IW.InspectionValue1,IW.InspectionValue2
,IW.InspectedTS as TS,IW.OprInspectorName as opr,IW.Remarks From #InspecDetails I
inner join InspectionTransaction_GEA IW on IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo AND IW.SerialNo=I.Slno
where IW.InspectedBy='Operator' and IW.MaterialID=@PartID and IW.OperationNo=@OpnNo and IW.ProductionOrderNo=@ProdOrderNo and IW.SerialNo=@SlNo
)T inner join #InspecDetails I on T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.Slno=I.slno and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo

Update #InspecDetails SET InspectorName=T.opr,QAValue1=T.InspectionValue1,QAValue2=T.InspectionValue2,QAEnggTS=T.TS,QARemarks=t.Remarks From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,I.CharacteristicSlNo,I.PlanAndRevNo,I.Slno,IW.InspectionValue1,IW.InspectionValue2
,IW.InspectedTS as TS,IW.OprInspectorName as opr,IW.Remarks From #InspecDetails I
inner join InspectionTransaction_GEA IW on IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo AND IW.SerialNo=I.Slno
where IW.InspectedBy='QA Engineer' and IW.MaterialID=@PartID and IW.OperationNo=@OpnNo and IW.ProductionOrderNo=@ProdOrderNo and IW.SerialNo=@SlNo
)T inner join #InspecDetails I on T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.Slno=I.slno and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo

Select MachineID,PartID,OpnNo,ProdOrderNo,PlanAndRevNo,Slno,CharacteristicSlNo,CharacteristicCode,datatype,AppliesToOpr,AppliesToQA,IsMandatoryForOpr,IsMandatoryForQA,OprValue1,OprValue2,OprRemarks,Oprname,employeeinformation.Name as EmployeeName,OprTS,
QAValue1,QAValue2,QARemarks,InspectorName,QAEnggTS,LSL,USL from #InspecDetails
left outer join employeeinformation on employeeinformation.Employeeid=#InspecDetails.Oprname

END

IF @param='HistoryView'
BEGIN

CREATE TABLE #ShiftDefn
(
ShiftDate datetime,
Shiftname nvarchar(20),
ShftSTtime datetime,
ShftEndTime datetime
)

Insert into #InspecDetails(MachineID,PartID,OpnNo,ProdOrderNo,CharacteristicSlNo,CharacteristicCode,PlanAndRevNo,Slno,datatype,AppliesToOpr,AppliesToQA,IsMandatoryForOpr,IsMandatoryForQA,LSL,USL)
Select @MachineID,ComponentID,OperationNo,@ProdOrderNo,CharacteristicID,CharacteristicCode,PlanNoAndRevNo,@Slno,
datatype,AppliesToOpr,AppliesToQuality,IsMandatoryForOpr,IsMandatoryForQuality,LSL,USL from SPC_Characteristic
where ComponentID=@PartID and (OperationNo=@OpnNo or ISNULL(@OpnNo,'')='')
and (PlanNoAndRevNo=@PlanAndRevNo or ISNULL(@PlanAndRevNo,'')='')

Update #InspecDetails SET OprName=T.opr,OprValue1=T.InspectionValue1,OprValue2=T.InspectionValue2,OprTS=T.TS,OprRemarks=t.Remarks From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,I.CharacteristicSlNo,I.PlanAndRevNo,I.Slno,IW.InspectionValue1,IW.InspectionValue2
,IW.InspectedTS as TS,IW.OprInspectorName as opr,IW.Remarks From #InspecDetails I
inner join InspectionTransaction_GEA IW on IW.MachineID=I.MachineID and IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo AND IW.SerialNo=I.Slno
where IW.InspectedBy='Operator' and IW.MachineID=@MachineID and
IW.MaterialID=@PartID and (IW.OperationNo=@OpnNo or isnull(@OpnNo,'')='')
and IW.ProductionOrderNo=@ProdOrderNo and IW.SerialNo=@SlNo
)T inner join #InspecDetails I on T.MachineID=I.MachineID and T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.Slno=I.slno and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo

Update #InspecDetails SET InspectorName=T.opr,QAValue1=T.InspectionValue1,QAValue2=T.InspectionValue2,QAEnggTS=T.TS,QARemarks=t.Remarks From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,I.CharacteristicSlNo,I.PlanAndRevNo,I.Slno,IW.InspectionValue1,IW.InspectionValue2
,IW.InspectedTS as TS,IW.OprInspectorName as opr,IW.Remarks From #InspecDetails I
inner join InspectionTransaction_GEA IW on IW.MachineID=I.MachineID and IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo AND IW.SerialNo=I.Slno
where IW.InspectedBy='QA Engineer' and IW.MachineID=@MachineID and
IW.MaterialID=@PartID and (IW.OperationNo=@OpnNo or isnull(@OpnNo,'')='')
and IW.ProductionOrderNo=@ProdOrderNo and IW.SerialNo=@SlNo
)T inner join #InspecDetails I on T.MachineID=I.MachineID and T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.Slno=I.slno and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo

declare @starttime as datetime
declare @endtime as datetime
select @starttime=[dbo].[f_GetLogicalDayStart](min(I.OprTS)),@endtime=[dbo].[f_GetLogicalDayStart](max(I.OprTS)) from #InspecDetails I


while @starttime<=@endtime
Begin
Insert into #ShiftDefn(ShiftDate,Shiftname,ShftSTtime,ShftEndTime)
Exec s_GetShiftTime @starttime,''
select @starttime=dateadd(day,1,@starttime)
End

update #InspecDetails set Sdate=T.ShiftDate,ShiftName=T.Shiftname from(
Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,I.CharacteristicSlNo,I.PlanAndRevNo,I.Slno,I.OprTS,convert(nvarchar(10),S.ShiftDate,120) as shiftdate,S.Shiftname
From #InspecDetails I cross join #ShiftDefn S
where (I.OprTS>=S.ShftSTtime and I.OprTS<=S.ShftEndTime))T inner join #InspecDetails I on T.MachineID=I.MachineID and T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.Slno=I.slno and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo and T.OprTS=I.OprTS

Select ROW_NUMBER() over(order by characteristicslno) as RowNumber,MachineID,PartID,OpnNo,ProdOrderNo,PlanAndRevNo,Slno,CharacteristicSlNo,CharacteristicCode,
datatype,AppliesToOpr,AppliesToQA,IsMandatoryForOpr,IsMandatoryForQA,OprValue1,OprValue2,OprRemarks,Oprname,employeeinformation.Name as EmployeeName,OprTS,
QAValue1,QAValue2,QARemarks,InspectorName,QAEnggTS,convert(nvarchar(10),SDate,120) as Sdate,ShiftName,LSL,USL from #InspecDetails
left outer join employeeinformation on employeeinformation.Employeeid=#InspecDetails.Oprname

END

END
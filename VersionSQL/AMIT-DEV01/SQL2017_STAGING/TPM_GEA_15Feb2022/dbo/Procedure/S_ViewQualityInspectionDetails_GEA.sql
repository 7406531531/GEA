/****** Object:  Procedure [dbo].[S_ViewQualityInspectionDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[dbo].[S_ViewQualityInspectionDetails_GEA] 'View','P1','C1','1','M1','','','','','','',''
[dbo].[S_ViewQualityInspectionDetails_GEA]  'View','test','0001-1363-400','10','Quality Incoming','IQC - 380'
[dbo].[S_ViewQualityInspectionDetails_GEA]  'ViewNext','test','0001-1363-400','10','Quality Incoming','IQC - 380','','','','','','',5
[dbo].[S_ViewQualityInspectionDetails_GEA]  'View','test6','0001-1550-400','10','Quality Incoming','IQC - 381'
[dbo].[S_ViewQualityInspectionDetails_GEA]  'Report','test6','0001-1550-400','10','Quality Incoming','IQC - 381'
[dbo].[S_ViewQualityInspectionDetails_GEA] 'Insert','P1','C1','1','M1','PR1','2','2','10.2','12.5','AMIT','Test'
exec S_ViewQualityInspectionDetails_GEA @Param=N'View',@ProdOrderNo=N'PRODQUALITYTEST105',@PartID=N'8442-6521-010',@OpnNo=N'60',@MachineID=N'Quality In house',@PlanAndRevNo=N'IQC-1012',@Lastbatchid=0
*/
CREATE  PROCEDURE [dbo].[S_ViewQualityInspectionDetails_GEA]
@Param nvarchar(50)='',
@ProdOrderNo nvarchar(50)='',
@PartID nvarchar(50)='',
@OpnNo nvarchar(50)='', 
@MachineID nvarchar(50)='',
@PlanAndRevNo nvarchar(50)='',
@CharacteristicSlNo nvarchar(50)='',
@BatchID nvarchar(50)='',
@val1 nvarchar(50)='',
@val2 nvarchar(50)='',
@InspectedBy nvarchar(50)='',
@Remarks nvarchar(500)='',
@LastBatchID int=0,
@Confirmation int=0,
@GrnNo NVARCHAR(50)=''

WITH RECOMPILE
AS
BEGIN

SET NOCOUNT ON;

create table #InspecDetails
(
idd int identity(1,1) Not Null,
MachineID nvarchar(50),
PartID nvarchar(50),
PlanAndRevNo nvarchar(50),
OpnNo nvarchar(50),
ProdOrderNo nvarchar(50), 
GrnNo NVARCHAR(50),
CharacteristicSlNo nvarchar(50),
--BatchID nvarchar(50),
BatchID int,
CharacteristicCode nvarchar(50),
IsEnabled nvarchar(5),
IsMandatory nvarchar(5),
DataType nvarchar(50),
UOM nvarchar(50),
SetValue nvarchar(50),
LSL nvarchar(50),
USL nvarchar(50),
InspectedValue nvarchar(50),
InspectedBy nvarchar(50),
InspectedTS datetime,
Remarks nvarchar(1000),
Batch int,
Confirmation int
)

create table #BatchID
(
BatchID nvarchar(50)
)

declare @curtime as datetime
select @curtime=getdate()

DECLARE @DynamicPivotQuery AS NVARCHAR(4000),
@SelectColumnName AS NVARCHAR(2000);

Declare @cnt int
Select @cnt= ValueInInt from ShopDefaults where Parameter='QualityTransactionBatchCount' and ValueInText='Quality Incoming'
Declare @i as nvarchar(10)

If @Param='Insert'
Begin

	IF NOT EXISTS(Select * From QualityTransaction_GEA where MachineID=@Machineid and MaterialID=@PartID and ProductionOrderNo=@ProdOrderNo
	and OperationNo=@OpnNo and BatchID=@BatchID and CharacteristicSlNo=@CharacteristicSlNo and PlanAndRevNo=@PlanAndRevNo AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,''))
	Begin
		Insert into QualityTransaction_GEA(MachineID, MaterialID, ProductionOrderNo, OperationNo, BatchID, PlanAndRevNo, CharacteristicSlNo, InspectionValue1, InspectionValue2, InspectedBy, InspectedTS, Remarks,Confirmation,GrnNo)
		SELECT @MachineID, @PartID, @ProdOrderNo, @OpnNo, @BatchID, @PlanAndRevNo, @CharacteristicSlNo, @val1, @val2, @InspectedBy, @curtime,@Remarks,@Confirmation,@GrnNo

	END
	ELSE
	BEGIN
		Update  QualityTransaction_GEA SET InspectionValue1=@val1,InspectionValue2=@val2,InspectedTS=@curtime,InspectedBy=@InspectedBy,Remarks=@Remarks,Confirmation=@Confirmation
		where MachineID=@Machineid and MaterialID=@PartID and ProductionOrderNo=@ProdOrderNo and OperationNo=@OpnNo  and PlanAndRevNo=@PlanAndRevNo and Batchid=@BatchID and CharacteristicSlNo=@CharacteristicSlNo AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
	END
END

IF @param='View'
BEGIN

Select @i='1'

while @i<='5'
Begin 

Insert into #BatchID
Select @i

Select @i=@i+1
End

Insert into #InspecDetails(MachineID,PartID,OpnNo,ProdOrderNo,CharacteristicSlNo,CharacteristicCode,PlanAndRevNo,IsEnabled,IsMandatory,DataType,UOM,SetValue,BatchID,LSL,USL,GrnNo)
Select @MachineID,ComponentID,OperationNo,@ProdOrderNo,CharacteristicID,CharacteristicCode,PlanNoAndRevNo,
IsEnabled,IsMandatory,DataType,UOM,Value,#BatchID.BatchID,LSL,USL,ISNULL(@GrnNo,'') from QualityIncomingMaster_GEA Cross Join #BatchID
where ComponentID=@PartID and (OperationNo=@OpnNo or ISNULL(@OpnNo,'')='')  
and (PlanNoAndRevNo=@PlanAndRevNo or ISNULL(@PlanAndRevNo,'')='')  


Update #InspecDetails SET InspectedValue=T.InspectionValue1  From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,ISNULL(I.GrnNo,'') AS GrnNo,I.CharacteristicSlNo,I.PlanAndRevNo,I.BatchID,IW.InspectionValue1 From #InspecDetails I
inner join QualityTransaction_GEA IW on IW.MachineID=I.MachineID and  IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo AND IW.BatchID=I.BatchID
where IW.MachineID=@MachineID and IW.MaterialID=@PartID and (IW.OperationNo=@OpnNo or isnull(@OpnNo,'')='') 
and IW.ProductionOrderNo=@ProdOrderNo AND ((ISNULL(IW.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')
)T inner join #InspecDetails I on  T.MachineID=I.MachineID and T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.BatchID=I.BatchID and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo AND ISNULL(T.GrnNo,'')=ISNULL(I.GrnNo,'')
where I.BatchID in(select distinct BatchID from #BatchID)


Update #InspecDetails SET InspectedBy=T.Opr,Remarks=t.Remarks,InspectedTS=T.TS, Confirmation=T.Confirmation From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,ISNULL(I.GrnNo,'') AS GrnNo,I.CharacteristicSlNo,I.PlanAndRevNo,I.BatchID,IW.InspectedTS as TS,IW.InspectedBy as opr,IW.Remarks,IW.Confirmation From #InspecDetails I
inner join QualityTransaction_GEA IW on IW.MachineID=I.MachineID and  IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo
where IW.MachineID=@MachineID and IW.MaterialID=@PartID and (IW.OperationNo=@OpnNo or isnull(@OpnNo,'')='') 
and IW.ProductionOrderNo=@ProdOrderNo AND ((ISNULL(IW.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')
)T inner join #InspecDetails I on  T.MachineID=I.MachineID and T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo AND ISNULL(T.GrnNo,'')=ISNULL(I.GrnNo,'')



SELECT @SelectColumnName= ISNULL(@SelectColumnName + ',','') 
+ QUOTENAME(Batchid)
FROM (select distinct Batchid from #BatchID) AS BatchValues 


SET @DynamicPivotQuery = 
N'SELECT ROW_NUMBER() Over(order by len(CharacteristicSlNo),CharacteristicSlNo) as Slno,CharacteristicSlNo,CharacteristicCode,LSL,USL,UOM,Datatype,SetValue,' + @SelectColumnName + ',InspectedBy,Remarks,InspectedTS,IsMandatory
FROM (select MachineID,PartID,OpnNo,ProdOrderNo,CharacteristicSlNo,CharacteristicCode,PlanAndRevNo,IsEnabled,IsMandatory,DataType,UOM,SetValue,BatchID,LSL,USL,
InspectedValue,InspectedBy,Remarks,InspectedTS,Confirmation
from #InspecDetails 
)as s 
PIVOT (max(InspectedValue)
FOR [batchid] IN (' + @SelectColumnName + ')) AS PVTTable order by len(CharacteristicSlNo),CharacteristicSlNo'
--order by cast(dbo.SplitAlphanumeric(CharacteristicSlNo,''^0-9'')as int)'
EXEC sp_executesql @DynamicPivotQuery

END

IF @param='ViewNext'
BEGIN

Select @i=@LastBatchID+1

while @i<=@LastBatchID+5
Begin 

Insert into #BatchID
Select @i


Select @i=@i+1
End

Insert into #InspecDetails(MachineID,PartID,OpnNo,ProdOrderNo,CharacteristicSlNo,CharacteristicCode,PlanAndRevNo,IsEnabled,IsMandatory,DataType,UOM,SetValue,BatchID,LSL,USL,GrnNo)
Select @MachineID,ComponentID,OperationNo,@ProdOrderNo,CharacteristicID,CharacteristicCode,PlanNoAndRevNo,
IsEnabled,IsMandatory,DataType,UOM,Value,#BatchID.BatchID,LSL,USL,ISNULL(@GrnNo,'') from QualityIncomingMaster_GEA Cross Join #BatchID
where ComponentID=@PartID and (OperationNo=@OpnNo or ISNULL(@OpnNo,'')='')  
and (PlanNoAndRevNo=@PlanAndRevNo or ISNULL(@PlanAndRevNo,'')='')  

Update #InspecDetails SET InspectedValue=T.InspectionValue1  From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,ISNULL(I.GrnNo,'') AS GrnNo, I.CharacteristicSlNo,I.PlanAndRevNo,I.BatchID,IW.InspectionValue1 From #InspecDetails I
inner join QualityTransaction_GEA IW on IW.MachineID=I.MachineID and  IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo AND IW.BatchID=I.BatchID
where IW.MachineID=@MachineID and IW.MaterialID=@PartID and (IW.OperationNo=@OpnNo or isnull(@OpnNo,'')='') 
and IW.ProductionOrderNo=@ProdOrderNo AND ((ISNULL(IW.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')
)T inner join #InspecDetails I on  T.MachineID=I.MachineID and T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.BatchID=I.BatchID and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo  AND ISNULL(T.GrnNo,'')=ISNULL(I.GrnNo,'')
where I.BatchID in(select distinct BatchID from #BatchID)

Update #InspecDetails SET InspectedBy=T.Opr,Remarks=t.Remarks,InspectedTS=T.TS, Confirmation=T.Confirmation From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,ISNULL(I.GrnNo,'') AS GrnNo,I.CharacteristicSlNo,I.PlanAndRevNo,I.BatchID,IW.InspectedTS as TS,IW.InspectedBy as opr,IW.Remarks,IW.Confirmation From #InspecDetails I
inner join QualityTransaction_GEA IW on IW.MachineID=I.MachineID and  IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo
where IW.MachineID=@MachineID and IW.MaterialID=@PartID and (IW.OperationNo=@OpnNo or isnull(@OpnNo,'')='') 
and IW.ProductionOrderNo=@ProdOrderNo AND ((ISNULL(IW.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')
)T inner join #InspecDetails I on  T.MachineID=I.MachineID and T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo AND ISNULL(T.GrnNo,'')=ISNULL(I.GrnNo,'')

SELECT @SelectColumnName= ISNULL(@SelectColumnName + ',','') 
+ QUOTENAME(Batchid)
FROM (select Batchid from #BatchID) AS BatchValues 

SET @DynamicPivotQuery = 
N'SELECT ROW_NUMBER() Over(order by len(CharacteristicSlNo),CharacteristicSlNo) as Slno,CharacteristicSlNo,CharacteristicCode,LSL,USL,UOM,Datatype,SetValue,' + @SelectColumnName + ',InspectedBy,Remarks,InspectedTS,IsMandatory
FROM (select MachineID,PartID,OpnNo,ProdOrderNo,CharacteristicSlNo,CharacteristicCode,PlanAndRevNo,IsEnabled,IsMandatory,DataType,UOM,SetValue,BatchID,LSL,USL,
InspectedValue,InspectedBy,Remarks,InspectedTS,Confirmation
from #InspecDetails 
)as s 
PIVOT (max(InspectedValue)
FOR [batchid] IN (' + @SelectColumnName + ')) AS PVTTable order by len(CharacteristicSlNo),CharacteristicSlNo '
--order by cast(dbo.SplitAlphanumeric(CharacteristicSlNo,''^0-9'')as int)'
EXEC sp_executesql @DynamicPivotQuery

END

IF @param='Report'
BEGIN

Select @i=1

select @LastBatchID = (select max(IW.BatchID) from QualityIncomingMaster_GEA I
inner join QualityTransaction_GEA IW on  IW.MaterialID=I.ComponentID and IW.OperationNo=I.OperationNo
and  IW.CharacteristicSlNo=I.CharacteristicID and IW.PlanAndRevNo=I.PlanNoAndRevNo 
where IW.MachineID=@MachineID and IW.MaterialID=@PartID and (IW.OperationNo=@OpnNo or isnull(@OpnNo,'')='') 
and IW.ProductionOrderNo=@ProdOrderNo AND ISNULL(iw.GrnNo,'')=ISNULL(@GrnNo,''))

while @i<=@LastBatchID
Begin 
	Insert into #BatchID
	Select @i
	Select @i=@i+1
End


Insert into #InspecDetails(MachineID,PartID,OpnNo,ProdOrderNo,CharacteristicSlNo,CharacteristicCode,PlanAndRevNo,IsEnabled,IsMandatory,DataType,UOM,SetValue,BatchID,LSL,USL,GrnNo)
Select @MachineID,ComponentID,OperationNo,@ProdOrderNo,CharacteristicID,CharacteristicCode,PlanNoAndRevNo,
IsEnabled,IsMandatory,DataType,UOM,Value,#BatchID.BatchID,LSL,USL,ISNULL(@GrnNo,'') from QualityIncomingMaster_GEA Cross Join #BatchID
where ComponentID=@PartID and (OperationNo=@OpnNo or ISNULL(@OpnNo,'')='')  
and (PlanNoAndRevNo=@PlanAndRevNo or ISNULL(@PlanAndRevNo,'')='')  

Update #InspecDetails SET InspectedValue=T.InspectionValue1  From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,ISNULL(I.GrnNo,'') AS GrnNo, I.CharacteristicSlNo,I.PlanAndRevNo,I.BatchID,IW.InspectionValue1 From #InspecDetails I
inner join QualityTransaction_GEA IW on IW.MachineID=I.MachineID and  IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo AND IW.BatchID=I.BatchID
where IW.MachineID=@MachineID and IW.MaterialID=@PartID and (IW.OperationNo=@OpnNo or isnull(@OpnNo,'')='') 
and IW.ProductionOrderNo=@ProdOrderNo AND ((ISNULL(IW.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')
)T inner join #InspecDetails I on  T.MachineID=I.MachineID and T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.BatchID=I.BatchID and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo AND ISNULL(T.GrnNo,'')=ISNULL(I.GrnNo,'')
where I.BatchID in(select distinct BatchID from #BatchID)

Update #InspecDetails SET InspectedBy=T.Opr,Remarks=t.Remarks,InspectedTS=T.TS, Confirmation=T.Confirmation From
(Select I.MachineID,I.PartID,I.OpnNo,I.ProdOrderNo,ISNULL(I.GrnNo,'') AS GrnNo, I.CharacteristicSlNo,I.PlanAndRevNo,I.BatchID,IW.InspectedTS as TS,IW.InspectedBy as opr,IW.Remarks,IW.Confirmation From #InspecDetails I
inner join QualityTransaction_GEA IW on IW.MachineID=I.MachineID and  IW.MaterialID=I.PartID and IW.OperationNo=I.OpnNo
and IW.ProductionOrderNo=I.ProdOrderNo and IW.CharacteristicSlNo=I.CharacteristicSlNo and IW.PlanAndRevNo=I.PlanAndRevNo
where IW.MachineID=@MachineID and IW.MaterialID=@PartID and (IW.OperationNo=@OpnNo or isnull(@OpnNo,'')='') 
and IW.ProductionOrderNo=@ProdOrderNo AND ((ISNULL(IW.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')
)T inner join #InspecDetails I on  T.MachineID=I.MachineID and T.PartID=I.PartID and T.OpnNo=I.OpnNo and T.ProdOrderNo=I.ProdOrderNo
and T.CharacteristicSlNo=I.CharacteristicSlNo and T.PlanAndRevNo=I.PlanAndRevNo AND ISNULL(T.GrnNo,'')=ISNULL(I.GrnNo,'')

SELECT @SelectColumnName= ISNULL(@SelectColumnName + ',','') 
+ QUOTENAME(Batchid)
FROM (select Batchid from #BatchID) AS BatchValues 

SET @DynamicPivotQuery = 
N'SELECT ROW_NUMBER() Over(order by len(CharacteristicSlNo),CharacteristicSlNo) as Slno,CharacteristicSlNo,CharacteristicCode,LSL,USL,UOM,Datatype,SetValue,InspectedBy,Remarks,InspectedTS,IsMandatory,' + @SelectColumnName + ' 
FROM (select MachineID,PartID,OpnNo,ProdOrderNo,CharacteristicSlNo,CharacteristicCode,PlanAndRevNo,IsEnabled,IsMandatory,DataType,UOM,SetValue,BatchID,LSL,USL,
InspectedValue,A2.Name as InspectedBy,Remarks,InspectedTS,Confirmation
from #InspecDetails A1
inner join employeeinformation A2 on A1.InspectedBy=A2.Employeeid
)as s 
PIVOT (max(InspectedValue)
FOR [batchid] IN (' + @SelectColumnName + ')) AS PVTTable order by len(CharacteristicSlNo),CharacteristicSlNo '
--order by cast(dbo.SplitAlphanumeric(CharacteristicSlNo,''^0-9'')as int)'
EXEC sp_executesql @DynamicPivotQuery


--select A1.IDD,A1.MachineID,A1.ProductionOrderNo,A1.MaterialID,A1.OperationNo,A1.PlanAndRevNo,A1.Action,A2.Name as ActionPerformedBy,A1.ActionPerformedTS,A1.Reason,A1.Remarks,A1.Quality8DReport,A1.Quality8DReportComplete,
--A1.DeviationWithRemarks,A1.DeviationWithOutRemarks,A1.Release,A1.Blocked,A1.IQRReport,A1.IQRReportComplete,A1.NCReport,A1.NCReportComplete,A1.DeviationReport,A1.DeviationReportComplete from QualityIncomingActionDetails_GEA A1
--inner join employeeinformation A2 on A1.ActionPerformedBy=A2.Employeeid
--where A1.ProductionOrderNo=@ProdOrderNo and A1.MaterialID=@PartID and A1.MachineID=@MachineID and A1.OperationNo=@OpnNo and A1.PlanAndRevNo=@PlanAndRevNo

select * from QualityIncomingActionDetails_GEA A1
where A1.ProductionOrderNo=@ProdOrderNo and A1.MaterialID=@PartID and A1.MachineID=@MachineID and A1.OperationNo=@OpnNo and A1.PlanAndRevNo=@PlanAndRevNo
AND ((ISNULL(a1.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')


END

END
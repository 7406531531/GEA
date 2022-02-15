/****** Object:  Procedure [dbo].[S_ViewInspectionStatus_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_ViewInspectionStatus_GEA] 'PO1',''

CREATE  PROCEDURE [dbo].[S_ViewInspectionStatus_GEA]
@ProdOrder nvarchar(50)='',
@FromDate datetime=''
WITH RECOMPILE
AS
BEGIN

SET NOCOUNT ON;

create table #InspecStatus
(
ProductionOrderNo nvarchar(50),
MaterialID nvarchar(50),
OperationNo nvarchar(50),
SerialNo nvarchar(50),
MachineID nvarchar(50),
CompletedTS datetime,
InspectedBy nvarchar(50),
Status nvarchar(50),
PlanAndRevNo nvarchar(50)
)

declare @curtime as datetime
select @curtime=getdate()

If isnull(@FromDate, '')<>'' and isnull(@ProdOrder, '')=''
Begin
	Insert into #InspecStatus(ProductionOrderNo,MaterialID,OperationNo,SerialNo,MachineID,CompletedTS,InspectedBy,PlanAndRevNo)
	select ProductionOrderNo, MaterialID, OperationNo, SerialNo, MachineID, CompletedTS,InspectedBy,PlanAndRevNo
	from FinalInspectionTransaction_GEA 
	where (convert(nvarchar(10), CompletedTS, 120)>=convert(nvarchar(10), @FromDate, 120) and convert(nvarchar(10), CompletedTS, 120)<=convert(nvarchar(10), @curtime, 120))
End
Else If isnull(@FromDate, '')='' and isnull(@ProdOrder, '')<>''
Begin
	Insert into #InspecStatus(ProductionOrderNo,MaterialID,OperationNo,SerialNo,MachineID,CompletedTS,InspectedBy,PlanAndRevNo)
	select ProductionOrderNo, MaterialID, OperationNo, SerialNo, MachineID, CompletedTS,InspectedBy,PlanAndRevNo
	from FinalInspectionTransaction_GEA where (ProductionOrderNo like '%' + @ProdOrder +'%' or isnull(@ProdOrder, '')='')
End
else
begin
	Insert into #InspecStatus(ProductionOrderNo,MaterialID,OperationNo,SerialNo,MachineID,CompletedTS,InspectedBy,PlanAndRevNo)
	select ProductionOrderNo, MaterialID, OperationNo, SerialNo, MachineID, CompletedTS,InspectedBy,PlanAndRevNo
	from FinalInspectionTransaction_GEA where (convert(nvarchar(10), CompletedTS, 120)>=convert(nvarchar(10), dateadd(day, -6, @curtime), 120) 
	and convert(nvarchar(10), CompletedTS, 120)<=convert(nvarchar(10), @curtime, 120))
end

select T.*,case when I.InspectedBy='Operator' then 'Operator Completed' when I.InspectedBy='QA Engineer' then 'QA Engineer Completed' END as Status  From
(select ProductionOrderNo, MaterialID, OperationNo, SerialNo, MachineID, MAX(CompletedTS) as CompletedTS,PlanAndRevNo from #InspecStatus 
group by ProductionOrderNo, MaterialID, OperationNo, SerialNo, MachineID,PlanAndRevNo)T inner join #InspecStatus I on T.CompletedTS=I.CompletedTS


END
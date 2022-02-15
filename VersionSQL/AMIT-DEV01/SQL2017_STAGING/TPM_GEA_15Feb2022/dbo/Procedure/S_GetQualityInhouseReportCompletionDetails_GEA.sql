/****** Object:  Procedure [dbo].[S_GetQualityInhouseReportCompletionDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
exec [dbo].[S_GetQualityInhouseReportCompletionDetails_GEA] '8175-6517-400','876876','','HardnessReport'
exec [dbo].[S_GetQualityInhouseReportCompletionDetails_GEA] '8175-6517-400','876876','','FirstSampleReport'
exec [dbo].[S_GetQualityInhouseReportCompletionDetails_GEA] '8175-6517-400','876876','','Other'
exec S_GetQualityInhouseReportCompletionDetails_GEA @ProductionOrderNo=N'PRODSEPT202021TEST0001',@PartNo=N'0001-0392-400',@MachineID=N'Quality Incoming',@Param=N'FirstSampleReport'

*/
CREATE procedure [dbo].[S_GetQualityInhouseReportCompletionDetails_GEA]
@PartNo nvarchar(50)='',
@ProductionOrderNo nvarchar(50)='',
@MachineID nvarchar(50)='',
@GrnNo nvarchar(50)='',
@Param nvarchar(50)='',

@PartName nvarchar(250)=''

AS
BEGIN

	Create table #Temp
	(
		Report nvarchar(50),
		ReportStatus nvarchar(50),
		Checked bit default 1
	)

	INSERT into #Temp(Report)
	Values('HardnessReport'),('FirstSampleReport'),('QualityReport'),('8DReport'),('InternalQualityReport'),('DyePenetrationReport'),('NonConformanceReport'),('DeviationReport')

	Update #Temp set ReportStatus= (select (case when T1.Confirmation=1 Then 'Partially Completed'
												when T1.Confirmation=2 Then 'Completed'
									else 'Pending' 
									end) as ReportStatus
									from (Select distinct Confirmation from HardnessReportDetails_GEA 
										where PartNo=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (Machineid=@MachineID ) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='HardnessReport'

	Update #Temp set ReportStatus= (select (case when T1.Confirmation=1 Then 'Partially Completed'
												when T1.Confirmation=2 Then 'Completed'
									else 'Pending' 
									end) as ReportStatus
									from (Select distinct Confirmation from DyePenetrationReportDetails_GEA 
										where PartNo=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (Machineid=@MachineID ) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='DyePenetrationReport'

	Update #Temp set ReportStatus= (select (case when T1.Confirmation=1 Then 'Partially Completed'
											when T1.Confirmation=2 Then 'Completed'
									else 'Pending' 
									end) as ReportStatus
									from (Select distinct Confirmation from FirstSampleReportDetails_GEA 
										where PartNo=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (Machineid=@MachineID) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='FirstSampleReport'

	Update #Temp set ReportStatus= (select (case when T1.Confirmation=1 Then 'Partially Completed'
											when T1.Confirmation=2 Then 'Completed'
									else 'Pending' 
									end) as ReportStatus
									from (Select distinct Confirmation from QualityTransaction_GEA 
										where MaterialID=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (MachineID=@MachineID) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='QualityReport'

	Update #Temp set ReportStatus= (select (case when T1.Confirmation=1 Then 'Partially Completed'
											when T1.Confirmation=2 Then 'Completed'
									else 'Pending' 
									end) as ReportStatus
									from (Select distinct Confirmation from InternalQualityReportDetails_GEA 
										where PartNo=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (Machineid=@MachineID) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='InternalQualityReport'

	Update #Temp set ReportStatus= (select (case when T1.Confirmation=1 Then 'Partially Completed'
											when T1.Confirmation=2 Then 'Completed'
									else 'Pending' 
									end) as ReportStatus
									from (Select distinct Confirmation from Quality_8DReportTransaction_GEA 
										where  PONo=@ProductionOrderNo 
										and (MachineID=@MachineID ) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='8DReport'

	Update #Temp set ReportStatus= (select (case when T1.Confirmation=1 Then 'Partially Completed'
											when T1.Confirmation=2 Then 'Completed'
									else 'Pending' 
									end) as ReportStatus
									from (Select distinct Confirmation from NonConformanceReportDetails_GEA 
										where PartNo=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (MachineID=@MachineID ) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='NonConformanceReport'

	Update #Temp set ReportStatus= (select (case when T1.Confirmation=1 Then 'Partially Completed'
											when T1.Confirmation=2 Then 'Completed'
									else 'Pending' 
									end) as ReportStatus
									from (Select distinct Confirmation from DeviationReportDetails_GEA 
										where PartNo=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (Machineid=@MachineID) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='DeviationReport'

	Update #Temp set Checked= (select (case when T1.IQRReport=1 Then 1
												else 0 
									end) as ReportStatus
									from (Select distinct IQRReport from QualityIncomingActionDetails_GEA 
										where MaterialID=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (Machineid=@MachineID) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='InternalQualityReport'

	Update #Temp set Checked= (select (case when T1.Quality8DReport=1 Then 1
												else 0 
									end) as ReportStatus
									from (Select distinct Quality8DReport from QualityIncomingActionDetails_GEA 
										where MaterialID=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (Machineid=@MachineID) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='8DReport'

	Update #Temp set Checked= (select (case when T1.NCReport=1 Then 1
												else 0 
									end) as ReportStatus
									from (Select distinct NCReport from QualityIncomingActionDetails_GEA 
										where MaterialID=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (Machineid=@MachineID) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='NonConformanceReport'

	Update #Temp set Checked= (select (case when T1.DeviationReport=1 Then 1
												else 0 
									end) as ReportStatus
									from (Select distinct DeviationReport from QualityIncomingActionDetails_GEA 
										where MaterialID=@PartNo and ProductionOrderNo=@ProductionOrderNo
										and (Machineid=@MachineID) and isnull(GrnNo,'')=isnull(@GrnNo,'')
									) as T1)
	where #Temp.Report='DeviationReport'

IF @Param='HardnessReport'
BEGIN
	Select Report,ReportStatus from #Temp where Report=@Param
END
IF @Param='FirstSampleReport'
BEGIN
	Select Report,ReportStatus from #Temp where Report=@Param
END
IF @Param='Other'
BEGIN
	IF @PartName like '%Scroll%'
	BEGIN
		Select Report,ReportStatus from #Temp where Report not in ('HardnessReport','FirstSampleReport','DyePenetrationReport') and Checked=1
	END
	ELSE
	BEGIN
		Select Report,ReportStatus from #Temp where Report not in ('HardnessReport','FirstSampleReport') and Checked=1
	END
END
IF @Param='WithHardnessReport'
BEGIN
	Select Report,ReportStatus from #Temp where Report not in ('FirstSampleReport') and Checked=1
END
IF @Param='WithOutHardnessReport'
BEGIN

	Select Report,ReportStatus from #Temp where Report not in ('HardnessReport','FirstSampleReport','DyePenetrationReport') and Checked=1
END
END
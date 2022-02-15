/****** Object:  Procedure [dbo].[S_Quality8Dreport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_Quality8Dreport_GEA] 'P1','

CREATE  PROCEDURE [dbo].[S_Quality8Dreport_GEA]
@PONo nvarchar(50)='',
--@reportNo nvarchar(50),
--@Issuedate datetime
@MachineID nvarchar(50)='',
@GrnNo NVARCHAR(50)=''
WITH RECOMPILE
AS
BEGIN

SET NOCOUNT ON;

--IF Exists(Select * from Quality_8DReportTransaction_GEA t where T.PONo=@PONo and T.ReportNo=@reportNo and convert(nvarchar(10),T.IssueDate,120)=convert(nvarchar(10),@Issuedate,120))
IF Exists(Select * from Quality_8DReportTransaction_GEA t where T.PONo=@PONo and T.Machineid=@machineid AND ISNULL(T.GrnNo,'')=ISNULL(@GrnNo,''))
Begin
--Select Top 1 Issuer,Field,ProblemOriginatedAt,Notes,UpdatedBy,UpdatedTS from Quality_8DReportTransaction_GEA T where T.PONo=@PONo 
--and T.ReportNo=@reportNo and convert(nvarchar(10),T.IssueDate,120)=convert(nvarchar(10),@Issuedate,120)
--order by UpdatedTS desc

--Select M.HeaderID,M.Header,M.SubHeaderID,M.SubHeader,M.GridOrRichText,T.TextValue,T.Item1,T.Item2,T.Item3,ISNULL(T.IsEnable,0) as IsEnable  
--from Quality_8DReportMaster_GEA M
--Left outer join Quality_8DReportTransaction_GEA T 
--on M.HeaderID=T.HeaderID and M.SubHeaderid=T.SubHeaderID
----where T.PONo=@PONo and T.ReportNo=@reportNo and convert(nvarchar(10),T.IssueDate,120)=convert(nvarchar(10),@Issuedate,120)
--Order by HeaderID

	Select Top 1 Issuer,Field,ProblemOriginatedAt,Notes,UpdatedBy,UpdatedTS,ReportNo from Quality_8DReportTransaction_GEA T where T.PONo=@PONo 
	and T.Machineid=@machineid
	order by UpdatedTS desc

	Select M.HeaderID,M.Header,M.SubHeaderID,M.SubHeader,M.GridOrRichText,T.TextValue,T.Item1,T.Item2,T.Item3,ISNULL(T.IsEnable,0) as IsEnable  
	into #Quality from Quality_8DReportMaster_GEA M
	Left outer join Quality_8DReportTransaction_GEA T 
	on M.HeaderID=T.HeaderID and M.SubHeaderid=T.SubHeaderID
	where T.PONo=@PONo and T.Machineid=@MachineID AND ((ISNULL(T.GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='') 


	Select * from #Quality
	UNION
	Select M.HeaderID,M.Header,M.SubHeaderID,M.SubHeader,M.GridOrRichText,NULL as TextValue,NULL as Item1,NULL as Item2,NULL as Item3,0 as IsEnable
	from Quality_8DReportMaster_GEA M
	where Not Exists(Select * from #Quality where M.HeaderID=#Quality.HeaderID and M.SubHeaderid=#Quality.SubHeaderID)
	Order by HeaderID
End
Else
Begin
	Select Null Issuer,Null Field,Null ProblemOriginatedAt,Null Notes,Null UpdatedBy,Null UpdatedTS

	Select M.HeaderID,M.Header,M.SubHeaderID,M.SubHeader,M.GridOrRichText,NULL as TextValue,NULL as Item1,NULL as Item2,NULL as Item3,0 as IsEnable from Quality_8DReportMaster_GEA M
	Order by HeaderID
End


END
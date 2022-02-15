/****** Object:  Procedure [dbo].[GenerateReportNo_Gea]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[dbo].[GenerateReportNo_Gea] '2022-12-23 06:00:00.000','0001-0392-400'
*/
CREATE procedure [dbo].[GenerateReportNo_Gea]
@date datetime='',
@PartNo nvarchar(50)=''
as
begin
declare  @ReNo nvarchar(50)
declare @ddmmyy nvarchar(50)
select @ReNo=(select isnull(max(cast(substring(ReportNo,CHARINDEX('-',ReportNo)+1,len(ReportNo) - 23) as int)),0) from Quality_8DReportTransaction_GEA where datepart(year,UpdatedTS)=datepart(year,@date) and (UpdatedTS>'2022-01-01 06:00:00.00'))
select @ddmmyy=(SELECT RIGHT('0' + RTRIM(datepart(day,@Date)), 2)+''+ RIGHT('0' + RTRIM(datepart(month,@Date)), 2)+''+right(datepart(year,@Date),4))
select @ReNo=cast(@ReNo as int)+1
select @ReNo=(select replicate('0',3-LEN(@ReNo)) + CONVERT(VARCHAR,@ReNo))
select @ReNo=@ddmmyy+'-'+@ReNo+'-'+@PartNo
select @ReNo as ReNo
end
									
/****** Object:  Procedure [dbo].[S_GetNonConformanceReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[dbo].[S_GetNonConformanceReportDetails_GEA] @NcNo=N'',@Date=N'2022-01-03 16:51:51.000',@PartNo=N'0001-0392-402',@ProductionOrderNo=N'P3',@BatchNo=N'B3',@MachineID=N'M3', @Param=N'Save'
*/
CREATE PROCEDURE [dbo].[S_GetNonConformanceReportDetails_GEA]
@ID BIGINT=0,
@NcNo NVARCHAR(50)='',
@PartName NVARCHAR(50)='',
@PartNo NVARCHAR(50)='',
@ProductionOrderNo NVARCHAR(50)='',
@BatchNo NVARCHAR(50)='',
@GrnNo NVARCHAR(50)='',
@Date DATETIME='',
@Supplier NVARCHAR(50)='',
@ReceivedQty NVARCHAR(20)='',
@NCQty NVARCHAR(50)='',
@Reason1 NVARCHAR(150)='',
@Reason2 NVARCHAR(150)='',
@Reason3 NVARCHAR(150)='',
@Reason4 NVARCHAR(150)='',
@Reason5 NVARCHAR(150)='',
@Details NVARCHAR(200)='',
@ImagePath1 NVARCHAR(100)='',
@ImagePath2 NVARCHAR(100)='',
@Rework NVARCHAR(20)='',
@Acceptance NVARCHAR(20)='',
@Rejected NVARCHAR(20)='',
@QASign NVARCHAR(50)='',
@SignDate  DATETIME='',
@Place NVARCHAR(50)='',
@Confirmation INT=0,

@MachineID NVARCHAR(50)='',
@Param NVARCHAR(50)=''

AS
BEGIN
IF @Param='View'
BEGIN
	SELECT SDG.*,SUBSTRING(C.description,CHARINDEX('[',C.description,2)+1,LEN(C.description)-CHARINDEX(']',C.description)-2) AS ModelDescription FROM ScheduleDetails_GEA SDG
	INNER JOIN componentinformation C ON C.componentid=SDG.MaterialID
	WHERE ProductionOrder=@ProductionOrderNo AND MaterialID=@PartNo
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	AND Machineid=@MachineID AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='') 

	SELECT A1.ID,A1.NcNo,A1.PartName,A1.PartNo,A1.ProductionOrderNo,ISNULL(A1.GrnNo,'') AS GrnNo,A1.BatchNo,A1.GrnNo,A1.Date,A1.Supplier,A1.ReceivedQty,A1.NCQty,A1.Reason1,A1.Reason2,A1.Reason3,A1.Reason4,A1.Reason5,A1.Details,A1.ImagePath1,A1.ImagePath2,
	A1.Rework,A1.Acceptance,A1.Rejected,A2.Name AS QASign, A1.SignDate,A1.Place,A1.Confirmation,A1.MachineID FROM NonConformanceReportDetails_GEA A1
	LEFT JOIN employeeinformation A2 ON A1.QASign=A2.Employeeid
	WHERE (PartNo=@PartNo OR ISNULL(@PartNo,'')='')
	AND (ProductionOrderNo=@ProductionOrderNo OR ISNULL(@ProductionOrderNo,'')='')
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	AND Machineid=@MachineID AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')
END

IF @Param='Save'
BEGIN
IF @NcNo=''
BEGIN
DECLARE @NcNumber NVARCHAR(50)
DECLARE @ddmmyy NVARCHAR(50)
SELECT @NcNumber=(SELECT ISNULL(MAX(CAST((SUBSTRING(NcNo,CHARINDEX('-',NcNo)+1,LEN(NcNo) - 23)) AS INT)),0) FROM NonConformanceReportDetails_GEA WHERE DATEPART(YEAR,date)=DATEPART(YEAR,@Date) AND (Date>'2022-01-01 06:00:00.00'))
SELECT @ddmmyy=(SELECT RIGHT('0' + RTRIM(DATEPART(DAY,@Date)), 2)+''+ RIGHT('0' + RTRIM(DATEPART(MONTH,@Date)), 2)+''+RIGHT(DATEPART(YEAR,@Date),4))
SELECT @NcNumber=CAST(@NcNumber as int)+1
select @NcNumber=(select replicate('0',3-LEN(@NcNumber)) + CONVERT(VARCHAR,@NcNumber))
select @NcNumber=@ddmmyy+'-'+@NcNumber+'-'+@PartNo
end

	IF not exists(select * from NonConformanceReportDetails_GEA where ProductionOrderNo=@ProductionOrderNo and PartNo=@PartNo  and ID=@ID and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') )
	BEGIN
		INSERT INTO NonConformanceReportDetails_GEA(NcNo,PartName,PartNo,ProductionOrderNo,BatchNo,GrnNo,[Date],Supplier,ReceivedQty,NCQty,Reason1,Reason2,Reason3,Reason4,Reason5,Details,ImagePath1,ImagePath2,Rework,Acceptance,Rejected,
		QASign,SignDate,Place,Confirmation,MachineID)
		Values(@NcNumber,@PartName,@PartNo,@ProductionOrderNo,@BatchNo,@GrnNo,@Date,@Supplier,@ReceivedQty,@NCQty,@Reason1,@Reason2,@Reason3,@Reason4,@Reason5,@Details,@ImagePath1,@ImagePath2,@Rework,@Acceptance,@Rejected,
		@QASign,@SignDate,@Place,@Confirmation,@MachineID)
		print 'inserted Successfully'

	END
	ELSE
	BEGIN
		Update NonConformanceReportDetails_GEA set  PartName=@PartName, BatchNo=@BatchNo, [Date]=@Date, Supplier=@Supplier, ReceivedQty=@ReceivedQty, NCQty=@NCQty, Reason1=@Reason1,
			Reason2=@Reason2, Reason3=@Reason3, Reason4=@Reason4, Reason5=@Reason5, Details=@Details, ImagePath1=@ImagePath1,ImagePath2=@ImagePath2, Rework=@Rework, Acceptance=@Acceptance, Rejected=@Rejected, QASign=@QASign,
			SignDate=@SignDate, Place=@Place, Confirmation=@Confirmation
		where ProductionOrderNo=@ProductionOrderNo and PartNo=@PartNo  and ID=@ID and MachineID=@MachineID AND NcNo=@NcNo AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
		print 'Updated Successfully'


	END
END
END
/****** Object:  Procedure [dbo].[S_GetDeviationReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[dbo].[S_GetDeviationReportDetails_GEA] @Param=N'View'
exec [S_GetDeviationReportDetails_GEA] @Param=N'Save',@ID=0,@Confirmation=1,@PartNo=N'8442-6542-030',
@ProductionOrderNo=N'123123',@JobCardNo=N'678',@DevRequestedBy=N'YES',@Signature=N'naik.ya',@GrnNo=N'8989222',
@Date=N'2021-12-27 14:20:57',@Supplier=N'GEA',@Inhouse=N'1',@DeviationQty=N'1',@ReceivedQty=N'10',@Visual=0,@Dimensional=0,@Material=0,
@Process=0,@Other=0,@Permanent=0,@DeviationDescription=default,@Negligible=0,@Minor=0,@Moderate=0,@Major=0,@Functional=0,@Severe=0,
@EffectDescription=default,@RootCause=default,@CorrectiveAction=default,@PreventiveAction=default,@DeviationApproved=0,@DeviationNotApproved=0,
@QAHead=N'',@TechnicalHead=N'',@QASign=N'naik.ya',@SignDate=N'2021-12-27 14:04:57',@MachineID=N'Quality Incoming'
*/
CREATE Procedure [dbo].[S_GetDeviationReportDetails_GEA]
@ID bigint=0,
@Date datetime='',
@PartName nvarchar(50)='',
@PartNo nvarchar(50)='',
@ProductionOrderNo nvarchar(50)='',
@GrnNo nvarchar(50)='',
@JobCardNo nvarchar(50)='',
@DevRequestedBy nvarchar(50)='',
@Signature nvarchar(50)='',
@Supplier nvarchar(50)='',
@Inhouse nvarchar(50)='',
@DeviationQty nvarchar(20)='',
@ReceivedQty nvarchar(20)='',
@Visual bit=0,
@Dimensional bit=0,
@Material bit=0,
@Functional bit=0,
@Process bit=0,
@Other bit=0,
@Permanent bit=0,
@DeviationDescription nvarchar(200)='',
@Negligible bit=0,
@Minor bit=0,
@Moderate bit=0,
@Major bit=0,
@Severe bit=0,
@EffectDescription nvarchar(200)='',
@RootCause nvarchar(200)='',
@CorrectiveAction nvarchar(200)='',
@PreventiveAction nvarchar(200)='',
@DeviationApproved bit=0,
@DeviationNotApproved bit=0,
@QAHead nvarchar(100)='',
@TechnicalHead nvarchar(100)='',
@QASign nvarchar(50)='',
@SignDate datetime='',
@Place nvarchar(50)='',
@Confirmation int=0,
@MachineID nvarchar(50)='',

@Param nvarchar(50)=''

AS
BEGIN

IF @Param='View'
BEGIN
	select SDG.*,substring(C.description,charindex('[',C.description,2)+1,len(C.description)-charindex(']',C.description)-2) as ModelDescription,GrnNo,Supplier from ScheduleDetails_GEA SDG
	inner join componentinformation C on C.componentid=SDG.MaterialID
	where ProductionOrder=@ProductionOrderNo and MaterialID=@PartNo
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	and Machineid=@MachineID AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

	SELECT * INTO #Temp FROM DeviationReportDetails_GEA
	WHERE (PartNo=@PartNo OR ISNULL(@PartNo,'')='')
	AND (ProductionOrderNo=@ProductionOrderNo OR ISNULL(@ProductionOrderNo,'')='')
	--and (Machineid=@MachineID and isnull(@MachineID,'')='')
	AND Machineid=@MachineID AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='')

	UPDATE #Temp SET [Signature]=T1.Name
	FROM(
	SELECT DISTINCT A1.[Signature],A2.Name FROM #Temp A1
	LEFT JOIN employeeinformation A2 ON A1.[Signature]=A2.Employeeid
	)T1 INNER JOIN #Temp T2 ON T1.[Signature]=T2.[Signature]

	UPDATE #Temp SET QAHead=T1.Name
	FROM(
	SELECT DISTINCT A1.QAHead,A2.Name FROM #Temp A1
	LEFT JOIN employeeinformation A2 ON A1.QAHead=A2.Employeeid
	)T1 INNER JOIN #Temp T2 ON T1.QAHead=T2.QAHead

	UPDATE #Temp SET TechnicalHead=T1.Name
	FROM(
	SELECT DISTINCT A1.TechnicalHead,A2.Name FROM #Temp A1
	LEFT JOIN employeeinformation A2 ON A1.TechnicalHead=A2.Employeeid
	)T1 INNER JOIN #Temp T2 ON T1.TechnicalHead=T2.TechnicalHead

	UPDATE #Temp SET QASign=T1.Name
	FROM(
	SELECT DISTINCT A1.QASign,A2.Name FROM #Temp A1
	LEFT JOIN employeeinformation A2 ON A1.QASign=A2.Employeeid
	)T1 inner join #Temp T2 on T1.QASign=T2.QASign

	select * from #Temp
END

IF @Param='Save'
BEGIN
declare @DevNo nvarchar(50)
SELECT @DevNo=(select TOP(1) isnull(devno,'') as devno from DeviationReportDetails_GEA where MachineID=@MachineID and ProductionOrderNo=@ProductionOrderNo and PartNo=@PartNo AND ((ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')) OR ISNULL(@GrnNo,'')='') ORDER BY DATE DESC)

if isnull(@DevNo,'')=''
begin
declare  @DevNumber nvarchar(50)
declare @ddmmyy nvarchar(50)
select @DevNumber=(select isnull(max(cast((substring(devno,CHARINDEX('-',devno)+1,len(devno) - 23)) as int)),0) from DeviationReportDetails_GEA where datepart(year,date)=datepart(year,@Date) and (Date>'2022-01-01 06:00:00.00'))
select @ddmmyy=(SELECT RIGHT('0' + RTRIM(datepart(day,@Date)), 2)+''+ RIGHT('0' + RTRIM(datepart(month,@Date)), 2)+''+right(datepart(year,@Date),4))
select @DevNumber=cast(@DevNumber as int)+1
select @DevNumber=(select replicate('0',4-LEN(@DevNumber)) + CONVERT(VARCHAR,@DevNumber))
select @DevNumber=@ddmmyy+'-'+@DevNumber+'-'+@PartNo
end

	IF not exists(select * from DeviationReportDetails_GEA where ProductionOrderNo=@ProductionOrderNo and PartNo=@PartNo AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'') and ID=@ID and MachineID=@MachineID)
	BEGIN
		INSERT INTO DeviationReportDetails_GEA([Date],PartName,PartNo,ProductionOrderNo,GrnNo,JobCardNo,DevRequestedBy,[Signature],Supplier,Inhouse,DeviationQty,ReceivedQty,Visual,Dimensional,Material,Functional,
		Process,Other,Permanent,DeviationDescription,Negligible,Minor,Moderate,Major,Severe,EffectDescription,RootCause,CorrectiveAction,PreventiveAction,DeviationApproved,DeviationNotApproved,QAHead,TechnicalHead,
		QASign,SignDate,Place,Confirmation,MachineID,DevNo)
		Values(@Date,@PartName,@PartNo,@ProductionOrderNo,@GrnNo,@JobCardNo,@DevRequestedBy,@Signature,@Supplier,@Inhouse,@DeviationQty,@ReceivedQty,@Visual,@Dimensional,@Material,@Functional,@Process,@Other,@Permanent,
		@DeviationDescription,@Negligible,@Minor,@Moderate,@Major,@Severe,@EffectDescription,@RootCause,@CorrectiveAction,@PreventiveAction,@DeviationApproved,@DeviationNotApproved,@QAHead,@TechnicalHead,@QASign,
		@SignDate,@Place,@Confirmation,@MachineID,@DevNumber)
	END
	ELSE
	BEGIN
		Update DeviationReportDetails_GEA Set [Date]=@Date, PartName=@PartName, JobCardNo=@JobCardNo, DevRequestedBy=@DevRequestedBy, [Signature]=@Signature, Supplier=@Supplier,
			Inhouse=@Inhouse, DeviationQty=@DeviationQty, ReceivedQty=@ReceivedQty, Visual=@Visual, Dimensional=@Dimensional, Material=@Material, Functional=@Functional, Process=@Process,
			Other=@Other, Permanent=@Permanent, DeviationDescription=@DeviationDescription, Negligible=@Negligible, Minor=@Minor, Moderate=@Moderate, Major=@Major, Severe=@Severe, EffectDescription=@EffectDescription,
			RootCause=@RootCause, CorrectiveAction=@CorrectiveAction, PreventiveAction=@PreventiveAction, DeviationApproved=@DeviationApproved, DeviationNotApproved=@DeviationNotApproved, QAHead=@QAHead, TechnicalHead=@TechnicalHead,
			QASign=@QASign, SignDate=@SignDate, Place=@Place, Confirmation=@Confirmation,DevNo=@DevNo
		where ProductionOrderNo=@ProductionOrderNo and PartNo=@PartNo and ID=@ID and MachineID=@MachineID AND ISNULL(GrnNo,'')=ISNULL(@GrnNo,'')
	END
END
	
END
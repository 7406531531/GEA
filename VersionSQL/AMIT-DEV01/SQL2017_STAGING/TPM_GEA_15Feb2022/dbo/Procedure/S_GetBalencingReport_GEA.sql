/****** Object:  Procedure [dbo].[S_GetBalencingReport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[S_GetBalencingReport_GEA] '','','',''
*/

CREATE PROCEDURE [dbo].[S_GetBalencingReport_GEA]
@Component nvarchar(50)='',
@ProductionNo nvarchar(50)='',
@FabricationNo nvarchar(50)='',
@param nvarchar(50)=''
as
begin
if @param='View1'
begin
select component,Param1,Tol_g,R_mm,Dim_mm,ISO,uNIT,Param2 from [BalancingReportComponentMaster]
where component=@Component
end
if @param='View2'
begin
select ScrollNumber,ProductionNo,FabricationNo,MeasuringSpeed,SelectedDateAndTime,Model,P1_a,P1_b,P2_a,P2_b,Operator,E.Name, AddingChecked,RemovingChecked,ConfirmedDateAndTime,Confirmed from [BalancingReportTransaction]
LEFT OUTER JOIN employeeinformation E ON E.Employeeid=[BalancingReportTransaction].Operator where Productionno=@ProductionNo AND FabricationNo=@FabricationNo
end
end
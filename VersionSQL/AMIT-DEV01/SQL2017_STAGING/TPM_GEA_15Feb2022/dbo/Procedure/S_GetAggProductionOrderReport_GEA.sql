/****** Object:  Procedure [dbo].[S_GetAggProductionOrderReport_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[dbo].[S_GetAggProductionOrderReport_GEA]  '','','2020-07-01 07:00:00','2020-07-30 23:00:00',''
[dbo].[S_GetAggProductionOrderReport_GEA]  '','','2020-08-01 07:00:00','2020-08-30 23:00:00',''

*/
CREATE Procedure [dbo].[S_GetAggProductionOrderReport_GEA]
@PlantID nvarchar(50)='',
@GroupID nvarchar(50)='',
@StartTime datetime='',
@EndTime datetime='',
@Param nvarchar(50)=''

AS
BEGIN

SET NOCOUNT ON;

Declare @strPlantID as nvarchar(255)  
Declare @strGroupID as nvarchar(255) 
Declare @strDPlantID as nvarchar(255)  
Declare @strDGroupID as nvarchar(255) 
Declare @strSql as nvarchar(4000) 


SELECT @strPlantID = '' 
SELECT @strGroupID = '' 

SELECT @strDPlantID = '' 
SELECT @strDGroupID = '' 

 If isnull(@PlantID,'') <> ''        
 Begin        
  Select @StrPlantID = ' And ( ShiftProductionDetails.PlantID = N''' + @PlantID + ''' )'        
 End   

If isnull(@Groupid,'') <> ''  
Begin  
 Select @StrGroupid = ' And ( ShiftProductionDetails.GroupID = N''' + @GroupID + ''')'  
End 

Create Table #Temp
(
	 WorkOrderNumber nvarchar(50),
	 ComponentID nvarchar(50),
	 ProdCount float DEFAULT 0,   
	 Qty float default 1,
	 AcceptedParts Int DEFAULT 0,        
	 RejCount  float DEFAULT 0,        
	 ReworkPerformed Int DEFAULT 0,        
	 MarkedForRework Int DEFAULT 0,        
	 AEffy  Float DEFAULT 0,        
	 PEffy  Float DEFAULT 0,        
	 QEffy  Float DEFAULT 0,        
	 OEffy  Float DEFAULT 0,        
	 UtilisedTime  Float DEFAULT 0,        
	 DownTime  Float DEFAULT 0,        
	 CN  Float DEFAULT 0,        
	 ManagementLoss float default 0,        
	 FinishOprCycleEnd datetime,
	 ListOfCompletedOpr nvarchar(250)
)

CREATE TABLE #Temp2(
	WorkOrderNumber nvarchar(50),
	OperationNo nvarchar(50)
)

INSERT INTO #Temp2(WorkOrderNumber,OperationNo)
select distinct WorkOrderNumber,OperationNo from ShiftProductionDetails

SET @strSql = ''    
SELECT @strSql = 'INSERT INTO #Temp(WorkOrderNumber,ComponentID)
				select distinct WorkOrderNumber,ComponentID from ShiftProductionDetails
				inner join machineinformation on ShiftProductionDetails.MachineID=machineinformation.machineid ' 
select @strsql = @strsql + ' where machineinformation.interfaceid > ''0'' '
select @strsql = @strsql + ' and ( pDate >= '''+ Convert(nvarchar(20),@StartTime,120)+''' and pDate <= '''+Convert(nvarchar(20),@EndTime,120)+''' )  '
select @strsql = @strsql + ' AND ShiftProductionDetails.FinishedOperation=1 '
select @strsql = @strsql + @StrPlantID + @strGroupID
print @strsql
exec (@strsql)

Select @Strsql = 'Update #Temp Set ProdCount=ISNULL(T2.ProdCount,0),AcceptedParts=ISNULL(T2.AcceptedParts,0),'        
 Select @Strsql = @Strsql+ 'ReworkPerformed=ISNULL(T2.Rework_Performed,0),MarkedForRework=ISNULL(T2.MarkedForRework,0),UtilisedTime=ISNULL(T2.UtilisedTime,0),CN=ISNULL(T2.CN,0)'        
 Select @Strsql = @Strsql+ ' From('        
 Select @Strsql = @Strsql+ ' Select T1.WorkOrderNumber,Sum(ISNULL(ShiftProductionDetails.Prod_Qty,0))ProdCount,
						Sum(ISNULL(ShiftProductionDetails.AcceptedParts,0))AcceptedParts,         
						Sum(ISNULL(ShiftProductionDetails.Rework_Performed,0))AS Rework_Performed,
						Sum(ISNULL(ShiftProductionDetails.Marked_For_Rework,0)) AS MarkedForRework,
						Sum(ShiftProductionDetails.Sum_of_ActCycleTime)As UtilisedTime  ,
						sum(ShiftProductionDetails.Prod_Qty *(ShiftProductionDetails.CO_StdMachiningTime+ShiftProductionDetails.CO_StdLoadUnload)) AS CN 
                             From ShiftProductionDetails inner Join #Temp T1 on  T1.WorkOrderNumber=ShiftProductionDetails.WorkOrderNumber'       
 Select @Strsql = @Strsql+ ' where 1=1 '        
 Select @Strsql = @Strsql+  @StrPlantID  + @StrGroupid       
 Select @Strsql = @Strsql+ ' GROUP By T1.WorkOrderNumber ) AS T2 inner join #Temp on T2.WorkOrderNumber = #Temp.WorkOrderNumber '        
 Print @Strsql        
 Exec(@Strsql)         
        
 Select @Strsql = 'UPDATE #Temp SET RejCount=ISNULL(T2.Rej,0)'        
 Select @Strsql = @Strsql+' FROM('        
 Select @Strsql = @Strsql+' Select T1.WorkOrderNumber,Sum(isnull(ShiftRejectionDetails.Rejection_Qty,0))as Rej'        
 Select @Strsql = @Strsql+' From ShiftProductionDetails inner Join #Temp T1 on T1.WorkOrderNumber=ShiftProductionDetails.WorkOrderNumber         
							Left Outer Join ShiftRejectionDetails ON ShiftProductionDetails.ID=ShiftRejectionDetails.ID'        
 Select @Strsql = @Strsql+' Where 1=1  '        
 Select @Strsql = @Strsql+  @StrPlantID + @StrGroupid        
Select @Strsql = @Strsql+ ' GROUP By T1.WorkOrderNumber ) AS T2 inner join #Temp on T2.WorkOrderNumber = #Temp.WorkOrderNumber '            
 Print @Strsql        
 Exec(@Strsql)        
        
        
 --Select @Strsql = 'Update #Temp Set CN=ISNULL(T2.CN,0)'        
 --Select @Strsql = @Strsql + ' From ('        
 --Select @Strsql = @Strsql + ' Select T1.WorkOrderNumber,sum(ShiftProductionDetails.Prod_Qty *(ShiftProductionDetails.CO_StdMachiningTime+ShiftProductionDetails.CO_StdLoadUnload)) AS CN '        
 --Select @Strsql = @Strsql + ' From ShiftProductionDetails inner Join #Temp T1 on T1.WorkOrderNumber=ShiftProductionDetails.WorkOrderNumber'        
 --Select @Strsql = @Strsql + ' where  ( pDate >= '''+ Convert(nvarchar(20),@StartTime,120)+''' and pDate <= '''+Convert(nvarchar(20),@EndTime,120)+''' ) '
 --Select @Strsql = @Strsql+  @StrPlantID + @StrGroupid        
 --Select @Strsql = @Strsql+ ' GROUP By T1.WorkOrderNumber ) AS T2 inner join #Temp on T2.WorkOrderNumber = #Temp.WorkOrderNumber '            
 --Print @Strsql        
 --Exec(@Strsql)  
 
 If isnull(@PlantID,'') <> ''        
 Begin        
  Select @StrDPlantID = ' And ( ShiftDownTimeDetails.PlantID = N''' + @PlantID + ''' )'        
 End   
    
If isnull(@Groupid,'') <> ''  
Begin  
 Select @StrDGroupid = ' And ( ShiftDownTimeDetails.GroupID = N''' + @GroupID + ''')'  
End 


 Select @Strsql =''        
 SELECT @StrSql='UPDATE #Temp SET UtilisedTime = Isnull(#Temp.UtilisedTime,0)+IsNull(T2.MinorDownTime,0) '        
 Select @Strsql = @Strsql+ 'From (SELECT T1.WorkOrderNumber,sum(datediff(s,starttime,endtime)) as MinorDownTime FROM ShiftDownTimeDetails
							inner Join #Temp T1 on T1.WorkOrderNumber=ShiftDownTimeDetails.WorkOrderNumber'        
 Select @Strsql = @Strsql+ ' WHERE ShiftDownTimeDetails.downid in (select downid from downcodeinformation where prodeffy = 1)'
 Select @Strsql = @Strsql+  @StrDPlantID  + @StrDGroupid       
 Select @Strsql = @Strsql+ ' Group By T1.WorkOrderNumber'
 Select @Strsql = @Strsql+ ') as T2 Inner Join #Temp on T2.WorkOrderNumber = #Temp.WorkOrderNumber '             
 print @StrSql        
 EXEC(@StrSql)       

        
 Select @Strsql = 'UPDATE #Temp SET DownTime = IsNull(T2.DownTime,0)'        
 Select @Strsql = @Strsql + ' From (select T1.WorkOrderNumber,(Sum(ShiftDowntimeDetails.DownTime))As DownTime'        
 Select @Strsql = @Strsql + ' From ShiftDownTimeDetails Inner Join  #Temp T1 on T1.WorkOrderNumber=ShiftDownTimeDetails.WorkOrderNumber      
							where  1=1  '        
 Select @Strsql = @Strsql+  @StrDPlantID + @StrDGroupid       
 Select @Strsql = @Strsql + ' Group By T1.WorkOrderNumber'
 Select @Strsql = @Strsql + ' ) AS T2 Inner Join #Temp on T2.WorkOrderNumber = #Temp.WorkOrderNumber '               
 Print @Strsql        
 Exec(@Strsql)         
        
         
 Select @Strsql = 'UPDATE #Temp SET ManagementLoss =  isNull(T2.loss,0)'        
 Select @Strsql = @Strsql + 'from (select T1.WorkOrderNumber, sum(        
   CASE         
  WHEN (ShiftDownTimeDetails.DownTime) > isnull(ShiftDownTimeDetails.Threshold,0) and isnull(ShiftDownTimeDetails.Threshold,0) > 0          
  THEN isnull(ShiftDownTimeDetails.Threshold,0)        
  ELSE ShiftDownTimeDetails.DownTime        
   END) AS LOSS '        
 Select @Strsql = @Strsql + ' From ShiftDownTimeDetails inner JOIN  #Temp T1 on T1.WorkOrderNumber=ShiftDownTimeDetails.WorkOrderNumber  where ML_flag = 1 '
 Select @Strsql = @Strsql+  @StrDPlantID + @StrDGroupid        
 Select @Strsql = @Strsql + ' Group By T1.WorkOrderNumber'        
 Select @Strsql = @Strsql + ' ) AS T2 Inner Join #Temp on T2.WorkOrderNumber = #Temp.WorkOrderNumber '      
 Print @Strsql        
 Exec(@Strsql)         
         
 UPDATE #Temp SET DownTime=DownTime-ManagementLoss            
        
        
 UPDATE #Temp SET QEffy=CAST((AcceptedParts)As Float)/CAST((AcceptedParts+RejCount+MarkedForRework) AS Float)        
 Where CAST((AcceptedParts+RejCount+MarkedForRework) AS Float) <> 0        
        
 UPDATE #Temp        
 SET        
  PEffy = (CN/UtilisedTime) ,        
  AEffy = (UtilisedTime)/(UtilisedTime + ISNULL( DownTime,0))        
 WHERE UtilisedTime <> 0   
 

 UPDATE #Temp        
 SET            
  OEffy =  (PEffy * AEffy * ISNULL(QEffy,1))*100,
  PEffy = PEffy * 100 ,        
  AEffy = AEffy * 100,        
  QEffy = QEffy * 100        

 
--Update #Temp set FinishOprCycleEnd=ISNULL(T1.FinishOprCycleEnd,0)
--from (
--SELECT ShiftProductionDetails.WorkOrderNumber,max(pDate) as FinishOprCycleEnd from ShiftProductionDetails
--inner join #Temp on #Temp.WorkOrderNumber=ShiftProductionDetails.WorkOrderNumber
--where ( pDate >= @StartTime and pDate <=@EndTime )
--Group by ShiftProductionDetails.WorkOrderNumber
--)T1 inner join #Temp T2 on T1.WorkOrderNumber=T2.WorkOrderNumber

Update #Temp set FinishOprCycleEnd=ISNULL(T1.FinishOprCycleEnd,0)
from (
SELECT autodata.WorkOrderNumber,max(ndtime) as FinishOprCycleEnd from  autodata
inner join #Temp on #Temp.WorkOrderNumber=autodata.WorkOrderNumber
where autodata.datatype=1
Group by autodata.WorkOrderNumber
)T1 inner join #Temp T2 on T1.WorkOrderNumber=T2.WorkOrderNumber


--		SELECT DISTINCT ST2.WorkOrderNumber, 
--    SUBSTRING(
--        (
--            SELECT ','+  cast(ST1.OperationNo as nvarchar(20))  AS [text()]
--            FROM ShiftProductionDetails ST1
--            WHERE ST1.WorkOrderNumber = ST2.WorkOrderNumber
--            ORDER BY ST1.WorkOrderNumber
--            FOR XML PATH ('')
--        ), 2, 1000) [ShiftProductionDetails]
--FROM ShiftProductionDetails ST2

update #Temp set ListOfCompletedOpr=T1.OperationNo
From(
SELECT Main.WorkOrderNumber,
       LEFT(Main.OperationNo,Len(Main.OperationNo)-1) As "OperationNo"
FROM
    (
        SELECT DISTINCT ST2.WorkOrderNumber, 
            (
                SELECT  cast(ST1.OperationNo as nvarchar(20)) + ',' 
                FROM #Temp2 ST1
                WHERE ST1.WorkOrderNumber = ST2.WorkOrderNumber
                ORDER BY ST1.WorkOrderNumber
                FOR XML PATH ('')
            ) [OperationNo]
        FROM ShiftProductionDetails ST2
    ) [Main]
)T1 inner join #Temp T2 on T1.WorkOrderNumber=T2.WorkOrderNumber


SElect WorkOrderNumber as PoNumber,ComponentID as PartNumber, Qty,RejCount as Rejection,round(OEffy,2) as OEE,
dbo.f_FormatTime(UtilisedTime,'hh:mm:ss') as UtilisedTime,
FinishOprCycleEnd,ListOfCompletedOpr from #Temp

SELECT Sum(cast(Qty as float)) as TotalQty, Sum(cast(RejCount as float)) as TotalRejection, round(Avg(cast(OEffy as float)),2) as AvgOEE from #Temp

END
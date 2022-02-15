/****** Object:  Procedure [dbo].[S_GetSPCcontrolReports_Renishaw]    Committed by VersionSQL https://www.versionsql.com ******/

/*
[dbo].[S_GetSPCcontrolReports_Renishaw] '2019-12-19 16:25:46','2019-12-30 16:25:46','vmc','35','110','''Perpendicularity_0_05_WRT_C_M1'',''Diameter_Datum_H_Above_dia_30''',''

*/
CREATE PROCEDURE [dbo].[S_GetSPCcontrolReports_Renishaw]
@StartDate datetime='',
@EndDate datetime='',
@Machine nvarchar(50)='',
@Component nvarchar(50)='',
@Operation nvarchar(50)='',
--@Dimension nvarchar(50)='',
@CharacteristicID nvarchar(max)='',
@Param nvarchar(50)	 = ''

AS
BEGIN

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

CREATE TABLE #Target
(
Date datetime,
Employee nvarchar(50),
Machine nvarchar(50),
SerialNumber nvarchar(50),
Component nvarchar(50),
Operation nvarchar(50),
CharacteristicID nvarchar(50),
Value float
)

Declare @StrCharId nvarchar(max)
declare @strsql nvarchar(4000)

 If isnull(@CharacteristicID,'') <> ''  
Begin  
 Select @StrCharId = ' And ( S.CharacteristicID in (' + @CharacteristicID + '))'  
End 

set @strsql=''
select @strsql = @strsql + 'INSERT INTO #Target (Date,Employee,Machine,SerialNumber,Component,Operation,CharacteristicID,Value)
select A.Timestamp,A.Opr,A.mc,A.SerialNumber, A.Comp, A.Opn, S.CharacteristicID ,A.Value from SPCAutodata A
inner join machineinformation M on M.machineid=A.Mc
inner join SPC_Characteristic S on A.Comp=S.ComponentID and A.Opn=S.OperationNo and A.Dimension=S.CharacteristicCode'
select @strsql = @strsql + ' where Comp = '''+@Component+''' and Opn = ''' +@Operation+ ''' and M.machineid = '''+@Machine+''' 
and (A.Timestamp >= ''' + convert(nvarchar(25),@StartDate,120) + ''' and A.Timestamp <= ''' + convert(nvarchar(25),@EndDate,120) + ''')'
select @strsql = @strsql + @StrCharId
print @strsql
exec (@strsql)

--select * from #Target

IF exists(select * from #Target)
BEGIN
Declare 
@columns NVARCHAR(MAX) = '',
@sql     NVARCHAR(MAX) = '';

SELECT @columns = @columns + QUOTENAME(T.CharacteristicID) + ',' FROM #Target T group by T.CharacteristicID
SET @columns = LEFT(@columns, LEN(@columns) - 1);

print @columns

set @sql = ''
SET @sql ='
SELECT Date,Employee,Machine,SerialNumber,Component,Operation,'+ @columns +' FROM   
(
SELECT Date,Employee,Machine,SerialNumber,Component,Operation,CharacteristicID,Value as s1
FROM #Target 
) AS t 
PIVOT(max(s1) FOR CharacteristicID IN ('+ @columns + ')) AS pivot_table'

EXECUTE sp_executesql @sql;

END
END
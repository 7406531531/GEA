/****** Object:  Procedure [dbo].[S_GetCOSchedule]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[S_GetCOSchedule] 'MCV 320'
CREATE PROCEDURE [dbo].[S_GetCOSchedule] 
@Machineid nvarchar(50),
@Componentid nvarchar(50)='',
@Operationid nvarchar(50)=''

AS
BEGIN

-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.

SET NOCOUNT ON;

If ISNULL(@Componentid,'')<>'' and ISNULL(@Operationid,'')<>''
Begin
Delete From MO Where Machineid=@Machineid

insert into MO(MachineID,PartID,OperationNo)
Select @Machineid,@Componentid,@Operationid
End

Select MO.PartID as Componentid,MO.OperationNo,COP.Machiningtime as StdCycletime,(COP.cycletime-COP.machiningtime) as StdLoadunloadTime From componentoperationpricing COP
inner join MO on COP.Machineid=MO.Machineid and COP.Componentid=MO.PartID and COP.OperationNo=MO.OperationNo
Where MO.Machineid=@Machineid 

Select Distinct COP.Componentid,COP.OperationNo,COP.Machiningtime as StdCycletime,(COP.cycletime-COP.machiningtime) as StdLoadunloadTime,CI.InterfaceID as CompInterfaceID, cop.InterfaceID as OpnInterfaceID From componentoperationpricing COP
inner join Componentinformation CI ON CI.Componentid=COP.Componentid
inner join Machineinformation M on COP.Machineid=M.Machineid
Where COP.Machineid=@Machineid 
and NOT EXISTS (Select Machineid,PartID,OperationNo from MO Where COP.Machineid=MO.Machineid and COP.Componentid=MO.PartID and COP.OperationNo=MO.OperationNo)
Order by COP.Componentid

END
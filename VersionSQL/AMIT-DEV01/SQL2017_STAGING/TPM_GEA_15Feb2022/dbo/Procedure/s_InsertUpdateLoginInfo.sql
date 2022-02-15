/****** Object:  Procedure [dbo].[s_InsertUpdateLoginInfo]    Committed by VersionSQL https://www.versionsql.com ******/

--[dbo].[s_InsertUpdateLoginInfo] 'CNC-02','','','','','view'
CREATE PROCEDURE [dbo].[s_InsertUpdateLoginInfo]
@machine nvarchar(50)='',
@DeviceName nvarchar(4000)='',
@Message nvarchar(1000)='',
@FormBackground nvarchar(50)='',
@GridHeaderBackGround nvarchar(50)='',
@param nvarchar(50)='',
@Type nvarchar(50)=''
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

If @Type=''
Begin

--If Not exists(Select * from machineinformation where machineid=@machine and Nonmachining=1) --Commented and added Parameter @Type
--BEGIN

if @param='Save'
BEGIN
if exists(select * from dbo.LoginInfo_Trelleborg where Machine=@Machine)
BEGIN
update LoginInfo_Trelleborg set DeviceName=@DeviceName,[Message]=@Message,[FormBackground]=@FormBackground,[GridHeaderBackground]=@GridHeaderBackGround,[default]=1 where Machine=@Machine
END
Else
BEGIN
insert into LoginInfo_Trelleborg(DeviceName,Machine,[Message],[FormBackground],[GridHeaderBackground],[Default])
select @DeviceName,@Machine,@Message,@FormBackground,@GridHeaderBackGround,'1'
END
END

if @param='View'
BEGIN
select Machine,DeviceName,[Message],[FormBackground],[GridHeaderBackground] from dbo.LoginInfo_Trelleborg
END
END

If @Type='NonMachining'
Begin

--If exists(Select * from machineinformation where machineid=@machine and Nonmachining=1) --Commented and added Parameter @Type
--BEGIN
if @param='Save'
BEGIN
if exists(select * from dbo.LoginInfo_NonMachining_GEA where Machine=@Machine)
BEGIN
update LoginInfo_NonMachining_GEA set DeviceName=@DeviceName,[Message]=@Message,[FormBackground]=@FormBackground,[GridHeaderBackground]=@GridHeaderBackGround,[default]=1 where Machine=@Machine
END
Else
BEGIN
insert into LoginInfo_NonMachining_GEA(DeviceName,Machine,[Message],[FormBackground],[GridHeaderBackground],[Default])
select @DeviceName,@Machine,@Message,@FormBackground,@GridHeaderBackGround,'1'
END
END

if @param='View'
BEGIN
select Machine,DeviceName,[Message],[FormBackground],[GridHeaderBackground] from dbo.LoginInfo_NonMachining_GEA
END
END

END
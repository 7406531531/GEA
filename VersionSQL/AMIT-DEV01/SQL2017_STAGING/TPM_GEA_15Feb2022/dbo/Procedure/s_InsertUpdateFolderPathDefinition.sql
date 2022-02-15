/****** Object:  Procedure [dbo].[s_InsertUpdateFolderPathDefinition]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[s_InsertUpdateFolderPathDefinition]
@FolderType nvarchar(1000)='',
@FolderPath nvarchar(4000)='',
@FolderExtension nvarchar(100)='',
@param nvarchar(50)=''
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;


if @param='Save'
BEGIN
if exists(select * from [dbo].[FolderPathDefinition] where [FolderType]=@FolderType)
BEGIN
update [FolderPathDefinition] set [FileExtension]=isnull(@FolderExtension,[FileExtension]),[FolderPath]=@FolderPath where FolderType=@FolderType
END
Else
BEGIN
insert into [FolderPathDefinition]([FolderPath],FolderType,[FileExtension])
select @FolderPath,@FolderType,@FolderExtension
END
END


if @param='View'
BEGIN
select distinct [FolderType],[FolderPath],[FileExtension] from [dbo].[FolderPathDefinition]
END

if @param='SaveNonMachining'
BEGIN
if exists(select * from [dbo].[FolderPathDefinition_NonMachining] where [FolderType]=@FolderType)
BEGIN
update [dbo].[FolderPathDefinition_NonMachining] set [FileExtension]=isnull(@FolderExtension,[FileExtension]),[FolderPath]=@FolderPath where FolderType=@FolderType
END
Else
BEGIN
insert into [dbo].[FolderPathDefinition_NonMachining]([FolderPath],FolderType,[FileExtension])
select @FolderPath,@FolderType,@FolderExtension
END
END


if @param='ViewNonMachining'
BEGIN
select distinct [FolderType],[FolderPath],[FileExtension] from [dbo].[FolderPathDefinition_NonMachining]
END

END
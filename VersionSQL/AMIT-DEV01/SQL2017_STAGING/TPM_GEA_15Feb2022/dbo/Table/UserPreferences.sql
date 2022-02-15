/****** Object:  Table [dbo].[UserPreferences]    Committed by VersionSQL https://www.versionsql.com ******/

/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2017 (14.0.1000)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Express Edition
    Target Database Engine Type : Standalone SQL Server
*/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[UserPreferences](
	[EmployeeId] [nvarchar](50) NULL,
	[ModuleName] [nvarchar](50) NULL,
	[FormName] [nvarchar](50) NULL,
	[ControlName] [nvarchar](50) NULL,
	[Parameter] [nvarchar](50) NULL,
	[ValueInText] [nvarchar](100) NULL
) ON [PRIMARY]
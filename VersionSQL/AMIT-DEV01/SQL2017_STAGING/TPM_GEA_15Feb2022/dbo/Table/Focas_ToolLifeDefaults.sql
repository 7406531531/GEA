/****** Object:  Table [dbo].[Focas_ToolLifeDefaults]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_ToolLifeDefaults](
	[SlNo] [bigint] IDENTITY(1,1) NOT NULL,
	[GroupNumber] [nvarchar](100) NULL,
	[ToolNumber] [nvarchar](100) NULL,
	[DAreaForToolNumberLife] [smallint] NULL,
	[DAreaForToolNumberCount] [smallint] NULL,
	[DAreaForToolLife] [smallint] NULL,
	[DAreaForCount] [smallint] NULL,
	[DareaforReason] [smallint] NULL,
	[DareaforFlagsetting] [smallint] NULL,
	[MacrovariableforDate] [smallint] NULL,
	[Macrovariablefortime] [smallint] NULL,
	[MTB] [nvarchar](50) NULL
) ON [PRIMARY]
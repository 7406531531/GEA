/****** Object:  Table [dbo].[HelpRequestRule]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[HelpRequestRule](
	[PlantId] [nvarchar](50) NOT NULL,
	[HelpCode] [nvarchar](50) NOT NULL,
	[Action] [nvarchar](50) NOT NULL,
	[MobileNo] [nvarchar](1000) NOT NULL,
	[Level2Threshold] [int] NULL,
	[Level2MobNo] [nvarchar](1000) NULL,
	[Message] [nvarchar](500) NULL,
	[SlNo] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineId] [nvarchar](50) NULL,
	[Level3Threshold] [int] NULL,
	[Level3MobNo] [nvarchar](1000) NULL,
	[Threshold] [int] NULL
) ON [PRIMARY]
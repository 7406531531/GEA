/****** Object:  Table [dbo].[ActivityMaster_MGTL]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ActivityMaster_MGTL](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[ActivityID] [int] NOT NULL,
	[Activity] [nvarchar](100) NULL,
	[FreqID] [int] NULL,
	[MachineID] [nvarchar](50) NULL,
	[IsMandatory] [int] NULL,
	[Method] [nvarchar](50) NULL,
	[Criteria] [nvarchar](50) NULL,
	[TemplateType] [nvarchar](500) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[ActivityMaster_MGTL] ADD  DEFAULT ((0)) FOR [IsMandatory]
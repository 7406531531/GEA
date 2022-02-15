/****** Object:  Table [dbo].[HelpCodeDetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[HelpCodeDetails](
	[Plantid] [nvarchar](50) NULL,
	[Machineid] [nvarchar](50) NOT NULL,
	[DataType] [numeric](18, 0) NULL,
	[HelpCode] [nvarchar](50) NOT NULL,
	[Action1] [nvarchar](50) NULL,
	[Action2] [nvarchar](50) NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[Remarks] [nvarchar](500) NULL,
	[CSVSentStatus] [bit] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[HelpCodeDetails] ADD  DEFAULT ((0)) FOR [CSVSentStatus]
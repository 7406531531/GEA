/****** Object:  Table [dbo].[ReworkPerformedSummary_Jina]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ReworkPerformedSummary_Jina](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[mc] [nvarchar](50) NULL,
	[comp] [nvarchar](50) NULL,
	[opn] [nvarchar](50) NULL,
	[opr] [nvarchar](50) NULL,
	[WorkOrderNumber] [nvarchar](50) NULL,
	[ReworkAccepted] [int] NULL,
	[ReworkRejected] [int] NULL,
	[ReworkPerformed] [int] NULL,
	[RejDate] [datetime] NULL,
	[RejShift] [nvarchar](15) NULL,
	[CreatedTS] [datetime] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[ReworkPerformedSummary_Jina] ADD  CONSTRAINT [DF__ReworkPer__Rewor__5F141958]  DEFAULT ((0)) FOR [ReworkAccepted]
ALTER TABLE [dbo].[ReworkPerformedSummary_Jina] ADD  CONSTRAINT [DF__ReworkPer__Rewor__60083D91]  DEFAULT ((0)) FOR [ReworkRejected]
ALTER TABLE [dbo].[ReworkPerformedSummary_Jina] ADD  CONSTRAINT [DF__ReworkPer__Rewor__60FC61CA]  DEFAULT ((0)) FOR [ReworkPerformed]
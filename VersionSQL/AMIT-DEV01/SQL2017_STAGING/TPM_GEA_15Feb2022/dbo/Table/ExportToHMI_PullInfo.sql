/****** Object:  Table [dbo].[ExportToHMI_PullInfo]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ExportToHMI_PullInfo](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[RequestType] [smallint] NOT NULL,
	[RequestedTimeStamp] [datetime] NOT NULL,
	[Status] [smallint] NOT NULL,
	[ServicedTimeStamp] [datetime] NULL,
	[ComponentID] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[ExportToHMI_PullInfo] ADD  CONSTRAINT [DF_ExportToHMI_PullInfo_RequestType]  DEFAULT ((1)) FOR [RequestType]
ALTER TABLE [dbo].[ExportToHMI_PullInfo] ADD  CONSTRAINT [DF_ExportToHMI_PullInfo_RequestedTimeStamp]  DEFAULT (getdate()) FOR [RequestedTimeStamp]
ALTER TABLE [dbo].[ExportToHMI_PullInfo] ADD  CONSTRAINT [DF_ExportToHMI_PullInfo_Status]  DEFAULT ((0)) FOR [Status]
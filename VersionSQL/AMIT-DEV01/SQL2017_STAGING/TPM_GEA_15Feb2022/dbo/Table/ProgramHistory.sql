/****** Object:  Table [dbo].[ProgramHistory]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ProgramHistory](
	[SlNo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[RequestedDateTime] [datetime] NULL,
	[MachineID] [nvarchar](10) NULL,
	[ProgramID] [nvarchar](10) NULL,
	[PortNo] [int] NULL,
	[ServiceProvided] [smallint] NULL,
	[ServiceDateTime] [datetime] NULL,
	[RequestingModuleName] [nvarchar](50) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[ProgramHistory] ADD  CONSTRAINT [DF_ProgramHistory_RequestedDateTimeS]  DEFAULT (getdate()) FOR [RequestedDateTime]
ALTER TABLE [dbo].[ProgramHistory] ADD  CONSTRAINT [DF_ProgramHistory_PortNoS]  DEFAULT ((0)) FOR [PortNo]
ALTER TABLE [dbo].[ProgramHistory] ADD  CONSTRAINT [DF_ProgramHistory_ServiceProvidedS]  DEFAULT ((0)) FOR [ServiceProvided]
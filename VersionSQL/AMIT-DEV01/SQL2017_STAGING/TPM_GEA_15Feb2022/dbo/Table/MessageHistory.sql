/****** Object:  Table [dbo].[MessageHistory]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[MessageHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PC_SerialNo] [nvarchar](50) NULL,
	[RequestedTime] [datetime] NULL,
	[SendTime] [datetime] NULL,
	[MsgStatus] [tinyint] NULL,
	[MobileNo] [nvarchar](500) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Message] [nvarchar](500) NULL,
	[MsgPerEvery] [int] NULL,
	[MachineID] [nvarchar](100) NULL,
	[Alerttype] [nvarchar](10) NULL,
	[Record_sttime] [datetime] NULL,
	[Record_ndtime] [datetime] NULL,
	[ShiftID] [int] NULL,
	[ActionNo] [nvarchar](10) NULL,
	[HelpCode] [nvarchar](10) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[MessageHistory] ADD  CONSTRAINT [DF__MessageHi__Alert__188C8DD6]  DEFAULT ('N') FOR [Alerttype]
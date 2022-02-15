/****** Object:  Table [dbo].[PlannedDownTimes]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[PlannedDownTimes](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Machine] [nvarchar](50) NULL,
	[DownReason] [nvarchar](50) NULL,
	[SDTsttime] [datetime] NULL,
	[PDTstatus] [nvarchar](1) NULL,
	[Ignorecount] [int] NULL,
	[DownType] [nvarchar](10) NULL,
	[DayName] [nvarchar](50) NULL,
	[ShiftName] [nvarchar](50) NULL,
	[ShiftStart] [datetime] NULL,
	[ShiftEnd] [datetime] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[PlannedDownTimes] ADD  CONSTRAINT [DF__PlannedDo__Ignor__5B438874]  DEFAULT ((0)) FOR [Ignorecount]
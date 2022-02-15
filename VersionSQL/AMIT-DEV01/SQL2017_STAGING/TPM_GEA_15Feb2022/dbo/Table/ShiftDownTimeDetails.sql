/****** Object:  Table [dbo].[ShiftDownTimeDetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ShiftDownTimeDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[dDate] [datetime] NULL,
	[Shift] [nvarchar](50) NULL,
	[PlantID] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[ComponentID] [nvarchar](50) NULL,
	[OperationNo] [int] NULL,
	[OperatorID] [nvarchar](50) NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[DownCategory] [nvarchar](50) NULL,
	[DownID] [nvarchar](50) NULL,
	[DownTime] [bigint] NULL,
	[ML_Flag] [tinyint] NULL,
	[TurnOver] [float] NULL,
	[Threshold] [numeric](18, 0) NULL,
	[RetPerMcHour_Flag] [tinyint] NULL,
	[StdSetupTime] [float] NULL,
	[PE_Flag] [tinyint] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[WorkOrderNumber] [nvarchar](50) NOT NULL,
	[CriticalMachineEnabled] [bit] NULL,
	[GroupID] [nvarchar](50) NULL,
	[PDT] [float] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[ShiftDownTimeDetails] ADD  CONSTRAINT [DF__ShiftDown__Updat__6225902D]  DEFAULT ('pct') FOR [UpdatedBy]
ALTER TABLE [dbo].[ShiftDownTimeDetails] ADD  CONSTRAINT [DF__ShiftDown__Updat__6319B466]  DEFAULT (getdate()) FOR [UpdatedTS]
ALTER TABLE [dbo].[ShiftDownTimeDetails] ADD  CONSTRAINT [DF__ShiftDown__WorkO__640DD89F]  DEFAULT ('0') FOR [WorkOrderNumber]
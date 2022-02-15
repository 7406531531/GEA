/****** Object:  Table [dbo].[FocasWeb_ShiftwiseCockpit]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[FocasWeb_ShiftwiseCockpit](
	[PlantID] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[ShiftID] [int] NULL,
	[Shift] [nvarchar](50) NULL,
	[ShiftStart] [datetime] NULL,
	[ShiftEnd] [datetime] NULL,
	[MachineInterface] [nvarchar](50) NOT NULL,
	[ProductionEfficiency] [float] NULL,
	[AvailabilityEfficiency] [float] NULL,
	[QualityEfficiency] [float] NULL,
	[OverallEfficiency] [float] NULL,
	[Components] [float] NULL,
	[RejCount] [float] NULL,
	[TotalTime] [float] NULL,
	[UtilisedTime] [float] NULL,
	[ManagementLoss] [float] NULL,
	[DownTime] [float] NULL,
	[CN] [float] NULL,
	[Lastcycletime] [datetime] NULL,
	[PEGreen] [smallint] NULL,
	[PERed] [smallint] NULL,
	[AEGreen] [smallint] NULL,
	[AERed] [smallint] NULL,
	[OEGreen] [smallint] NULL,
	[OERed] [smallint] NULL,
	[QEGreen] [smallint] NULL,
	[QERed] [smallint] NULL,
	[MaxDownReason] [nvarchar](50) NULL,
	[LastCycleCO] [nvarchar](100) NULL,
	[LastCycleStart] [datetime] NULL,
	[LastCycleSpindleRunTime] [int] NULL,
	[RunningCycleUT] [float] NULL,
	[RunningCycleDT] [float] NULL,
	[RunningCycleAE] [float] NULL,
	[MachineStatus] [nvarchar](100) NULL,
	[NetDowntime] [float] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[FocasWeb_ShiftwiseCockpit] ADD  CONSTRAINT [DF__FocasWeb___MaxDo__3C4ACB5F]  DEFAULT ('') FOR [MaxDownReason]
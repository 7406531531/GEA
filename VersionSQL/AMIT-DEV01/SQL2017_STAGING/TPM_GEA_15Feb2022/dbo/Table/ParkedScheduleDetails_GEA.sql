/****** Object:  Table [dbo].[ParkedScheduleDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ParkedScheduleDetails_GEA](
	[Machineid] [nvarchar](50) NULL,
	[ProductionOrder] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NULL,
	[ScheduleQty] [int] NULL,
	[ScheduleStart] [datetime] NULL,
	[ScheduleEnd] [datetime] NULL,
	[ParkedBy] [nvarchar](50) NULL,
	[ParkedTS] [datetime] NULL,
	[ReasonForParking] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[PendingQty] [float] NULL,
	[SchedulePriority] [int] NULL,
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[SelectedForRunning] [int] NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
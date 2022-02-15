/****** Object:  Table [dbo].[mxk_temp_machinelevelinfo]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[mxk_temp_machinelevelinfo](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineId] [nvarchar](50) NULL,
	[NumberOfComp] [int] NULL,
	[DownTime] [int] NULL,
	[TimeUtilized] [int] NULL,
	[LoadUnload] [int] NULL,
	[PrdnEffy] [float] NULL,
	[AvailEffy] [float] NULL,
	[OverAllEffy] [float] NULL,
	[MachineHourRate] [float] NULL,
	[Turnover] [float] NULL,
	[CN] [int] NULL,
	[AvgSpeedRatio] [float] NULL,
	[MinorLossRatio] [float] NULL,
	[ManagementLoss] [int] NULL,
	[Plantid] [nvarchar](50) NULL,
	[CellID] [nvarchar](50) NULL
) ON [PRIMARY]
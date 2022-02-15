/****** Object:  Table [dbo].[Inhouse_DPHUReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Inhouse_DPHUReportDetails_GEA](
	[SlNo] [bigint] IDENTITY(1,1) NOT NULL,
	[ScheduleDate] [datetime] NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[ScheduleMonth] [nvarchar](50) NULL,
	[PartNo] [nvarchar](50) NULL,
	[ScheduleQty] [int] NULL,
	[Identity_SerialNo] [nvarchar](50) NULL,
	[SourceDetection] [nvarchar](50) NULL,
	[InspectionPoints] [nvarchar](50) NULL,
	[Phenomenon] [nvarchar](50) NULL,
	[InspectionDate] [datetime] NULL,
	[InspectedBy] [nvarchar](50) NULL,
	[IndicationOfStatus] [nvarchar](50) NULL,
	[AcceptedQty] [int] NULL,
	[ReworkQty] [int] NULL,
	[RejectedQty] [int] NULL,
	[DeviationQty] [int] NULL,
	[ProblemDescription] [nvarchar](100) NULL,
	[RootCause] [nvarchar](50) NULL,
	[ActionNCR] [nvarchar](50) NULL,
	[Responsible] [nvarchar](50) NULL,
	[Status] [nvarchar](100) NULL,
	[TargetDate] [datetime] NULL
) ON [PRIMARY]
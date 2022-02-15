/****** Object:  Table [dbo].[Incoming_DPHUReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Incoming_DPHUReportDetails_GEA](
	[SlNo] [bigint] IDENTITY(1,1) NOT NULL,
	[GRNDate] [datetime] NULL,
	[GRNNo] [nvarchar](50) NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[GRNMonth] [nvarchar](50) NULL,
	[PartNo] [nvarchar](50) NULL,
	[Loc] [nvarchar](50) NULL,
	[PartName] [nvarchar](50) NULL,
	[Qty] [int] NULL,
	[Unit] [nvarchar](50) NULL,
	[SupplierName] [nvarchar](50) NULL,
	[Origin] [nvarchar](50) NULL,
	[InspectedBy] [nvarchar](50) NULL,
	[InspectionMonth] [nvarchar](50) NULL,
	[InspectionDate] [datetime] NULL,
	[InspectedByPriority] [nvarchar](50) NULL,
	[RepeatedIssues] [nvarchar](50) NULL,
	[Phenomenon] [nvarchar](50) NULL,
	[ProblemDescription] [nvarchar](100) NULL,
	[RootCause] [nvarchar](50) NULL,
	[Responsible] [nvarchar](50) NULL,
	[InspectedQty] [int] NULL,
	[ReleasedQty] [int] NULL,
	[ReworkQty] [int] NULL,
	[BlockedQty] [int] NULL,
	[NCRorQualityReportNo] [nvarchar](50) NULL,
	[TargetDate] [datetime] NULL,
	[Status] [nvarchar](100) NULL
) ON [PRIMARY]
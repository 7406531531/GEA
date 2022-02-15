/****** Object:  Table [dbo].[FirstSampleMeasuringReportDetails1_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[FirstSampleMeasuringReportDetails1_GEA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PartNo] [nvarchar](50) NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[Supplier] [nvarchar](50) NULL,
	[IAWStandard] [nvarchar](50) NULL,
	[SetValue] [nvarchar](50) NULL,
	[AsIsValueSupplier] [nvarchar](50) NULL,
	[Ok] [nvarchar](10) NULL,
	[NOk] [nvarchar](10) NULL,
	[AsIsValueGEA] [nvarchar](50) NULL,
	[AssessmentOfDeviation] [nvarchar](50) NULL,
	[Comment] [nvarchar](200) NULL,
	[Date] [datetime] NULL,
	[Signature] [nvarchar](50) NULL,
	[RevNo] [nvarchar](50) NULL,
	[RevDate] [datetime] NULL,
	[Confirmation] [int] NULL,
	[MachineID] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
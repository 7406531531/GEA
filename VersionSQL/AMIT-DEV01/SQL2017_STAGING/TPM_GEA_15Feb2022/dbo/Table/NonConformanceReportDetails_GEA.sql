/****** Object:  Table [dbo].[NonConformanceReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[NonConformanceReportDetails_GEA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[NcNo] [nvarchar](30) NULL,
	[PartName] [nvarchar](50) NULL,
	[PartNo] [nvarchar](50) NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[BatchNo] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[Supplier] [nvarchar](50) NULL,
	[ReceivedQty] [nvarchar](20) NULL,
	[NCQty] [nvarchar](20) NULL,
	[Reason1] [nvarchar](150) NULL,
	[Reason2] [nvarchar](150) NULL,
	[Reason3] [nvarchar](150) NULL,
	[Reason4] [nvarchar](150) NULL,
	[Reason5] [nvarchar](150) NULL,
	[Details] [nvarchar](200) NULL,
	[ImagePath1] [nvarchar](100) NULL,
	[ImagePath2] [nvarchar](100) NULL,
	[Rework] [nvarchar](30) NULL,
	[Acceptance] [nvarchar](20) NULL,
	[Rejected] [nvarchar](20) NULL,
	[QASign] [nvarchar](50) NULL,
	[SignDate] [datetime] NULL,
	[Place] [nvarchar](50) NULL,
	[Confirmation] [int] NULL,
	[MachineID] [nvarchar](50) NULL
) ON [PRIMARY]
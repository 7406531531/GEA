/****** Object:  Table [dbo].[InternalQualityReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[InternalQualityReportDetails_GEA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[PartNo] [nvarchar](50) NULL,
	[PartDescription] [nvarchar](100) NULL,
	[NrNo] [nvarchar](50) NULL,
	[IssueDescription] [nvarchar](250) NULL,
	[RawMaterialPartNo] [nvarchar](50) NULL,
	[DrawingNo] [nvarchar](50) NULL,
	[Material] [nvarchar](50) NULL,
	[BatchNo] [nvarchar](50) NULL,
	[BowlSeries] [nvarchar](50) NULL,
	[LoginName] [nvarchar](50) NULL,
	[CarriedOutBy] [nvarchar](50) NULL,
	[Reason] [nvarchar](500) NULL,
	[IssuedBy] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[QASignature] [nvarchar](50) NULL,
	[HeadOfProdSignature] [nvarchar](50) NULL,
	[Confirmation] [int] NULL,
	[MachineID] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
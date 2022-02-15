/****** Object:  Table [dbo].[QualityIncomingActionDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[QualityIncomingActionDetails_GEA](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[OperationNo] [int] NULL,
	[PlanAndRevNo] [nvarchar](50) NULL,
	[Action] [nvarchar](50) NULL,
	[ActionPerformedBy] [nvarchar](50) NULL,
	[ActionPerformedTS] [datetime] NULL,
	[Reason] [nvarchar](100) NULL,
	[Remarks] [nvarchar](500) NULL,
	[Quality8DReport] [bit] NULL,
	[Quality8DReportComplete] [bit] NULL,
	[DeviationWithRemarks] [bit] NULL,
	[DeviationWithOutRemarks] [bit] NULL,
	[Release] [bit] NULL,
	[Blocked] [bit] NULL,
	[IQRReport] [bit] NULL,
	[IQRReportComplete] [bit] NULL,
	[NCReport] [bit] NULL,
	[NCReportComplete] [bit] NULL,
	[DeviationReport] [bit] NULL,
	[DeviationReportComplete] [bit] NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[FinalInspectionTransaction_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[FinalInspectionTransaction_GEA](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NULL,
	[SerialNo] [nvarchar](50) NULL,
	[PlanAndRevNo] [nvarchar](50) NULL,
	[InspectedBy] [nvarchar](50) NULL,
	[CompletedTS] [datetime] NULL,
	[OprInspectorName] [nvarchar](50) NULL,
	[Remarks] [nvarchar](500) NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
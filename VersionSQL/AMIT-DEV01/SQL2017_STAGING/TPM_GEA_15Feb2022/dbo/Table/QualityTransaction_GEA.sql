/****** Object:  Table [dbo].[QualityTransaction_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[QualityTransaction_GEA](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NULL,
	[PlanAndRevNo] [nvarchar](50) NULL,
	[CharacteristicSlNo] [nvarchar](50) NULL,
	[InspectionValue1] [nvarchar](50) NULL,
	[InspectionValue2] [nvarchar](50) NULL,
	[BatchID] [nvarchar](50) NULL,
	[InspectedBy] [nvarchar](50) NULL,
	[InspectedTS] [datetime] NULL,
	[Remarks] [nvarchar](500) NULL,
	[Confirmation] [int] NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
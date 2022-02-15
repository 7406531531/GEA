/****** Object:  Table [dbo].[HardnessReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[HardnessReportDetails_GEA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UnmachinedPartNo] [nvarchar](50) NULL,
	[PartNo] [nvarchar](50) NULL,
	[ProductID] [nvarchar](50) NULL,
	[MaterialNo] [nvarchar](50) NULL,
	[SerialNo] [nvarchar](50) NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[QBNo] [nvarchar](50) NULL,
	[SheetNo] [nvarchar](20) NULL,
	[TestLoad] [nvarchar](50) NULL,
	[DiaOfBall] [nvarchar](50) NULL,
	[ConversionFactor] [nvarchar](50) NULL,
	[TensileStrengt] [nvarchar](50) NULL,
	[Charge] [nvarchar](50) NULL,
	[ConsecutiveNo] [nvarchar](50) NULL,
	[LotNo] [nvarchar](50) NULL,
	[HardnessNo_0D] [nvarchar](50) NULL,
	[HardnessNo_90D] [nvarchar](50) NULL,
	[HardnessNo_180D] [nvarchar](50) NULL,
	[HardnessNo_270D] [nvarchar](50) NULL,
	[Remarks] [nvarchar](500) NULL,
	[NameOfExaminer] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[Place] [nvarchar](50) NULL,
	[Confirmation] [int] NULL,
	[MachineID] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
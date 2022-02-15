/****** Object:  Table [dbo].[QualityIncomingMaster_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[QualityIncomingMaster_GEA](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[ComponentID] [nvarchar](50) NULL,
	[OperationNo] [int] NULL,
	[CharacteristicID] [nvarchar](50) NULL,
	[CharacteristicCode] [nvarchar](50) NULL,
	[PlanNoAndRevNo] [nvarchar](50) NULL,
	[LSL] [nvarchar](50) NULL,
	[USL] [nvarchar](50) NULL,
	[Value] [nvarchar](50) NULL,
	[UOM] [nvarchar](50) NULL,
	[DataType] [nvarchar](50) NULL,
	[IsEnabled] [nvarchar](5) NULL,
	[IsMandatory] [nvarchar](5) NULL
) ON [PRIMARY]
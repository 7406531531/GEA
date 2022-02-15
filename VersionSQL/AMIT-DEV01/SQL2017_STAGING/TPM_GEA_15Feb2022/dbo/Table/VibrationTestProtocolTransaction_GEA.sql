/****** Object:  Table [dbo].[VibrationTestProtocolTransaction_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[VibrationTestProtocolTransaction_GEA](
	[MachineType] [nvarchar](100) NULL,
	[MachineNo] [nvarchar](50) NULL,
	[ScrollNo] [nvarchar](50) NULL,
	[BowlNo] [nvarchar](50) NULL,
	[OrderNo] [nvarchar](50) NULL,
	[Customer] [nvarchar](100) NULL,
	[Country] [nvarchar](50) NULL,
	[ParameterID] [nvarchar](50) NULL,
	[ParameterValue] [nvarchar](50) NULL,
	[HorizontalMin] [nvarchar](50) NULL,
	[HorizontalMax] [nvarchar](50) NULL,
	[VerticalMin] [nvarchar](50) NULL,
	[VerticalMax] [nvarchar](50) NULL,
	[AxialMin] [nvarchar](50) NULL,
	[AxialMax] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[MachineID] [nvarchar](50) NULL,
	[Confirmation] [bit] NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[SignatureBy] [nvarchar](50) NULL,
	[SignatureTS] [datetime] NULL
) ON [PRIMARY]
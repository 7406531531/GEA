/****** Object:  Table [dbo].[DecanterFinalTestingPackingTransaction_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[DecanterFinalTestingPackingTransaction_GEA](
	[MachineType] [nvarchar](50) NULL,
	[MachineNo] [nvarchar](50) NULL,
	[ScrollNo] [nvarchar](50) NULL,
	[BowlNo] [nvarchar](50) NULL,
	[OrderNo] [nvarchar](50) NULL,
	[Customer] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[FormatNo] [nvarchar](50) NULL,
	[RevNo] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[ParameterID] [nvarchar](500) NULL,
	[Checked] [nvarchar](200) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[Confirmation] [bit] NULL,
	[TechnicianName] [nvarchar](50) NULL,
	[Quantity] [nvarchar](50) NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[BlueCardTransaction_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[BlueCardTransaction_GEA](
	[MachineType] [nvarchar](100) NULL,
	[MachineNo] [nvarchar](50) NULL,
	[ScrollNo] [nvarchar](50) NULL,
	[BowlNo] [nvarchar](50) NULL,
	[OrderNo] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[Customer] [nvarchar](100) NULL,
	[Country] [nvarchar](50) NULL,
	[FormatNo] [nvarchar](50) NULL,
	[RevNo] [nvarchar](50) NULL,
	[ParameterID] [nvarchar](100) NULL,
	[Checked] [nvarchar](250) NULL,
	[PartNo] [nvarchar](50) NULL,
	[CheckNo(Series+SerialNo)] [nvarchar](50) NULL,
	[OverSpeed/UDP] [nvarchar](50) NULL,
	[Dye-Pen Test] [nvarchar](50) NULL,
	[MaxStamped] [nvarchar](50) NULL,
	[PermStamped] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[ApprovedBY] [nvarchar](50) NULL,
	[Confirmation] [bigint] NULL
) ON [PRIMARY]
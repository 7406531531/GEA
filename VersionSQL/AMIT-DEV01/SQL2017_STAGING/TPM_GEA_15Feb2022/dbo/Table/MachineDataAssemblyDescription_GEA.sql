/****** Object:  Table [dbo].[MachineDataAssemblyDescription_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[MachineDataAssemblyDescription_GEA](
	[MachineType] [nvarchar](100) NULL,
	[MachineNo] [nvarchar](50) NULL,
	[ScrollNo] [nvarchar](50) NULL,
	[BowlNo] [nvarchar](50) NULL,
	[OrderNo] [nvarchar](50) NULL,
	[Customer] [nvarchar](100) NULL,
	[Country] [nvarchar](50) NULL,
	[FormatNo] [nvarchar](50) NULL,
	[RevNo] [nvarchar](50) NULL,
	[ParameterID] [nvarchar](50) NULL,
	[PartNo] [nvarchar](50) NULL,
	[SerialNo] [nvarchar](50) NULL,
	[Speed] [nvarchar](50) NULL,
	[Density] [nvarchar](50) NULL,
	[Stamps] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[MachineID] [nvarchar](50) NULL,
	[TechnicianName] [nvarchar](50) NULL,
	[Confirmation] [bit] NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[BalancingProductionOrder] [nvarchar](100) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[MachineDataAssemblyDescription_GEA] ADD  DEFAULT ((0)) FOR [Confirmation]
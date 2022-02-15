/****** Object:  Table [dbo].[ItemMaster]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ItemMaster](
	[ItemNo] [nvarchar](50) NULL,
	[Iteminterfaceid] [nvarchar](16) NULL,
	[Itemdescription] [nvarchar](100) NULL,
	[customerid] [nvarchar](50) NULL,
	[Operationno] [int] NULL,
	[Opndescription] [nvarchar](100) NULL,
	[CNC M/C] [nvarchar](50) NULL,
	[Price] [float] NULL,
	[Drawingno] [nvarchar](50) NULL,
	[Opninterfaceid] [nvarchar](4) NULL,
	[LoadUnloadTime] [bigint] NULL,
	[CycleTime] [float] NULL,
	[SubOperations] [int] NULL,
	[StdSetupTime] [float] NULL,
	[MachiningTimeThreshold] [int] NULL,
	[TargetPercent] [int] NULL,
	[LoadUnloadTimeThreshold] [bigint] NULL,
	[SCIThreshold] [float] NULL,
	[DCLThreshold] [float] NULL,
	[ID] [bigint] NOT NULL,
	[FinishedOperation] [int] NULL,
	[MinLoadUnloadThreshold] [float] NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[tmpcomponent]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[tmpcomponent](
	[componentid] [nvarchar](50) NULL,
	[operationno] [int] NULL,
	[description] [nvarchar](100) NULL,
	[machineid] [nvarchar](50) NULL,
	[price] [float] NULL,
	[cycletime] [float] NULL,
	[drawingno] [nvarchar](50) NULL,
	[InterfaceID] [nvarchar](4) NULL,
	[loadunload] [bigint] NULL,
	[machiningtime] [float] NULL,
	[SubOperations] [int] NULL,
	[StdSetupTime] [float] NULL,
	[MachiningTimeThreshold] [int] NULL,
	[TargetPercent] [int] NULL,
	[LowerEnergyThreshold] [float] NULL,
	[UpperEnergyThreshold] [float] NULL,
	[SCIThreshold] [float] NULL,
	[DCLThreshold] [float] NULL
) ON [PRIMARY]
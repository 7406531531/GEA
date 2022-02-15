/****** Object:  Table [dbo].[RunningScheduleDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[RunningScheduleDetails_GEA](
	[Machineid] [nvarchar](50) NULL,
	[ProductionOrder] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NULL,
	[ActualStarttime] [datetime] NULL,
	[TentativeEndtime] [datetime] NULL,
	[CycleRuntime] [float] NULL,
	[UpdatedTS] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
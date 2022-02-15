/****** Object:  Table [dbo].[ScheduleDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ScheduleDetails_GEA](
	[Machineid] [nvarchar](50) NULL,
	[ProductionOrder] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NULL,
	[ScheduleQty] [int] NULL,
	[ScheduleStart] [datetime] NULL,
	[ScheduleEnd] [datetime] NULL,
	[Status] [nvarchar](50) NULL,
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[SchedulePriority] [int] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[ActualStarttime] [datetime] NULL,
	[TentativeEndtime] [datetime] NULL,
	[ActualEndtime] [datetime] NULL,
	[UserPriority] [int] NULL,
	[Localorexport] [nvarchar](50) NULL,
	[SaleOrder] [nvarchar](50) NULL,
	[ScrollWelded] [nvarchar](50) NULL,
	[RDDMachines] [datetime] NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[Customer] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL,
	[Supplier] [nvarchar](50) NULL,
	[NewProdDevelopment] [bit] NULL,
	[SamplingQty] [int] NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[AssemblyActivitySchedules_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[AssemblyActivitySchedules_GEA](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[Machineid] [nvarchar](50) NULL,
	[ProductionOrder] [nvarchar](50) NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NULL,
	[Activity] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL
) ON [PRIMARY]
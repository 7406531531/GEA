/****** Object:  Table [dbo].[NonMachiningEvents_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[NonMachiningEvents_GEA](
	[Machineid] [nvarchar](50) NULL,
	[LastEventType] [nvarchar](50) NULL,
	[CycleStartTS] [datetime] NULL,
	[CycleEndTS] [datetime] NULL,
	[PauseTS] [datetime] NULL,
	[DownStartTS] [datetime] NULL,
	[DownEndTS] [datetime] NULL,
	[LastEventTS] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[DownReason] [nvarchar](50) NULL
) ON [PRIMARY]
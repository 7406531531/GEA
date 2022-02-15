/****** Object:  Table [dbo].[ScheduleCalculateMethod_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ScheduleCalculateMethod_GEA](
	[Machineid] [nvarchar](50) NULL,
	[CalculatePlan] [nvarchar](100) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[Status] [int] NULL,
	[ServiceUpdatedTS] [datetime] NULL,
	[UserInputDT] [datetime] NULL
) ON [PRIMARY]
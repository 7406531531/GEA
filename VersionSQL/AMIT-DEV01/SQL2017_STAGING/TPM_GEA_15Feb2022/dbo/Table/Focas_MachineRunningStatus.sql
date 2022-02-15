/****** Object:  Table [dbo].[Focas_MachineRunningStatus]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_MachineRunningStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Machineid] [nvarchar](50) NULL,
	[Datatype] [nvarchar](50) NULL,
	[LastCycleTS] [datetime] NULL,
	[AlarmStatus] [nvarchar](50) NULL,
	[SpindleStatus] [int] NULL,
	[SpindleCycleTS] [datetime] NULL,
	[PowerOnOrOff] [int] NULL
) ON [PRIMARY]
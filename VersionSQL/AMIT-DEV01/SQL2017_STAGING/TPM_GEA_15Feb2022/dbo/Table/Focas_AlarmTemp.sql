/****** Object:  Table [dbo].[Focas_AlarmTemp]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_AlarmTemp](
	[AlarmNo] [bigint] NULL,
	[AlarmGroupNo] [bigint] NULL,
	[AlarmMSG] [nvarchar](250) NULL,
	[AlarmAxisNo] [bigint] NULL,
	[AlarmTotAxisNo] [bigint] NULL,
	[AlarmGCode] [nvarchar](500) NULL,
	[AlarmOtherCode] [nvarchar](500) NULL,
	[AlarmMPos] [nvarchar](500) NULL,
	[AlarmAPos] [nvarchar](500) NULL,
	[AlarmTime] [datetime] NULL,
	[MachineId] [nvarchar](50) NULL
) ON [PRIMARY]
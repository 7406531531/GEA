/****** Object:  Table [dbo].[Focas_AlarmHistory]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_AlarmHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[AlarmNo] [bigint] NULL,
	[AlarmGroupNo] [bigint] NULL,
	[AlarmMSG] [nvarchar](255) NULL,
	[AlarmAxisNo] [bigint] NULL,
	[AlarmTotAxisNo] [bigint] NULL,
	[AlarmGCode] [nvarchar](250) NULL,
	[AlarmOtherCode] [nvarchar](250) NULL,
	[AlarmMPos] [nvarchar](255) NULL,
	[AlarmAPos] [nvarchar](255) NULL,
	[AlarmTime] [datetime] NULL,
	[MachineID] [nvarchar](50) NULL,
	[EndTime] [datetime] NULL,
	[AckStatus] [int] NULL,
 CONSTRAINT [PK_Focas_AlarmHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
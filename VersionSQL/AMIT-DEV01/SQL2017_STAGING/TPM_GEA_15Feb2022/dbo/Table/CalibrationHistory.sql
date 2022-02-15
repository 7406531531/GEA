/****** Object:  Table [dbo].[CalibrationHistory]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[CalibrationHistory](
	[GaugeId] [nvarchar](50) NOT NULL,
	[Serial number] [nvarchar](20) NOT NULL,
	[Calibration number] [bigint] NOT NULL,
	[CalibrationDueOn] [datetime] NOT NULL,
	[CalibrationDoneOn] [datetime] NOT NULL
) ON [PRIMARY]
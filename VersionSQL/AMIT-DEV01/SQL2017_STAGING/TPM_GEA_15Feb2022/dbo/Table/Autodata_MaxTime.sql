/****** Object:  Table [dbo].[Autodata_MaxTime]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Autodata_MaxTime](
	[Machineid] [nvarchar](50) NOT NULL,
	[Starttime] [datetime] NULL,
	[Endtime] [datetime] NULL,
	[NPCy-TCS] [smalldatetime] NULL
) ON [PRIMARY]
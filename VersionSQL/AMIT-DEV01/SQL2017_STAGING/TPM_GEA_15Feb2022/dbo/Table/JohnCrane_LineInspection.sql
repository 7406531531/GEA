/****** Object:  Table [dbo].[JohnCrane_LineInspection]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[JohnCrane_LineInspection](
	[Datatype] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[LineInspected] [nvarchar](50) NULL,
	[NCLines] [int] NULL,
	[EQP] [int] NULL,
	[IQP] [int] NULL,
	[EQPThreshold] [int] NULL,
	[IQPThreshold] [int] NULL,
	[TimeStamp] [datetime] NULL,
	[TransLinesInspected] [int] NULL,
	[TransNCLines] [int] NULL
) ON [PRIMARY]
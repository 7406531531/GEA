/****** Object:  Table [dbo].[ActivityFreq_MGTL]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ActivityFreq_MGTL](
	[FreqID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Frequency] [nvarchar](50) NOT NULL,
	[Freqvalue] [nvarchar](50) NULL,
	[Freqtype] [nvarchar](50) NULL,
	[SortOrder] [smallint] NOT NULL
) ON [PRIMARY]
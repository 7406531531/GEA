/****** Object:  Table [dbo].[NSPLDowns]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[NSPLDowns](
	[EffFrom] [datetime] NULL,
	[EffTo] [datetime] NULL,
	[FromTime] [datetime] NULL,
	[ToTime] [datetime] NULL,
	[Today] [bit] NULL,
	[Tommorrow] [bit] NULL,
	[DownReason] [nvarchar](50) NULL,
	[Flag] [int] NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[Quality_8DReportMaster_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Quality_8DReportMaster_GEA](
	[Idd] [bigint] IDENTITY(1,1) NOT NULL,
	[HeaderID] [int] NULL,
	[Header] [nvarchar](4000) NULL,
	[GridOrRichText] [nvarchar](10) NULL,
	[SubHeaderID] [int] NULL,
	[SubHeader] [nvarchar](2000) NULL
) ON [PRIMARY]
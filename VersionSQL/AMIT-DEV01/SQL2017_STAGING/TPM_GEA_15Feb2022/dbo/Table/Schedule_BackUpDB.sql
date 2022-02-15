/****** Object:  Table [dbo].[Schedule_BackUpDB]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Schedule_BackUpDB](
	[Slno] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](50) NULL,
	[StartDate] [nvarchar](12) NULL,
	[NextDate] [nvarchar](12) NULL,
	[StartTime] [datetime] NULL,
	[NextTime] [datetime] NULL,
	[Occurs] [int] NULL,
	[Frequency] [int] NULL,
	[BackUpPath] [nvarchar](80) NULL
) ON [PRIMARY]
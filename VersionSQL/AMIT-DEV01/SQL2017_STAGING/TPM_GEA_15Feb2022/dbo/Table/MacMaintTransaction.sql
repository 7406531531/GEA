/****** Object:  Table [dbo].[MacMaintTransaction]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[MacMaintTransaction](
	[ActivityID] [int] NOT NULL,
	[Machine] [nvarchar](50) NULL,
	[SubSystem] [nvarchar](1000) NULL,
	[PartNo] [nvarchar](1000) NULL,
	[Activity] [nvarchar](50) NULL,
	[Frequency] [nvarchar](50) NULL,
	[Remarks] [nvarchar](1000) NULL,
	[Status] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[Shift] [nvarchar](50) NULL,
	[TimeStamp] [datetime] NULL
) ON [PRIMARY]
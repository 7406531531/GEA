/****** Object:  Table [dbo].[AndonTarget]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[AndonTarget](
	[Plant] [nvarchar](50) NULL,
	[Machine] [nvarchar](50) NULL,
	[Target] [bigint] NULL,
	[TargetDate] [smalldatetime] NULL,
	[Targetshift] [nvarchar](20) NULL
) ON [PRIMARY]
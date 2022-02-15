/****** Object:  Table [dbo].[GaugeMovementStatus]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[GaugeMovementStatus](
	[GaugeId] [nvarchar](50) NOT NULL,
	[GaugeSlno] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NULL,
	[ProcessDate] [datetime] NULL,
	[Contact] [nvarchar](50) NULL,
	[Slno] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[PlannedDownListforLday]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[PlannedDownListforLday](
	[EffFrom] [datetime] NULL,
	[EffTo] [datetime] NULL,
	[FromTime] [datetime] NOT NULL,
	[ToTime] [datetime] NOT NULL,
	[Today] [int] NOT NULL,
	[Tommorrow] [int] NOT NULL,
	[DownReason] [nvarchar](50) NOT NULL,
	[MachineID] [nvarchar](50) NULL
) ON [PRIMARY]
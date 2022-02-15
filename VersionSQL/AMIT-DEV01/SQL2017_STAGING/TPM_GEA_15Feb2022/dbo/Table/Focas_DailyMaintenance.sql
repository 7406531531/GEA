/****** Object:  Table [dbo].[Focas_DailyMaintenance]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_DailyMaintenance](
	[id] [numeric](18, 0) NULL,
	[subsystem] [nvarchar](250) NULL,
	[checks] [nvarchar](250) NULL,
	[whnToCheck] [nvarchar](200) NULL,
	[Action] [varchar](50) NULL,
	[DateTime] [datetime] NULL,
	[Machineid] [nvarchar](50) NULL,
	[Shift] [nchar](12) NULL
) ON [PRIMARY]
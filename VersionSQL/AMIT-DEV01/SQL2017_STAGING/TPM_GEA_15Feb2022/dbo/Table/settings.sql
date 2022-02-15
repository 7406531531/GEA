/****** Object:  Table [dbo].[settings]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[settings](
	[componentfromtpm] [smallint] NULL,
	[machinefromtpm] [smallint] NULL,
	[tpmdatabase] [nvarchar](150) NULL,
	[shift1from] [smalldatetime] NULL,
	[shift2from] [smalldatetime] NULL,
	[shift3from] [smalldatetime] NULL,
	[shift1to] [smalldatetime] NULL,
	[shift2to] [smalldatetime] NULL,
	[shift3to] [smalldatetime] NULL,
	[purgedate] [datetime] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[settings] ADD  CONSTRAINT [DF_settings_componentfromtpm]  DEFAULT ((0)) FOR [componentfromtpm]
ALTER TABLE [dbo].[settings] ADD  CONSTRAINT [DF_settings_machinefromtpm]  DEFAULT ((0)) FOR [machinefromtpm]
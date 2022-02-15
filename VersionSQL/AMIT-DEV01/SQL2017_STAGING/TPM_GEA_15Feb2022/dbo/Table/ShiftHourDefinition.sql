/****** Object:  Table [dbo].[ShiftHourDefinition]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ShiftHourDefinition](
	[ShiftID] [int] NOT NULL,
	[HourName] [nvarchar](50) NULL,
	[HourID] [int] NOT NULL,
	[FromDay] [int] NULL,
	[ToDay] [int] NULL,
	[HourStart] [datetime] NULL,
	[HourEnd] [datetime] NULL,
	[Minutes] [int] NULL,
	[IsEnable] [bit] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[ShiftHourDefinition] ADD  DEFAULT ((1)) FOR [IsEnable]
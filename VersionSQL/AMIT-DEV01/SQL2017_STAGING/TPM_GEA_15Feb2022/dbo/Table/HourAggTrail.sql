/****** Object:  Table [dbo].[HourAggTrail]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[HourAggTrail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Machineid] [nvarchar](50) NOT NULL,
	[Shift] [nvarchar](50) NOT NULL,
	[HourStart] [datetime] NOT NULL,
	[HourEnd] [datetime] NOT NULL,
	[HourID] [nvarchar](50) NOT NULL,
	[Aggdate] [datetime] NOT NULL,
	[Starttime] [datetime] NOT NULL,
	[AggregateTS] [datetime] NOT NULL,
 CONSTRAINT [PK_HourAggTrail] PRIMARY KEY CLUSTERED 
(
	[Machineid] ASC,
	[Shift] ASC,
	[Aggdate] ASC,
	[HourID] ASC,
	[Starttime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
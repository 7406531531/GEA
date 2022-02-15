/****** Object:  Table [dbo].[ShiftAggTrail]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ShiftAggTrail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Machineid] [nvarchar](50) NOT NULL,
	[Shift] [nvarchar](50) NOT NULL,
	[Aggdate] [datetime] NOT NULL,
	[Datatype] [int] NOT NULL,
	[Starttime] [datetime] NOT NULL,
	[Endtime] [datetime] NOT NULL,
	[AggregateTS] [datetime] NOT NULL,
	[Recordid] [bigint] NULL,
 CONSTRAINT [PK_ShiftAggTrail] PRIMARY KEY CLUSTERED 
(
	[Machineid] ASC,
	[Shift] ASC,
	[Aggdate] ASC,
	[Datatype] ASC,
	[Starttime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
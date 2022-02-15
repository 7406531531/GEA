/****** Object:  Table [dbo].[BusinessRules]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[BusinessRules](
	[slno] [bigint] IDENTITY(1,1) NOT NULL,
	[RuleAppliesTo] [nvarchar](50) NULL,
	[Resource] [nvarchar](50) NULL,
	[Track] [nvarchar](50) NULL,
	[Condition] [nvarchar](50) NULL,
	[TrackValue] [float] NULL,
	[Message] [nvarchar](max) NULL,
	[email] [int] NULL,
	[EmailID] [nvarchar](50) NULL,
	[mobile] [int] NULL,
	[MobileNo] [nvarchar](110) NULL,
	[MsgPerEvery] [int] NULL,
	[WriteLogFile] [smallint] NULL,
	[AlertUser] [smallint] NULL,
	[ProdIndicator] [smallint] NULL,
	[IndicatorColor] [nvarchar](6) NULL,
	[LampNumber] [int] NULL,
	[MaxTrackValue] [float] NULL,
	[MsgFormat] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
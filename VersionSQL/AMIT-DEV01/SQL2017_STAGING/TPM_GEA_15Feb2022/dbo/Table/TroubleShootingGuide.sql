/****** Object:  Table [dbo].[TroubleShootingGuide]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[TroubleShootingGuide](
	[TSID] [int] NOT NULL,
	[Topic] [nvarchar](300) NOT NULL,
	[ParentID] [int] NULL,
	[HelpText] [nvarchar](50) NULL,
	[ValueInText] [nvarchar](50) NULL,
	[ValueInText1] [nvarchar](50) NULL,
 CONSTRAINT [PK_TroubleShootingGuide] PRIMARY KEY CLUSTERED 
(
	[TSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
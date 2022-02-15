/****** Object:  Table [dbo].[CockpitDefaults]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[CockpitDefaults](
	[Parameter] [nvarchar](50) NOT NULL,
	[ValueInText] [nvarchar](50) NOT NULL,
	[ValueInText2] [nvarchar](max) NULL,
	[ValueInInt] [int] NULL,
	[ValueInBool] [int] NULL,
	[LanguageSpecified] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[CockpitDefaults] ADD  CONSTRAINT [DF__CockpitDe__Value__5C229E14]  DEFAULT ((0)) FOR [ValueInBool]
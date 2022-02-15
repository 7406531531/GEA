/****** Object:  Table [dbo].[AndonDefaults]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[AndonDefaults](
	[Parameter] [nvarchar](50) NOT NULL,
	[ValueInText] [nvarchar](50) NOT NULL,
	[ValueInText2] [nvarchar](100) NULL,
	[ValueInInt] [int] NULL,
	[ValueInBool] [int] NULL,
	[TextAlign] [nvarchar](50) NULL,
	[DataFontSize] [nvarchar](50) NULL,
	[LabelFontSize] [nvarchar](50) NULL,
	[User] [nvarchar](100) NULL
) ON [PRIMARY]
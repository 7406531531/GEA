/****** Object:  Table [dbo].[Alert_Defaults]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Alert_Defaults](
	[Parameter] [nvarchar](100) NOT NULL,
	[ValueInText1] [nvarchar](50) NULL,
	[ValueInText2] [nvarchar](50) NULL,
	[ValueInText3] [nvarchar](50) NULL
) ON [PRIMARY]
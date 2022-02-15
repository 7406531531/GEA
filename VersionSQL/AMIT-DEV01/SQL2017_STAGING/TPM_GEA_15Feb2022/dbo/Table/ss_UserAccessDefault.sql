/****** Object:  Table [dbo].[ss_UserAccessDefault]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ss_UserAccessDefault](
	[Domain] [nvarchar](50) NOT NULL,
	[DisplayText] [nvarchar](50) NULL,
	[Code] [nvarchar](50) NULL,
	[Isvisible] [bit] NULL,
	[WebColumn] [nvarchar](50) NULL,
	[DomainName] [nvarchar](50) NULL
) ON [PRIMARY]
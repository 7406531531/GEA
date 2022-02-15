/****** Object:  Table [dbo].[Reworkinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Reworkinformation](
	[Reworkid] [nvarchar](50) NULL,
	[Reworkno] [int] IDENTITY(1,1) NOT NULL,
	[Reworkdescription] [nvarchar](100) NULL,
	[ReworkCatagory] [nvarchar](50) NULL,
	[Reworkinterfaceid] [nvarchar](50) NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[useraccessrights_Web]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[useraccessrights_Web](
	[employeeid] [nvarchar](25) NULL,
	[domain] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[slno] [int] IDENTITY(1,1) NOT NULL,
	[Column1] [nvarchar](50) NULL,
 CONSTRAINT [PK_useraccessrights_Web] PRIMARY KEY CLUSTERED 
(
	[slno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
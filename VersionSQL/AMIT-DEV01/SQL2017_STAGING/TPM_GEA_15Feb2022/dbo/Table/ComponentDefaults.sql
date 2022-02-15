/****** Object:  Table [dbo].[ComponentDefaults]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ComponentDefaults](
	[Mc] [nvarchar](50) NOT NULL,
	[Comp] [nvarchar](50) NOT NULL,
	[Opn] [nvarchar](50) NOT NULL,
	[Opr] [nvarchar](50) NOT NULL,
	[Dimension] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ComponentDefaults] PRIMARY KEY CLUSTERED 
(
	[Mc] ASC,
	[Comp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
/****** Object:  Table [dbo].[MultiLingual_MC]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[MultiLingual_MC](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ClassName] [nvarchar](200) NOT NULL,
	[Key] [nvarchar](200) NOT NULL,
	[EN] [nvarchar](max) NOT NULL,
	[RU] [nvarchar](max) NULL,
	[ZH] [nvarchar](max) NULL,
	[KN] [nvarchar](max) NULL,
 CONSTRAINT [PK_MultiLingual_MC] PRIMARY KEY CLUSTERED 
(
	[ClassName] ASC,
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
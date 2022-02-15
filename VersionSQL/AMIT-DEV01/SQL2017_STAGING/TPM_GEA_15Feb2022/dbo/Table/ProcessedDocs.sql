/****** Object:  Table [dbo].[ProcessedDocs]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ProcessedDocs](
	[MONumber] [nvarchar](50) NULL,
	[MachineId] [nvarchar](50) NULL,
	[ComponentId] [nvarchar](50) NULL,
	[Operation] [nvarchar](50) NULL,
	[Documents] [nvarchar](max) NULL,
	[flag] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
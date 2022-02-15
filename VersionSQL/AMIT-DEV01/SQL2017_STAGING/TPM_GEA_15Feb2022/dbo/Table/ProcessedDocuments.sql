/****** Object:  Table [dbo].[ProcessedDocuments]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ProcessedDocuments](
	[WoNumber] [int] NULL,
	[MachineID] [nvarchar](50) NULL,
	[Part] [nvarchar](50) NULL,
	[Operation] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[ProcessedDocs] [nvarchar](50) NULL
) ON [PRIMARY]
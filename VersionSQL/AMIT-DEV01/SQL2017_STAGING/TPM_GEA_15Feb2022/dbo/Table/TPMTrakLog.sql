/****** Object:  Table [dbo].[TPMTrakLog]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[TPMTrakLog](
	[ModuleName] [nvarchar](50) NULL,
	[ComputerName] [nvarchar](100) NULL,
	[UserName] [nvarchar](100) NULL,
	[LogDate] [datetime] NULL,
	[Remarks] [nvarchar](250) NULL
) ON [PRIMARY]
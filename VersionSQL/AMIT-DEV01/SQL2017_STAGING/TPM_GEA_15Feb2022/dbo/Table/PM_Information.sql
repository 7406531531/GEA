/****** Object:  Table [dbo].[PM_Information]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[PM_Information](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[SubCategory] [nvarchar](50) NULL,
	[SubCategoryID] [int] NOT NULL,
	[Frequency] [nvarchar](50) NULL,
	[MachineType] [nvarchar](50) NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[CellFinishOperation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[CellFinishOperation](
	[CellId] [nvarchar](50) NOT NULL,
	[ComponentId] [nvarchar](50) NOT NULL,
	[OperationNo] [smallint] NOT NULL,
	[Yield] [bigint] NOT NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL
) ON [PRIMARY]
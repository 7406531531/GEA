/****** Object:  Table [dbo].[Login_historyDetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Login_historyDetails](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Machine] [nvarchar](50) NULL,
	[RecordType] [numeric](18, 0) NULL,
	[Login_TS] [datetime] NULL,
	[LogOut_TS] [datetime] NULL,
	[Operator] [nvarchar](50) NULL
) ON [PRIMARY]
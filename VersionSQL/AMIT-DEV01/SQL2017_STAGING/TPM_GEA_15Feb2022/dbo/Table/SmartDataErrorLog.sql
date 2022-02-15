/****** Object:  Table [dbo].[SmartDataErrorLog]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[SmartDataErrorLog](
	[RawdataID] [bigint] NULL,
	[IPAddress] [nvarchar](20) NULL,
	[Mc] [nvarchar](50) NULL,
	[ErrorMsg] [nvarchar](500) NULL,
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TimeStamp] [datetime] NULL
) ON [PRIMARY]
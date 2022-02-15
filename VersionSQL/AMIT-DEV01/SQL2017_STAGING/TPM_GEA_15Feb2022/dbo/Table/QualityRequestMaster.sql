/****** Object:  Table [dbo].[QualityRequestMaster]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[QualityRequestMaster](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Datatype] [int] NULL,
	[mc] [nvarchar](50) NULL,
	[comp] [nvarchar](50) NULL,
	[opn] [nvarchar](50) NULL,
	[Slno] [nvarchar](50) NULL,
	[QualityStatus] [int] NULL,
	[Starttime] [datetime] NULL
) ON [PRIMARY]
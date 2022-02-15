/****** Object:  Table [dbo].[eSHOPxDocuments]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[eSHOPxDocuments](
	[machineid] [nvarchar](50) NOT NULL,
	[Componentid] [nvarchar](50) NOT NULL,
	[OperationNo] [smallint] NULL,
	[DocumentType] [nvarchar](4000) NULL,
	[DocumentPath] [nvarchar](500) NULL,
	[DocumentName] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[Updated_TS] [smalldatetime] NULL
) ON [PRIMARY]
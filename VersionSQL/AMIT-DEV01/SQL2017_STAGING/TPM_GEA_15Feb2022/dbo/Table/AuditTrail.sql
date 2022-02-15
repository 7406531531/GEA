/****** Object:  Table [dbo].[AuditTrail]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[AuditTrail](
	[Type] [char](1) NULL,
	[TableName] [nvarchar](128) NULL,
	[PK] [nvarchar](1000) NULL,
	[FieldName] [nvarchar](128) NULL,
	[OldValue] [nvarchar](1000) NULL,
	[NewValue] [nvarchar](1000) NULL,
	[UpdateDate] [datetime] NULL,
	[UserName] [nvarchar](128) NULL,
	[HostIpAddress] [nvarchar](128) NULL
) ON [PRIMARY]
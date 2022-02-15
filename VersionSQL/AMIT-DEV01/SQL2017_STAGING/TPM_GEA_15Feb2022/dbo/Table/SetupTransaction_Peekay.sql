/****** Object:  Table [dbo].[SetupTransaction_Peekay]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[SetupTransaction_Peekay](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[mc] [nvarchar](50) NULL,
	[comp] [nvarchar](50) NULL,
	[opn] [nvarchar](50) NULL,
	[RecordType] [nvarchar](50) NULL,
	[EventID] [nvarchar](50) NULL,
	[EventTS] [datetime] NULL,
	[WorkOrderNo] [nvarchar](50) NULL,
	[Opr] [nvarchar](50) NULL
) ON [PRIMARY]
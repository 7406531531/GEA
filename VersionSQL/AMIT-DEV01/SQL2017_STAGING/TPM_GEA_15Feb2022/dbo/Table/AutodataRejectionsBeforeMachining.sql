/****** Object:  Table [dbo].[AutodataRejectionsBeforeMachining]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[AutodataRejectionsBeforeMachining](
	[mc] [nvarchar](50) NULL,
	[comp] [nvarchar](50) NULL,
	[opn] [nvarchar](50) NULL,
	[opr] [nvarchar](50) NULL,
	[Rejection_Code] [nvarchar](50) NULL,
	[Rejection_Qty] [int] NULL,
	[CreatedTS] [datetime] NULL,
	[RejDate] [datetime] NULL,
	[RejShift] [nvarchar](15) NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[recordid] [bigint] NOT NULL,
	[Flag] [nvarchar](20) NULL,
	[WorkOrderNumber] [nvarchar](50) NULL,
	[RejectionType] [nvarchar](50) NULL
) ON [PRIMARY]
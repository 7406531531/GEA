/****** Object:  Table [dbo].[Quality_8DReportTransaction_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Quality_8DReportTransaction_GEA](
	[SlNo] [bigint] IDENTITY(1,1) NOT NULL,
	[PONo] [nvarchar](50) NULL,
	[Issuer] [nvarchar](50) NULL,
	[Field] [nvarchar](50) NULL,
	[ProblemOriginatedAt] [nvarchar](50) NULL,
	[ReportNo] [nvarchar](50) NULL,
	[IssueDate] [datetime] NULL,
	[HeaderID] [nvarchar](4000) NULL,
	[SubHeaderID] [nvarchar](4000) NULL,
	[TextValue] [nvarchar](4000) NULL,
	[Item1] [nvarchar](4000) NULL,
	[Item2] [nvarchar](50) NULL,
	[Item3] [nvarchar](50) NULL,
	[Notes] [nvarchar](4000) NULL,
	[UpdatedTS] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[IsEnable] [bit] NULL,
	[MachineID] [nvarchar](50) NULL,
	[Confirmation] [int] NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
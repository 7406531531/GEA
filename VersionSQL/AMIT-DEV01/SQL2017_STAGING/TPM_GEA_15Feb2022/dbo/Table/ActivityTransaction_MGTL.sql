/****** Object:  Table [dbo].[ActivityTransaction_MGTL]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ActivityTransaction_MGTL](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[ActivityID] [int] NULL,
	[Frequency] [nvarchar](50) NULL,
	[ActivityTS] [datetime] NULL,
	[ActivityDoneTS] [datetime] NULL,
	[Machineid] [nvarchar](50) NULL,
	[Remarks] [nvarchar](1000) NULL,
	[WeekNo] [nvarchar](50) NULL,
	[ActivityValue] [nvarchar](50) NULL
) ON [PRIMARY]
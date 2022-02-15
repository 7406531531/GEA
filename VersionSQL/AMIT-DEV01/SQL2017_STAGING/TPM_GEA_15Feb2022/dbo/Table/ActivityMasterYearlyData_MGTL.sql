/****** Object:  Table [dbo].[ActivityMasterYearlyData_MGTL]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ActivityMasterYearlyData_MGTL](
	[ActivityID] [int] NOT NULL,
	[Activity] [nvarchar](100) NULL,
	[FreqID] [int] NULL,
	[ActivityDate] [datetime] NULL,
	[year] [int] NULL,
	[WeekNo] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[MonthNo] [nvarchar](50) NULL
) ON [PRIMARY]
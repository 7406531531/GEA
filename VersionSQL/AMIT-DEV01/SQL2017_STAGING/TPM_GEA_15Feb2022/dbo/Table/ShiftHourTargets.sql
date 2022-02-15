/****** Object:  Table [dbo].[ShiftHourTargets]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ShiftHourTargets](
	[AutoId] [int] IDENTITY(1,1) NOT NULL,
	[Machineid] [nvarchar](50) NULL,
	[ComponentID] [nvarchar](50) NULL,
	[OperationNo] [int] NULL,
	[Sdate] [datetime] NULL,
	[ShiftID] [int] NULL,
	[HourName] [nvarchar](50) NULL,
	[HourID] [int] NULL,
	[HourStart] [datetime] NULL,
	[HourEnd] [datetime] NULL,
	[Target] [float] NULL
) ON [PRIMARY]
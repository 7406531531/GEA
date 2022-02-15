/****** Object:  Table [dbo].[FocasWeb_ShiftwiseSummary]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[FocasWeb_ShiftwiseSummary](
	[PlantID] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[ShiftID] [int] NULL,
	[Shift] [nvarchar](50) NULL,
	[PartCount] [float] NULL,
	[TotalTime] [float] NULL,
	[PowerOnTime] [float] NULL,
	[OperatingTime] [float] NULL,
	[CuttingTime] [float] NULL,
	[Stoppages] [float] NULL,
	[UpdatedTS] [datetime] NULL,
	[AutoID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[FocasWeb_DownFreq]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[FocasWeb_DownFreq](
	[PlantID] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[DownID] [nvarchar](50) NULL,
	[DownReason] [nvarchar](50) NULL,
	[DownFreq] [int] NULL,
	[Date] [datetime] NULL,
	[ShiftID] [int] NULL,
	[Shift] [nvarchar](50) NULL,
	[Downtime] [float] NULL
) ON [PRIMARY]
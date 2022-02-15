/****** Object:  Table [dbo].[FlowCtrlAutodata]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[FlowCtrlAutodata](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineInterface] [nvarchar](50) NOT NULL,
	[PumpModel] [nvarchar](50) NOT NULL,
	[PumpSeries] [nvarchar](50) NOT NULL,
	[Operator] [nvarchar](50) NULL,
	[MinFlow] [float] NOT NULL,
	[MaxFlow] [float] NULL,
	[Starttime] [datetime] NOT NULL,
	[Endtime] [datetime] NULL,
	[Remarks] [varchar](max) NULL,
	[Loadunload] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
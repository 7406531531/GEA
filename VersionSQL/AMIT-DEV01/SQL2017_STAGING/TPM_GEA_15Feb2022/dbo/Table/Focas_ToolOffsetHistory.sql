/****** Object:  Table [dbo].[Focas_ToolOffsetHistory]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_ToolOffsetHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[MachineTimeStamp] [datetime] NULL,
	[ProgramNumber] [nvarchar](50) NULL,
	[ToolNo] [int] NULL,
	[ToolSequenceNum] [int] NULL,
	[CuttingTime] [float] NULL,
	[ToolUsageTime] [float] NULL,
	[OffsetNo] [int] NULL,
	[WearOffsetX] [float] NULL,
	[WearOffsetZ] [float] NULL,
	[WearOffsetR] [float] NULL,
	[WearOffsetT] [float] NULL,
	[GeometryOffsetX] [float] NULL,
	[GeometryOffsetZ] [float] NULL,
	[GeometryOffsetR] [float] NULL,
	[GeometryOffsetT] [float] NULL,
	[MachineMode] [nvarchar](50) NULL,
 CONSTRAINT [PK_Focas_ToolOffsetHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
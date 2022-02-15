/****** Object:  Table [dbo].[Focas_LiveData]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_LiveData](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[MachineStatus] [nvarchar](50) NULL,
	[MachineMode] [nvarchar](50) NULL,
	[ProgramNo] [nvarchar](100) NULL,
	[ToolNo] [int] NULL,
	[OffsetNo] [int] NULL,
	[SpindleStatus] [nvarchar](50) NULL,
	[SpindleSpeed] [bigint] NULL,
	[SpindleLoad] [decimal](18, 3) NULL,
	[Temperature] [decimal](18, 3) NULL,
	[SpindleTarque] [decimal](18, 3) NULL,
	[FeedRate] [decimal](18, 3) NULL,
	[AlarmNo] [int] NULL,
	[PowerOnTime] [float] NULL,
	[OperatingTime] [float] NULL,
	[CutTime] [float] NULL,
	[ServoLoad_XYZ] [nvarchar](500) NULL,
	[AxisPosition] [nvarchar](500) NULL,
	[ProgramBlock] [nvarchar](4000) NULL,
	[CNCTimeStamp] [datetime] NULL,
	[PartsCount] [int] NULL,
	[BatchTS] [datetime] NULL,
	[MachineUpDownStatus] [int] NULL,
	[MachineUpDownBatchTS] [datetime] NULL,
 CONSTRAINT [PK_Focas_LiveData] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Focas_LiveData] ADD  CONSTRAINT [DF_Focas_LiveData_PartsCount]  DEFAULT ((0)) FOR [PartsCount]
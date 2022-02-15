/****** Object:  Table [dbo].[Focas_ToolOffsetHistoryTemp]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_ToolOffsetHistoryTemp](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[MachineMode] [nvarchar](50) NULL,
	[ProgramNo] [nvarchar](50) NULL,
	[ToolNo] [int] NULL,
	[OffsetNo] [int] NULL,
	[WearOffsetX] [float] NULL,
	[WearOffsetZ] [float] NULL,
	[WearOffsetR] [float] NULL,
	[WearOffsetT] [float] NULL,
	[CNCTimeStamp] [datetime] NULL,
 CONSTRAINT [PK_Focas_ToolOffsetHistoryTemp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
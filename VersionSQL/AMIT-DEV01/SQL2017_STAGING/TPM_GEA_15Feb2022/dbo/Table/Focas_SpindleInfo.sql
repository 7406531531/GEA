/****** Object:  Table [dbo].[Focas_SpindleInfo]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_SpindleInfo](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineId] [nvarchar](50) NOT NULL,
	[CNCTimeStamp] [datetime] NOT NULL,
	[SpindleSpeed] [decimal](18, 0) NULL,
	[SpindleLoad] [decimal](18, 3) NULL,
	[Temperature] [decimal](18, 3) NULL,
	[FeedRate] [decimal](18, 3) NULL,
	[ProgramNo] [nvarchar](50) NULL,
	[ToolNo] [nvarchar](50) NULL,
	[SpindleTarque] [decimal](18, 3) NULL,
	[AxisNo] [nvarchar](5) NULL,
 CONSTRAINT [PK_Focas_SpindleInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
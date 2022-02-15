/****** Object:  Table [dbo].[Focas_WearOffsetCorrectionMaster]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_WearOffsetCorrectionMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MachineId] [nvarchar](50) NOT NULL,
	[ProgramNumber] [nvarchar](50) NOT NULL,
	[ToolNumber] [nvarchar](50) NOT NULL,
	[WearOffsetNumber] [nvarchar](50) NOT NULL,
	[OffsetLocation] [int] NOT NULL,
	[GaugeID] [nvarchar](50) NOT NULL,
	[DimensionId] [nvarchar](50) NOT NULL,
	[NominalDimension] [float] NOT NULL,
	[LowerLimit] [float] NOT NULL,
	[UpperLimit] [float] NOT NULL,
	[DefaultWearOffsetValue] [float] NOT NULL,
	[LastUpdatedTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Focas_WearOffsetCorrectionMaster] PRIMARY KEY CLUSTERED 
(
	[MachineId] ASC,
	[ProgramNumber] ASC,
	[ToolNumber] ASC,
	[WearOffsetNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Focas_WearOffsetCorrectionMaster] ADD  CONSTRAINT [DF__Focas_Wea__LastU__4C0144E4]  DEFAULT (getdate()) FOR [LastUpdatedTime]
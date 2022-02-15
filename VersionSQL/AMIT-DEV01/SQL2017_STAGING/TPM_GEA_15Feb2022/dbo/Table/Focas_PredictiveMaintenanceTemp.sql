/****** Object:  Table [dbo].[Focas_PredictiveMaintenanceTemp]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_PredictiveMaintenanceTemp](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineId] [nvarchar](50) NOT NULL,
	[AlarmNo] [int] NOT NULL,
	[TargetValue] [decimal](18, 2) NULL,
	[ActualValue] [decimal](18, 2) NULL,
	[TimeStamp] [datetime] NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[Focas_PredictiveMaintenanceTemp] ADD  CONSTRAINT [DF_Focas_PredictiveMaintenanceTemp_TimeStamp]  DEFAULT (getdate()) FOR [TimeStamp]
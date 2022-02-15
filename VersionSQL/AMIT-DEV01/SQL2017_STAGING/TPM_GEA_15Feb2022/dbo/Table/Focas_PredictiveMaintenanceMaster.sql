/****** Object:  Table [dbo].[Focas_PredictiveMaintenanceMaster]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_PredictiveMaintenanceMaster](
	[MTB] [nvarchar](50) NOT NULL,
	[AlarmNo] [int] NOT NULL,
	[AlarmDesc] [nvarchar](500) NOT NULL,
	[DurationType] [nvarchar](50) NULL,
	[DurationIn] [nvarchar](50) NULL,
	[TargetDLocation] [int] NOT NULL,
	[CurrentValueDLocation] [int] NOT NULL,
	[IsEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Focas_PredictiveMaintenance] PRIMARY KEY CLUSTERED 
(
	[MTB] ASC,
	[AlarmNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Focas_PredictiveMaintenanceMaster] ADD  CONSTRAINT [DF_Focas_PredictiveMaintenance_IsEnabled]  DEFAULT ((0)) FOR [IsEnabled]
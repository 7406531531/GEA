/****** Object:  Table [dbo].[Focas_WearOffsetCorrection]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_WearOffsetCorrection](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Focas_WearOffsetCorrectionID] [int] NOT NULL,
	[MeasuredDimension] [float] NOT NULL,
	[NewWearOffsetValue] [float] NOT NULL,
	[MeasuredTime] [datetime] NOT NULL,
	[WearoffsetValue] [float] NOT NULL,
	[Result] [nvarchar](1000) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[Focas_WearOffsetCorrection] ADD  CONSTRAINT [DF__Focas_Wea__Measu__4B0D20AB]  DEFAULT (getdate()) FOR [MeasuredTime]
/****** Object:  Table [dbo].[NoiseMeasurementFormulaMaster_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[NoiseMeasurementFormulaMaster_GEA](
	[MaterialID] [nvarchar](50) NULL,
	[FormulaSet] [nvarchar](50) NULL,
	[Dimension] [nvarchar](50) NULL,
	[Value] [float] NULL
) ON [PRIMARY]
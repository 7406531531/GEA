/****** Object:  Table [dbo].[HardnessTestMaster_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[HardnessTestMaster_GEA](
	[SlNo] [int] IDENTITY(1,1) NOT NULL,
	[MaterialNo] [nvarchar](50) NULL,
	[ConversionFactor] [nvarchar](50) NULL,
	[MinTensileStrength] [nvarchar](20) NULL,
	[MaxTensileStrength] [nvarchar](20) NULL
) ON [PRIMARY]
/****** Object:  Table [dbo].[AssemblyeTypeMaster_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[AssemblyeTypeMaster_GEA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[AssemblyType] [nvarchar](100) NULL,
	[MotorType] [nvarchar](50) NULL,
	[Voltage] [nvarchar](50) NULL,
	[Curent] [nvarchar](50) NULL,
	[Frequency] [nvarchar](50) NULL,
	[Power] [nvarchar](50) NULL,
	[Speed] [nvarchar](50) NULL,
	[CosValue] [nvarchar](50) NULL,
	[Efficiency] [nvarchar](50) NULL,
	[Bearing_Drive] [nvarchar](50) NULL,
	[Bearing_NonDrive] [nvarchar](50) NULL
) ON [PRIMARY]
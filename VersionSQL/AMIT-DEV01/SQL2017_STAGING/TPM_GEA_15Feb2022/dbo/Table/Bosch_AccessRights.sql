/****** Object:  Table [dbo].[Bosch_AccessRights]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Bosch_AccessRights](
	[PlantID] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[Flag] [bit] NULL,
	[Report] [nvarchar](200) NULL
) ON [PRIMARY]
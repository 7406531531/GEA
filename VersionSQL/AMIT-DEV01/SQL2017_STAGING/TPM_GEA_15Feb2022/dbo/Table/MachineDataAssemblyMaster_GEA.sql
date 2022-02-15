/****** Object:  Table [dbo].[MachineDataAssemblyMaster_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[MachineDataAssemblyMaster_GEA](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[ParameterID] [nvarchar](50) NULL,
	[SpecificationDT] [nvarchar](50) NULL
) ON [PRIMARY]
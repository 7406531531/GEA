/****** Object:  Table [dbo].[Focas_info]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_info](
	[MachineId] [nvarchar](1000) NOT NULL,
	[CNCData1] [nvarchar](1000) NULL,
	[LicType] [nvarchar](1000) NULL,
	[ExpDate] [datetime] NULL,
	[IsOEM] [bit] NULL
) ON [PRIMARY]
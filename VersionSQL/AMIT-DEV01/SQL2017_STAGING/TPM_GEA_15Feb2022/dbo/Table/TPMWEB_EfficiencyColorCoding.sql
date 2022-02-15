/****** Object:  Table [dbo].[TPMWEB_EfficiencyColorCoding]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[TPMWEB_EfficiencyColorCoding](
	[Type] [nvarchar](50) NOT NULL,
	[PEGreen] [bigint] NOT NULL,
	[AEGreen] [bigint] NOT NULL,
	[OEEGreen] [bigint] NOT NULL,
	[QEGreen] [bigint] NOT NULL,
	[PERed] [bigint] NOT NULL,
	[AERed] [bigint] NOT NULL,
	[OEERed] [bigint] NOT NULL,
	[QERed] [bigint] NOT NULL
) ON [PRIMARY]
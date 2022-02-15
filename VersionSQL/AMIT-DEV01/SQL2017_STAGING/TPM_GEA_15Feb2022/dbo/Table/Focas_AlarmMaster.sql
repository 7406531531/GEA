/****** Object:  Table [dbo].[Focas_AlarmMaster]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_AlarmMaster](
	[Slno] [int] NULL,
	[AlarmNo] [bigint] NULL,
	[Flag] [smallint] NULL,
	[FilePath] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Cause] [nvarchar](max) NULL,
	[Solution] [nvarchar](max) NULL,
	[MTB] [nvarchar](50) NULL,
	[AddressTag] [nvarchar](100) NULL,
	[AlarmAddress] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
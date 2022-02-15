/****** Object:  Table [dbo].[LoginInfo_NonMachining_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[LoginInfo_NonMachining_GEA](
	[DeviceID] [int] NULL,
	[Machine] [nvarchar](50) NULL,
	[Default] [nvarchar](50) NULL,
	[DeviceName] [nvarchar](max) NULL,
	[Message] [nvarchar](1000) NULL,
	[FormBackground] [nvarchar](50) NULL,
	[GridHeaderBackground] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
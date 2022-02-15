/****** Object:  Table [dbo].[DeviceCategory]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[DeviceCategory](
	[id] [int] NOT NULL,
	[DeviceName] [nvarchar](50) NOT NULL,
	[DeviceDescription] [nvarchar](200) NULL
) ON [PRIMARY]
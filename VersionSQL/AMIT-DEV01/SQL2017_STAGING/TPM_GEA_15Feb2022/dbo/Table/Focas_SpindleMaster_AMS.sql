/****** Object:  Table [dbo].[Focas_SpindleMaster_AMS]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_SpindleMaster_AMS](
	[Type] [nvarchar](50) NULL,
	[Baserpm] [float] NULL,
	[ShortTermPower] [float] NULL,
	[Continiouspower] [float] NULL,
	[Torque1] [float] NULL,
	[Torque2] [float] NULL,
	[Torque3] [float] NULL,
	[Torque4] [float] NULL,
	[Message1] [nvarchar](1000) NULL,
	[Message2] [nvarchar](1000) NULL,
	[Message3] [nvarchar](1000) NULL,
	[Message4] [nvarchar](1000) NULL,
	[ShortTermPower1] [float] NULL,
	[ShortTermPower2] [float] NULL,
	[ShortTermPower3] [float] NULL,
	[ShortTermPowerMsg1] [nvarchar](1000) NULL,
	[ShortTermPowerMsg2] [nvarchar](1000) NULL,
	[ShortTermPowerMsg3] [nvarchar](1000) NULL
) ON [PRIMARY]
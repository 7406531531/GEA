/****** Object:  Table [dbo].[MachineElectricalInfo]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[MachineElectricalInfo](
	[MachineID] [nvarchar](50) NULL,
	[TypeOfSpindleMotor] [nvarchar](50) NULL,
	[PowerRating] [float] NULL,
	[ContinuousRating] [float] NULL,
	[Torque] [float] NULL,
	[BaseSpeed1] [float] NULL,
	[BaseSpeed2] [float] NULL,
	[BaseSpeedForShortTerm] [float] NULL,
	[MotorPulleyDia in mm] [float] NULL,
	[SpindlePulleyDia in mm] [float] NULL
) ON [PRIMARY]
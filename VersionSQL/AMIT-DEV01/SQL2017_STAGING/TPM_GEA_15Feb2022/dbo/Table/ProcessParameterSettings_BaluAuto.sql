/****** Object:  Table [dbo].[ProcessParameterSettings_BaluAuto]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ProcessParameterSettings_BaluAuto](
	[idd] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](100) NULL,
	[ParameterID] [nvarchar](100) NULL,
	[DisplayHeader] [nvarchar](100) NULL,
	[PLCAddress] [nvarchar](100) NULL,
	[DataType] [nvarchar](100) NULL,
	[Unit] [nvarchar](100) NULL,
	[ShowUnit] [bit] NULL,
	[ShowdataDate] [bit] NULL,
	[GreenRange] [nvarchar](100) NULL,
	[YellowHigherRange] [nvarchar](100) NULL,
	[YellowLowerRange] [nvarchar](100) NULL,
	[RedHigherRange] [nvarchar](100) NULL,
	[RedLowerRange] [nvarchar](100) NULL,
	[Enabled] [bit] NULL,
	[DisplayOrder] [nvarchar](100) NULL,
	[DisplayTemplate] [nvarchar](100) NULL,
	[GreenHigherRange] [int] NULL,
	[GreenLowerRange] [int] NULL
) ON [PRIMARY]
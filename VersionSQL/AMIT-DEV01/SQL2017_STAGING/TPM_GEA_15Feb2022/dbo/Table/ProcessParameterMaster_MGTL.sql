/****** Object:  Table [dbo].[ProcessParameterMaster_MGTL]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ProcessParameterMaster_MGTL](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[ParameterID] [int] NULL,
	[ParameterName] [nvarchar](100) NULL,
	[MinValue] [nvarchar](50) NULL,
	[MaxValue] [nvarchar](50) NULL,
	[WarningValue] [nvarchar](50) NULL,
	[RedBit] [nvarchar](50) NULL,
	[Redvalue] [nvarchar](50) NULL,
	[Greenbit] [nvarchar](50) NULL,
	[GreenValue] [nvarchar](50) NULL,
	[YellowBit] [nvarchar](50) NULL,
	[YellowValue] [nvarchar](50) NULL,
	[Red1bit] [nvarchar](50) NULL,
	[Red1HValue] [nvarchar](50) NULL,
	[Red1LValue] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[TemplateType] [nvarchar](50) NULL,
	[IsVisible] [nvarchar](50) NULL,
	[SortOrder] [int] NULL,
	[ReadOnOperation] [nvarchar](50) NULL
) ON [PRIMARY]
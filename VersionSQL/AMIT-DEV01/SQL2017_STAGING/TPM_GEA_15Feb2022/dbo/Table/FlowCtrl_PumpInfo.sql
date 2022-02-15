/****** Object:  Table [dbo].[FlowCtrl_PumpInfo]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[FlowCtrl_PumpInfo](
	[SLNO] [bigint] IDENTITY(1,1) NOT NULL,
	[Model] [nvarchar](50) NOT NULL,
	[Interfaceid] [int] NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[Customer] [nvarchar](50) NOT NULL,
	[Speed] [int] NOT NULL,
	[CCRV] [int] NOT NULL,
	[RotationType] [nvarchar](50) NOT NULL,
	[TestingCycleStart] [int] NOT NULL,
	[TestingCycleEnd] [int] NOT NULL,
	[CycleIgnoreThreshold] [int] NOT NULL,
	[SpecifiedFlow] [float] NOT NULL,
	[CycleTime] [int] NOT NULL,
 CONSTRAINT [PK_FlowCtrl_PumpInfo] PRIMARY KEY CLUSTERED 
(
	[Model] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
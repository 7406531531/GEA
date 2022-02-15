/****** Object:  Table [dbo].[BalancingReportTransaction]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[BalancingReportTransaction](
	[ScrollNumber] [int] NULL,
	[Productionno] [nvarchar](50) NULL,
	[FabricationNo] [nvarchar](50) NULL,
	[SelectedDateAndTime] [datetime] NULL,
	[Model] [nvarchar](50) NULL,
	[P1_a] [nvarchar](50) NULL,
	[P1_b] [nvarchar](50) NULL,
	[P2_a] [nvarchar](50) NULL,
	[P2_b] [nvarchar](50) NULL,
	[Operator] [nvarchar](50) NULL,
	[AddingChecked] [bit] NULL,
	[RemovingChecked] [bit] NULL,
	[ConfirmedDateAndTime] [datetime] NULL,
	[Confirmed] [bit] NULL,
	[MeasuringSpeed] [nvarchar](50) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[BalancingReportTransaction] ADD  DEFAULT (getdate()) FOR [SelectedDateAndTime]
ALTER TABLE [dbo].[BalancingReportTransaction] ADD  DEFAULT ((0)) FOR [AddingChecked]
ALTER TABLE [dbo].[BalancingReportTransaction] ADD  DEFAULT ((0)) FOR [RemovingChecked]
ALTER TABLE [dbo].[BalancingReportTransaction] ADD  DEFAULT (getdate()) FOR [ConfirmedDateAndTime]
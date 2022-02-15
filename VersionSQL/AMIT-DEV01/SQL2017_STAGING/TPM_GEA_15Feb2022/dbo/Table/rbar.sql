/****** Object:  Table [dbo].[rbar]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[rbar](
	[ucl] [float] NULL,
	[lcl] [float] NULL,
	[mean] [float] NULL,
	[r] [float] NULL,
	[slno] [int] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[rbar] ADD  CONSTRAINT [DF_rbar_ucl]  DEFAULT ((0)) FOR [ucl]
ALTER TABLE [dbo].[rbar] ADD  CONSTRAINT [DF_rbar_lcl]  DEFAULT ((0)) FOR [lcl]
ALTER TABLE [dbo].[rbar] ADD  CONSTRAINT [DF_rbar_mean]  DEFAULT ((0)) FOR [mean]
ALTER TABLE [dbo].[rbar] ADD  CONSTRAINT [DF_rbar_r]  DEFAULT ((0)) FOR [r]
ALTER TABLE [dbo].[rbar] ADD  CONSTRAINT [DF_rbar_slno]  DEFAULT ((0)) FOR [slno]
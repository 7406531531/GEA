/****** Object:  Table [dbo].[controlconstants]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[controlconstants](
	[gpsize] [smallint] NULL,
	[a2] [float] NULL,
	[d2] [float] NULL,
	[d3] [float] NULL,
	[d4] [float] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[controlconstants] ADD  CONSTRAINT [DF_controlconstants_gpsize]  DEFAULT ((0)) FOR [gpsize]
ALTER TABLE [dbo].[controlconstants] ADD  CONSTRAINT [DF_controlconstants_a2]  DEFAULT ((0)) FOR [a2]
ALTER TABLE [dbo].[controlconstants] ADD  CONSTRAINT [DF_controlconstants_d2]  DEFAULT ((0)) FOR [d2]
ALTER TABLE [dbo].[controlconstants] ADD  CONSTRAINT [DF_controlconstants_d3]  DEFAULT ((0)) FOR [d3]
ALTER TABLE [dbo].[controlconstants] ADD  CONSTRAINT [DF_controlconstants_d4]  DEFAULT ((0)) FOR [d4]
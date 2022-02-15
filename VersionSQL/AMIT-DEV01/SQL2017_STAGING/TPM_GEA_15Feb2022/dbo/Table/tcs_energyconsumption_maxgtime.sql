/****** Object:  Table [dbo].[tcs_energyconsumption_maxgtime]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[tcs_energyconsumption_maxgtime](
	[machine] [nvarchar](50) NULL,
	[maxgtime] [datetime] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[tcs_energyconsumption_maxgtime] ADD  CONSTRAINT [DF__tcs_energ__maxgt__615C547D]  DEFAULT ('1900-01-01') FOR [maxgtime]
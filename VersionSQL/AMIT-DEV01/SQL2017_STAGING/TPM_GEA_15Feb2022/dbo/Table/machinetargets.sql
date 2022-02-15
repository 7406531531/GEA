/****** Object:  Table [dbo].[machinetargets]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[machinetargets](
	[financialyear] [nvarchar](50) NOT NULL,
	[machineid] [nvarchar](50) NOT NULL,
	[nmonth] [int] NOT NULL,
	[target] [bigint] NULL,
	[cmonth] [nvarchar](50) NULL,
 CONSTRAINT [PK_machinetargets] PRIMARY KEY CLUSTERED 
(
	[financialyear] ASC,
	[machineid] ASC,
	[nmonth] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[machinetargets] ADD  CONSTRAINT [DF_machinetargets_nmonth]  DEFAULT ((0)) FOR [nmonth]
ALTER TABLE [dbo].[machinetargets] ADD  CONSTRAINT [DF_machinetargets_target]  DEFAULT ((0)) FOR [target]
/****** Object:  Table [dbo].[financialyearinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[financialyearinformation](
	[financialyear] [nvarchar](50) NOT NULL,
	[datefrom] [smalldatetime] NULL,
	[dateto] [smalldatetime] NULL,
	[target] [float] NULL,
 CONSTRAINT [PK_financialyearinformation] PRIMARY KEY CLUSTERED 
(
	[financialyear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[financialyearinformation] ADD  CONSTRAINT [DF_financialyearinformation_target]  DEFAULT ((0)) FOR [target]
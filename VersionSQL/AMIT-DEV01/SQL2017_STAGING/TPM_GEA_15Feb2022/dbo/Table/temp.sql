/****** Object:  Table [dbo].[temp]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[temp](
	[tempid] [nvarchar](50) NOT NULL,
	[noofdays] [int] NULL,
	[noofrecords] [int] NULL,
 CONSTRAINT [PK_temp] PRIMARY KEY CLUSTERED 
(
	[tempid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[temp] ADD  CONSTRAINT [DF_temp_noofdays]  DEFAULT ((0)) FOR [noofdays]
ALTER TABLE [dbo].[temp] ADD  CONSTRAINT [DF_temp_noofrecords]  DEFAULT ((0)) FOR [noofrecords]
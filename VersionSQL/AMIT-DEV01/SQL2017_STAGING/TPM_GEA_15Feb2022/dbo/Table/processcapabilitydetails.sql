/****** Object:  Table [dbo].[processcapabilitydetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[processcapabilitydetails](
	[slno] [bigint] IDENTITY(1,1) NOT NULL,
	[testid] [nvarchar](50) NULL,
	[measuredvalue] [float] NULL,
 CONSTRAINT [PK_processcapabilitydetails] PRIMARY KEY CLUSTERED 
(
	[slno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[processcapabilitydetails] ADD  CONSTRAINT [DF_processcapabilitydetails_measuredvalue]  DEFAULT ((0)) FOR [measuredvalue]
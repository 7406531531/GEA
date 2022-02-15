/****** Object:  Table [dbo].[tmpprocesscapabilitydetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[tmpprocesscapabilitydetails](
	[slno] [int] NULL,
	[measuredvalue] [float] NULL,
	[sln] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tmpprocesscapabilitydetails] PRIMARY KEY CLUSTERED 
(
	[sln] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[tmpprocesscapabilitydetails] ADD  CONSTRAINT [DF_tmpprocesscapabilitydetails_slno]  DEFAULT ((0)) FOR [slno]
ALTER TABLE [dbo].[tmpprocesscapabilitydetails] ADD  CONSTRAINT [DF_tmpprocesscapabilitydetails_measuredvalue]  DEFAULT ((0)) FOR [measuredvalue]
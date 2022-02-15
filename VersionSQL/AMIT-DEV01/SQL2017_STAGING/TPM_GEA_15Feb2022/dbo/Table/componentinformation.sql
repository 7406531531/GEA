/****** Object:  Table [dbo].[componentinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[componentinformation](
	[componentid] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NULL,
	[customerid] [nvarchar](50) NULL,
	[basicvalue] [float] NULL,
	[InterfaceID] [nvarchar](16) NULL,
	[InputWeight] [float] NULL,
	[ForegingWeight] [float] NULL,
 CONSTRAINT [PK_componentinformation] PRIMARY KEY CLUSTERED 
(
	[componentid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[componentinformation] ADD  CONSTRAINT [DF_componentinformation_basicvalue]  DEFAULT ((0)) FOR [basicvalue]
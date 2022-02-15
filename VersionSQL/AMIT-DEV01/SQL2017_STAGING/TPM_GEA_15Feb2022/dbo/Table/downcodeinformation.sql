/****** Object:  Table [dbo].[downcodeinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[downcodeinformation](
	[downid] [nvarchar](50) NULL,
	[downno] [int] IDENTITY(1,1) NOT NULL,
	[downdescription] [nvarchar](100) NULL,
	[Catagory] [nvarchar](50) NULL,
	[interfaceid] [nvarchar](50) NULL,
	[availeffy] [smallint] NULL,
	[retpermchour] [smallint] NULL,
	[Threshold] [numeric](18, 0) NULL,
	[prodeffy] [smallint] NULL,
	[ThresholdfromCO] [int] NOT NULL,
	[SortOrder] [int] NULL,
	[Group1] [nvarchar](50) NULL,
	[Group2] [nvarchar](50) NULL,
 CONSTRAINT [PK_downcodeinformation] PRIMARY KEY CLUSTERED 
(
	[downno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[downcodeinformation] ADD  CONSTRAINT [DF_downcodeinformation_availeffy]  DEFAULT ((0)) FOR [availeffy]
ALTER TABLE [dbo].[downcodeinformation] ADD  CONSTRAINT [DF_downcodeinformation_retpermchour]  DEFAULT ((0)) FOR [retpermchour]
ALTER TABLE [dbo].[downcodeinformation] ADD  CONSTRAINT [DF__downcodei__prode__5441852A]  DEFAULT ((0)) FOR [prodeffy]
ALTER TABLE [dbo].[downcodeinformation] ADD  CONSTRAINT [DF__downcodei__Thres__5535A963]  DEFAULT ('0') FOR [ThresholdfromCO]
ALTER TABLE [dbo].[downcodeinformation]  WITH NOCHECK ADD  CONSTRAINT [FK_downcodeinformation_DownCategoryInformation] FOREIGN KEY([Catagory])
REFERENCES [dbo].[DownCategoryInformation] ([DownCategory])
ALTER TABLE [dbo].[downcodeinformation] CHECK CONSTRAINT [FK_downcodeinformation_DownCategoryInformation]
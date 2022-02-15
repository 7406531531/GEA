/****** Object:  Table [dbo].[Focas_UserDetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_UserDetails](
	[InsertID] [int] IDENTITY(1,1) NOT NULL,
	[UserDetails] [nvarchar](100) NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK__Focas_Us__836395B7F1C7121A] PRIMARY KEY CLUSTERED 
(
	[InsertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Focas_UserDetails] ADD  CONSTRAINT [DF__Focas_User__date__02133CD2]  DEFAULT (getdate()) FOR [date]
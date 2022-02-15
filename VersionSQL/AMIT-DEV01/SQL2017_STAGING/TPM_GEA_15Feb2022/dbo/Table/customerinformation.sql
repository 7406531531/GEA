/****** Object:  Table [dbo].[customerinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[customerinformation](
	[customerid] [nvarchar](50) NOT NULL,
	[customername] [nvarchar](100) NULL,
	[address1] [nvarchar](100) NULL,
	[place] [nvarchar](100) NULL,
	[state] [nvarchar](100) NULL,
	[country] [nvarchar](100) NULL,
	[pin] [nvarchar](100) NULL,
	[phone] [nvarchar](100) NULL,
	[email] [nvarchar](100) NULL,
	[contactperson] [nvarchar](100) NULL,
	[address2] [nvarchar](50) NULL,
 CONSTRAINT [PK_customerinformation] PRIMARY KEY CLUSTERED 
(
	[customerid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
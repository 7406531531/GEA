/****** Object:  Table [dbo].[machinemakeinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[machinemakeinformation](
	[machineid] [nvarchar](50) NOT NULL,
	[manufacturer] [nvarchar](100) NULL,
	[dateofmanufacture] [smalldatetime] NULL,
	[address] [nvarchar](100) NULL,
	[place] [nvarchar](100) NULL,
	[phone] [nvarchar](50) NULL,
	[contactperson] [nvarchar](100) NULL,
 CONSTRAINT [PK_machinemakeinformation] PRIMARY KEY CLUSTERED 
(
	[machineid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
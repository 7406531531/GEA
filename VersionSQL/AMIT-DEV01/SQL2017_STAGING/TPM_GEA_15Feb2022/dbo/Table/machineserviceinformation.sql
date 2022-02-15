/****** Object:  Table [dbo].[machineserviceinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[machineserviceinformation](
	[machineid] [nvarchar](50) NOT NULL,
	[servicedby] [nvarchar](100) NULL,
	[address1] [nvarchar](100) NULL,
	[address2] [nvarchar](100) NULL,
	[place] [nvarchar](100) NULL,
	[phone] [nvarchar](100) NULL,
	[contactperson] [nvarchar](100) NULL,
 CONSTRAINT [PK_machineserviceinformation] PRIMARY KEY CLUSTERED 
(
	[machineid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
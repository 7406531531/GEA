/****** Object:  Table [dbo].[programmanager]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[programmanager](
	[programid] [nvarchar](50) NOT NULL,
	[componentid] [nvarchar](50) NULL,
	[machineid] [nvarchar](50) NOT NULL,
	[updatedon] [smalldatetime] NULL,
	[operationno] [smallint] NULL,
	[programfile] [nvarchar](250) NULL,
	[Author] [nvarchar](50) NULL,
 CONSTRAINT [PK_Programmanager] PRIMARY KEY CLUSTERED 
(
	[programid] ASC,
	[machineid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[programmanager] ADD  CONSTRAINT [DF_programmanager_operationno]  DEFAULT ((0)) FOR [operationno]
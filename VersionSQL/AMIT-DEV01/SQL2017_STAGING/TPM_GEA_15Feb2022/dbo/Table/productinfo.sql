/****** Object:  Table [dbo].[productinfo]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[productinfo](
	[pc_serial_number] [nvarchar](250) NOT NULL,
	[productkey] [nvarchar](250) NULL,
	[productpassword] [nvarchar](250) NULL,
	[Type] [nvarchar](50) NOT NULL,
	[LogDate] [datetime] NULL,
	[EvalPeriod] [int] NULL,
 CONSTRAINT [PK_productinfo] PRIMARY KEY CLUSTERED 
(
	[pc_serial_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[productinfo] ADD  CONSTRAINT [DF_productinfo_Type]  DEFAULT (N'Standard') FOR [Type]
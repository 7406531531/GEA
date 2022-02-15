/****** Object:  Table [dbo].[workorderrejectiondetail]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[workorderrejectiondetail](
	[workorderno] [nvarchar](50) NULL,
	[rejectiondate] [smalldatetime] NULL,
	[employeeid] [nvarchar](50) NULL,
	[rejectionid] [nvarchar](50) NULL,
	[quantity] [float] NULL,
	[slno] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_workorderrejectiondetail] PRIMARY KEY CLUSTERED 
(
	[slno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[workorderrejectiondetail] ADD  CONSTRAINT [DF_workorderrejectiondetail_quantity]  DEFAULT ((0)) FOR [quantity]
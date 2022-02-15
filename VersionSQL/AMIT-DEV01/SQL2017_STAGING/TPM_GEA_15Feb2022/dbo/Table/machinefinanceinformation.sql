/****** Object:  Table [dbo].[machinefinanceinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[machinefinanceinformation](
	[machineid] [nvarchar](50) NOT NULL,
	[machineprice] [float] NULL,
	[financedby] [nvarchar](100) NULL,
	[address] [nvarchar](100) NULL,
	[repaymentfrom] [smalldatetime] NULL,
	[to] [smalldatetime] NULL,
	[installmentamount] [float] NULL,
	[noofinstallments] [int] NULL,
	[contactperson] [nvarchar](100) NULL,
 CONSTRAINT [PK_machinefinanceinformation] PRIMARY KEY CLUSTERED 
(
	[machineid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[machinefinanceinformation] ADD  CONSTRAINT [DF_machinefinanceinformation_machineprice]  DEFAULT ((0)) FOR [machineprice]
ALTER TABLE [dbo].[machinefinanceinformation] ADD  CONSTRAINT [DF_machinefinanceinformation_installmentamount]  DEFAULT ((0)) FOR [installmentamount]
ALTER TABLE [dbo].[machinefinanceinformation] ADD  CONSTRAINT [DF_machinefinanceinformation_noofinstallments]  DEFAULT ((0)) FOR [noofinstallments]
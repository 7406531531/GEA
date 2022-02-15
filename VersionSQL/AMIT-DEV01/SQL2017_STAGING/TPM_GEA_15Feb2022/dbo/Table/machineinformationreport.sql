/****** Object:  Table [dbo].[machineinformationreport]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[machineinformationreport](
	[machineid] [nvarchar](50) NULL,
	[description] [nvarchar](50) NULL,
	[mchrrate] [int] NULL,
	[machineprice] [int] NULL,
	[financedby] [nvarchar](50) NULL,
	[machinefinanceaddress] [nvarchar](50) NULL,
	[repaymentfrom] [nvarchar](50) NULL,
	[to] [nvarchar](50) NULL,
	[installmentamount] [int] NULL,
	[noofinstallments] [int] NULL,
	[financecontactperson] [nvarchar](50) NULL,
	[manufacturer] [nvarchar](50) NULL,
	[dateofmanufacture] [smalldatetime] NULL,
	[machinemakeaddress] [nvarchar](50) NULL,
	[machinemakeplace] [nvarchar](50) NULL,
	[machinemakephone] [int] NULL,
	[makecontactperson] [nvarchar](50) NULL,
	[machineserviceservicedby] [nvarchar](50) NULL,
	[machineserviceaddress1] [nvarchar](50) NULL,
	[machineserviceaddress2] [nvarchar](50) NULL,
	[machineserviceplace] [nvarchar](50) NULL,
	[machineservicephone] [nvarchar](50) NULL,
	[machineservicecontactperson] [nvarchar](50) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[machineinformationreport] ADD  CONSTRAINT [DF_machineinformationreport_mchrrate]  DEFAULT ((0)) FOR [mchrrate]
ALTER TABLE [dbo].[machineinformationreport] ADD  CONSTRAINT [DF_machineinformationreport_machineprice]  DEFAULT ((0)) FOR [machineprice]
ALTER TABLE [dbo].[machineinformationreport] ADD  CONSTRAINT [DF_machineinformationreport_installmentamount]  DEFAULT ((0)) FOR [installmentamount]
ALTER TABLE [dbo].[machineinformationreport] ADD  CONSTRAINT [DF_machineinformationreport_noofinstallments]  DEFAULT ((0)) FOR [noofinstallments]
ALTER TABLE [dbo].[machineinformationreport] ADD  CONSTRAINT [DF_machineinformationreport_machinemakephone]  DEFAULT ((0)) FOR [machinemakephone]
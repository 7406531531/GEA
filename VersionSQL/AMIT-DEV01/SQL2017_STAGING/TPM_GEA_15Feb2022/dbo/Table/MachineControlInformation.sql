/****** Object:  Table [dbo].[MachineControlInformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[MachineControlInformation](
	[MachineId] [nvarchar](50) NOT NULL,
	[ControlName] [nvarchar](50) NULL,
	[pStartId] [nvarchar](10) NULL,
	[pEndId] [nvarchar](10) NULL,
	[FileNameFrom] [int] NULL,
	[ReceiveAtMachineFilePath] [nvarchar](255) NULL,
	[SentFromMachineFilePath] [nvarchar](255) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[MachineControlInformation] ADD  CONSTRAINT [defaultpath_receive]  DEFAULT ('C:\Program files\TPM-Trak\Programs') FOR [ReceiveAtMachineFilePath]
ALTER TABLE [dbo].[MachineControlInformation] ADD  CONSTRAINT [defaultpath_sent]  DEFAULT ('C:\Program files\TPM-Trak\Programs') FOR [SentFromMachineFilePath]
ALTER TABLE [dbo].[MachineControlInformation]  WITH CHECK ADD  CONSTRAINT [FK_MachineControlInformation_ControlInformation] FOREIGN KEY([ControlName])
REFERENCES [dbo].[ControlInformation] ([ControlName])
ALTER TABLE [dbo].[MachineControlInformation] CHECK CONSTRAINT [FK_MachineControlInformation_ControlInformation]
ALTER TABLE [dbo].[MachineControlInformation]  WITH CHECK ADD  CONSTRAINT [FK_MachineControlInformation_machineinformation] FOREIGN KEY([MachineId])
REFERENCES [dbo].[machineinformation] ([machineid])
ALTER TABLE [dbo].[MachineControlInformation] CHECK CONSTRAINT [FK_MachineControlInformation_machineinformation]
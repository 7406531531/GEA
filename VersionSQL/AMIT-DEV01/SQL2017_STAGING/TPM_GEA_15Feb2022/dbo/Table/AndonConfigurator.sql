/****** Object:  Table [dbo].[AndonConfigurator]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[AndonConfigurator](
	[MachineID] [nvarchar](50) NOT NULL,
	[Threshold] [int] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[AndonConfigurator]  WITH NOCHECK ADD  CONSTRAINT [FK_AndonConfigurator_machineinformation] FOREIGN KEY([MachineID])
REFERENCES [dbo].[machineinformation] ([machineid])
ALTER TABLE [dbo].[AndonConfigurator] CHECK CONSTRAINT [FK_AndonConfigurator_machineinformation]
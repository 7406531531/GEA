/****** Object:  Table [dbo].[ProgramMachine]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ProgramMachine](
	[ProgramFileName] [nvarchar](50) NOT NULL,
	[MachineID] [nvarchar](50) NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[ProgramMachine]  WITH NOCHECK ADD  CONSTRAINT [FK_ProgramMachine_DNCprograms] FOREIGN KEY([ProgramFileName])
REFERENCES [dbo].[DNCprograms] ([ProgramFileName])
ALTER TABLE [dbo].[ProgramMachine] CHECK CONSTRAINT [FK_ProgramMachine_DNCprograms]
ALTER TABLE [dbo].[ProgramMachine]  WITH NOCHECK ADD  CONSTRAINT [FK_ProgramMachine_machineinformation] FOREIGN KEY([MachineID])
REFERENCES [dbo].[machineinformation] ([machineid])
ALTER TABLE [dbo].[ProgramMachine] CHECK CONSTRAINT [FK_ProgramMachine_machineinformation]
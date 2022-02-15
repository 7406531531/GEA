/****** Object:  Table [dbo].[PlantMachine]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[PlantMachine](
	[PlantID] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[FromTime] [datetime] NULL,
	[ToTime] [datetime] NULL,
	[SlNo] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[PlantMachine]  WITH CHECK ADD  CONSTRAINT [FK_PlantMachine_PlantInformation1] FOREIGN KEY([PlantID])
REFERENCES [dbo].[PlantInformation] ([PlantID])
ALTER TABLE [dbo].[PlantMachine] CHECK CONSTRAINT [FK_PlantMachine_PlantInformation1]
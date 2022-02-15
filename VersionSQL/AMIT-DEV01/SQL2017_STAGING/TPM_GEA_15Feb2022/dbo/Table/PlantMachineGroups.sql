/****** Object:  Table [dbo].[PlantMachineGroups]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[PlantMachineGroups](
	[PlantID] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[GroupID] [nvarchar](50) NULL,
	[GroupOrder] [int] NULL,
	[description] [nvarchar](100) NULL,
	[EndOfLineMachine] [nvarchar](50) NULL,
	[EndOfGroupMachine] [nvarchar](50) NULL,
	[MachineSequence] [int] NULL
) ON [PRIMARY]
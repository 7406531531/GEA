/****** Object:  Table [dbo].[SPC_Characteristic_Transaction]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[SPC_Characteristic_Transaction](
	[MachineID] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[PartName] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NOT NULL,
	[ToolNumber] [int] NULL,
	[Code] [nvarchar](50) NULL,
	[Diameter] [nvarchar](50) NOT NULL,
	[LSL] [float] NULL,
	[USL] [float] NULL,
	[SpecificationMean] [float] NULL,
	[PartInterfaceId] [nvarchar](50) NULL,
	[OpnInterfaceId] [nvarchar](50) NULL,
	[IsProcessed] [bit] NULL,
	[ReceivedTimeStamp] [datetime] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[SPC_Characteristic_Transaction] ADD  DEFAULT ((0)) FOR [IsProcessed]
/****** Object:  Table [dbo].[MOScheduleTemp]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[MOScheduleTemp](
	[MONumber] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[PartID] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NULL,
	[Quantity] [nvarchar](50) NULL,
	[DateOfRequirement] [datetime] NULL,
	[MOStatus] [nvarchar](50) NULL,
	[FileName] [nvarchar](1000) NULL,
	[FileModifiedDate] [datetime] NULL,
	[Status] [nvarchar](50) NULL,
	[LinkNo] [nvarchar](50) NULL,
	[DrawingNumber] [nvarchar](1000) NULL,
	[ProgramNumber] [nvarchar](1000) NULL,
	[ControlPlanning] [nvarchar](1000) NULL,
	[MOModifiedDate] [datetime] NULL,
	[UpdatedTS] [datetime] NULL,
	[ProjectNumber] [nvarchar](50) NULL,
	[OpnDescription] [nvarchar](100) NULL,
	[ProcessSheet] [nvarchar](50) NULL
) ON [PRIMARY]
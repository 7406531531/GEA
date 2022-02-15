/****** Object:  Table [dbo].[ProgramUploadToMachine]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ProgramUploadToMachine](
	[MachineID] [nvarchar](50) NOT NULL,
	[ProgramType] [nvarchar](50) NOT NULL,
	[ProgramName] [nvarchar](50) NOT NULL,
	[ComponentID] [nvarchar](50) NULL,
	[OperationNo] [int] NULL,
	[TimeStamp] [datetime] NOT NULL,
	[EmployeeID] [nvarchar](50) NULL
) ON [PRIMARY]
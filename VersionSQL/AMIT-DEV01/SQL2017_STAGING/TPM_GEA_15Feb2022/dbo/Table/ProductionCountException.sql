/****** Object:  Table [dbo].[ProductionCountException]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ProductionCountException](
	[MachineID] [nvarchar](50) NULL,
	[ComponentID] [nvarchar](50) NULL,
	[OperationNo] [int] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[IdealCount] [int] NULL,
	[ActualCount] [int] NULL,
	[SlNo] [numeric](19, 0) IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
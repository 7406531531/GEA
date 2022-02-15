/****** Object:  Table [dbo].[JohnCrane_EventDetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[JohnCrane_EventDetails](
	[SlNo] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NULL,
	[WorkOrderNo] [nvarchar](50) NULL,
	[EventID] [int] NULL,
	[Quantity] [int] NULL,
	[EventTS] [datetime] NULL,
	[EventDate] [datetime] NULL
) ON [PRIMARY]
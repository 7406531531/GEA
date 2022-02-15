/****** Object:  Table [dbo].[MachineAlarmInformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[MachineAlarmInformation](
	[AlarmType] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[AlarmCategory] [nvarchar](50) NULL,
	[AlarmNumber] [decimal](18, 2) NULL,
	[AlarmDescription] [nvarchar](100) NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[AlarmNumber_Binary] [decimal](18, 2) NULL
) ON [PRIMARY]
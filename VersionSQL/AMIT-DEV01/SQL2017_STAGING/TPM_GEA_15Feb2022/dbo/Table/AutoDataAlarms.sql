/****** Object:  Table [dbo].[AutoDataAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[AutoDataAlarms](
	[MachineID] [nvarchar](10) NULL,
	[AlarmNumber] [decimal](18, 2) NULL,
	[Alarmtime] [datetime] NULL,
	[RecordType] [tinyint] NULL,
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Target] [int] NULL,
	[Actual] [int] NULL,
 CONSTRAINT [PK_MachineAlarms] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
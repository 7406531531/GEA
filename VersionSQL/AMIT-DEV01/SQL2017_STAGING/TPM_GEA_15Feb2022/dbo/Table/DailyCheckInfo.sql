/****** Object:  Table [dbo].[DailyCheckInfo]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[DailyCheckInfo](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[Role] [nvarchar](50) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[DailyCheckInfo] ADD  DEFAULT (getdate()) FOR [UpdatedTS]
ALTER TABLE [dbo].[DailyCheckInfo] ADD  DEFAULT (getdate()) FOR [Date]
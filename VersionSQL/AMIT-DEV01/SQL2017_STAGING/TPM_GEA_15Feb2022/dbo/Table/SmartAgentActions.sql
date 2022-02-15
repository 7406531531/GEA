/****** Object:  Table [dbo].[SmartAgentActions]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[SmartAgentActions](
	[LogFile] [nvarchar](200) NULL,
	[SmtpServer] [nvarchar](100) NULL,
	[SmtpPortNo] [nvarchar](50) NULL,
	[UserId] [nvarchar](100) NULL,
	[Pwd] [nvarchar](100) NULL,
	[SMSPortNO] [nvarchar](50) NULL,
	[SMSSettings] [nvarchar](50) NULL,
	[PIPortNO] [nvarchar](50) NULL,
	[PISettings] [nvarchar](50) NULL,
	[SmartAgentSW_TimerInterval] [int] NULL,
	[SmartAgentUD_TimerInterval] [int] NULL,
	[UDT_ReadDelay] [smallint] NULL,
	[LampColor_If_NoData] [smallint] NULL,
	[Combine_GsmMsg_Y_N] [bit] NULL,
	[ResendMinutes] [int] NULL,
	[HostName] [nvarchar](50) NULL,
	[NextRunTime_Hourly] [datetime] NULL,
	[MinuteMessage] [nvarchar](50) NULL,
	[MinMsgVal] [int] NULL,
	[SMSFlowControl] [nvarchar](50) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[SmartAgentActions] ADD  CONSTRAINT [DF_SmartAgentActions_UDT_ReadDelay]  DEFAULT ((0)) FOR [UDT_ReadDelay]
ALTER TABLE [dbo].[SmartAgentActions] ADD  CONSTRAINT [DF_SmartAgentActions_LampColor_If_NoData]  DEFAULT ((0)) FOR [LampColor_If_NoData]
ALTER TABLE [dbo].[SmartAgentActions] ADD  CONSTRAINT [DF_SmartAgentActions_Combine_GsmMsg_Y_N]  DEFAULT ((0)) FOR [Combine_GsmMsg_Y_N]
ALTER TABLE [dbo].[SmartAgentActions] ADD  CONSTRAINT [AddResendMinutes]  DEFAULT ((120)) FOR [ResendMinutes]
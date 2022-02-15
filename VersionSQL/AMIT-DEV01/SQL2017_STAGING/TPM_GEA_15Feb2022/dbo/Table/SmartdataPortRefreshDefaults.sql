/****** Object:  Table [dbo].[SmartdataPortRefreshDefaults]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[SmartdataPortRefreshDefaults](
	[ID] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[port_refresh_interval_1] [decimal](18, 0) NULL,
	[port_refresh_interval_2] [decimal](18, 0) NULL,
	[port_refresh_interval_3] [decimal](18, 0) NULL,
	[port_refresh_minute_1] [varchar](50) NULL,
	[port_refresh_minute_2] [varchar](50) NULL,
	[port_refresh_minute_3] [varchar](50) NULL,
	[port_refresh_minute_4] [varchar](50) NULL,
	[wait_after_open] [varchar](1) NULL,
	[wait_after_close] [varchar](1) NULL,
	[CheckDupRec] [smallint] NULL,
	[errorprogramnumber] [nvarchar](20) NOT NULL,
	[waitforprogramsendtimer] [int] NOT NULL,
	[RunFromScript] [nvarchar](4) NULL,
	[SplitPalletRecord] [varchar](1) NULL,
	[SupportsICDnDowns] [varchar](1) NULL,
	[TPMStrings_Y_N] [varchar](1) NULL,
	[SDrestart1] [datetime] NULL,
	[SDrestart2] [datetime] NULL,
	[SDsleep] [tinyint] NULL,
	[SDautorestart] [bit] NULL,
	[SDDeviceRestart] [bit] NULL,
	[SDDeviceRestart_freq] [int] NULL,
	[SDHost] [nvarchar](50) NULL,
	[GroupSeperator1] [nvarchar](2) NULL,
	[GroupSeperator2] [nvarchar](2) NULL,
	[OperatorGrouping] [varchar](1) NULL,
	[STCSRestart1] [datetime] NULL,
	[STCSRestart2] [datetime] NULL,
	[WorkOrder] [nvarchar](1) NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__port___7908F585]  DEFAULT ((60000)) FOR [port_refresh_interval_1]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__port___79FD19BE]  DEFAULT ((10000)) FOR [port_refresh_interval_2]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__port___7AF13DF7]  DEFAULT ((1000)) FOR [port_refresh_interval_3]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__port___7BE56230]  DEFAULT ('no') FOR [port_refresh_minute_1]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__port___7CD98669]  DEFAULT ('no') FOR [port_refresh_minute_2]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__port___7DCDAAA2]  DEFAULT ((30)) FOR [port_refresh_minute_3]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__port___7EC1CEDB]  DEFAULT ((0)) FOR [port_refresh_minute_4]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__wait___7FB5F314]  DEFAULT ('y') FOR [wait_after_open]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__wait___00AA174D]  DEFAULT ('y') FOR [wait_after_close]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__Check__019E3B86]  DEFAULT ((0)) FOR [CheckDupRec]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__error__02925FBF]  DEFAULT ((9999)) FOR [errorprogramnumber]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__waitf__038683F8]  DEFAULT ((10000)) FOR [waitforprogramsendtimer]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF_SmartdataPortRefreshDefaults_SplitPalletRecord]  DEFAULT ('y') FOR [SplitPalletRecord]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF_SmartdataPortRefreshDefaults_SupportsICDnDowns]  DEFAULT ('y') FOR [SupportsICDnDowns]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__SDHos__0662F0A3]  DEFAULT ('Pcthost') FOR [SDHost]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__Group__075714DC]  DEFAULT (':') FOR [GroupSeperator1]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__Group__084B3915]  DEFAULT ('/') FOR [GroupSeperator2]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__Opera__093F5D4E]  DEFAULT ('N') FOR [OperatorGrouping]
ALTER TABLE [dbo].[SmartdataPortRefreshDefaults] ADD  CONSTRAINT [DF__Smartdata__WorkO__0A338187]  DEFAULT ('N') FOR [WorkOrder]
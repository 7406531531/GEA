/****** Object:  Table [dbo].[Alert_Notification_History]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Alert_Notification_History](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[RuleID] [nvarchar](50) NOT NULL,
	[MachineID] [nvarchar](max) NULL,
	[UserID] [nvarchar](50) NULL,
	[AlertType] [nvarchar](50) NOT NULL,
	[SMSEnabled] [bit] NULL,
	[EmailEnabled] [bit] NULL,
	[CreatedTime] [datetime] NULL,
	[Subject] [nvarchar](max) NULL,
	[BodyMessage] [nvarchar](max) NULL,
	[AttachmentPath] [nvarchar](max) NULL,
	[EmailTo] [nvarchar](max) NULL,
	[EmailCC] [nvarchar](max) NULL,
	[MobileNo] [nvarchar](max) NULL,
	[SendAfterTime] [datetime] NULL,
	[ExpiryDate] [datetime] NULL,
	[SentTime] [datetime] NULL,
	[Status] [tinyint] NULL,
	[RetryCount] [int] NULL,
	[ErrorMsg] [nvarchar](max) NULL,
	[AlertStartTS] [datetime] NULL,
	[AlertEndTS] [datetime] NULL,
	[EmailStatus] [tinyint] NULL,
	[ChatID] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
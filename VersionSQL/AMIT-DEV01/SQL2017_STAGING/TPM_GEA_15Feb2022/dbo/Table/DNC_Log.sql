/****** Object:  Table [dbo].[DNC_Log]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[DNC_Log](
	[idd] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NULL,
	[IPAddress] [nvarchar](50) NULL,
	[ClientName] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[LogMessage] [nvarchar](1000) NULL,
	[ErrorNumber] [nvarchar](50) NULL,
	[MessageType] [nvarchar](50) NULL,
	[TimeStamp] [datetime] NULL,
 CONSTRAINT [PK_DNC_Log] PRIMARY KEY CLUSTERED 
(
	[idd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
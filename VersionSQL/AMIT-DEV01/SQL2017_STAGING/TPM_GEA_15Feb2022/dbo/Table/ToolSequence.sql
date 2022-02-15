/****** Object:  Table [dbo].[ToolSequence]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ToolSequence](
	[MachineID] [nvarchar](50) NOT NULL,
	[ComponentID] [nvarchar](50) NOT NULL,
	[OperationNo] [int] NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[ToolNo] [nvarchar](10) NULL,
	[IdealUsage] [int] NULL,
	[Offset] [nvarchar](5) NULL,
	[ToolDescription] [nvarchar](30) NULL,
	[ToolHolder] [nvarchar](30) NULL,
	[RPM] [int] NULL,
	[Notes] [nvarchar](100) NULL,
	[targetcount] [int] NULL,
	[downcode] [nvarchar](50) NULL,
 CONSTRAINT [PK_ToolSequence] PRIMARY KEY CLUSTERED 
(
	[MachineID] ASC,
	[ComponentID] ASC,
	[OperationNo] ASC,
	[SequenceNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
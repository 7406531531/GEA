/****** Object:  Table [dbo].[Focas_ToolLife]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_ToolLife](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[ComponentID] [nvarchar](50) NOT NULL,
	[OperationID] [nvarchar](50) NOT NULL,
	[ToolNo] [nvarchar](50) NOT NULL,
	[ToolActual] [int] NOT NULL,
	[ToolTarget] [int] NOT NULL,
	[SpindleType] [int] NOT NULL,
	[ProgramNo] [int] NOT NULL,
	[CNCTimeStamp] [datetime] NOT NULL,
	[ToolUseOrderNumber] [int] NULL,
	[ToolInfo] [int] NULL,
	[PartsCount] [int] NULL,
	[ChangeReason] [int] NULL,
 CONSTRAINT [PK_Focas_ToolActTrg] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
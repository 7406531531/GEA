/****** Object:  Table [dbo].[FlowCtrl_MachineInfo]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[FlowCtrl_MachineInfo](
	[Machineid] [nvarchar](50) NOT NULL,
	[IPAddress] [nvarchar](50) NOT NULL,
	[Interfaceid] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Port] [int] NOT NULL,
	[FlowDataEnabled] [bit] NOT NULL,
	[DAPEnabled] [smallint] NOT NULL,
 CONSTRAINT [PK_FlowCtrl_MachineInfo] PRIMARY KEY CLUSTERED 
(
	[Machineid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[FlowCtrl_MachineInfo] ADD  CONSTRAINT [DF_FlowCtrl_MachineInfo_DAPEnabled]  DEFAULT ((1)) FOR [DAPEnabled]
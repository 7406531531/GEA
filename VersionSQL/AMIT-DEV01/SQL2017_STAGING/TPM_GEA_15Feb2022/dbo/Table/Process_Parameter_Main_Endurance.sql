/****** Object:  Table [dbo].[Process_Parameter_Main_Endurance]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Process_Parameter_Main_Endurance](
	[Slno] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineId] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[Cycle] [int] NULL,
	[Status] [int] NULL,
	[Lo_V] [float] NULL,
	[Hi_V] [float] NULL,
	[V_rise] [int] NULL,
	[Intensify] [int] NULL,
	[P_rise] [int] NULL,
	[Biscuit_Thick] [int] NULL,
	[Cast_Pressure] [int] NULL,
	[StatusFlag] [bit] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[Process_Parameter_Main_Endurance] ADD  DEFAULT ((0)) FOR [StatusFlag]
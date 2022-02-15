/****** Object:  Table [dbo].[ShiftProductionDetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ShiftProductionDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[pDate] [datetime] NOT NULL,
	[Shift] [nvarchar](20) NOT NULL,
	[PlantID] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[ComponentID] [nvarchar](50) NOT NULL,
	[OperationNo] [int] NULL,
	[OperatorID] [nvarchar](50) NOT NULL,
	[Prod_Qty] [float] NULL,
	[Sum_of_ActCycleTime] [float] NULL,
	[Sum_of_ActLoadUnload] [float] NULL,
	[CO_StdMachiningTime] [float] NULL,
	[CO_StdLoadUnload] [float] NULL,
	[Price] [float] NULL,
	[Repeat_Cycles] [int] NULL,
	[Dummy_Cycles] [int] NULL,
	[Rework_Performed] [int] NULL,
	[Marked_for_Rework] [int] NULL,
	[SubOperation] [int] NULL,
	[ActMachiningTime_Type12] [float] NULL,
	[ActLoadUnload_Type12] [float] NULL,
	[MaxMachiningTime] [float] NULL,
	[MinMachiningTime] [float] NULL,
	[MaxLoadUnloadTime] [float] NULL,
	[MinLoadUnloadTime] [float] NULL,
	[AcceptedParts] [float] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[WorkOrderNumber] [nvarchar](50) NOT NULL,
	[MachinewiseOwner] [nvarchar](50) NULL,
	[CriticalMachineEnabled] [bit] NULL,
	[GroupID] [nvarchar](50) NULL,
	[FinishedOperation] [int] NULL,
	[PDT] [float] NULL,
 CONSTRAINT [PK_ShiftProductionDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF_ShiftProductionDetails_Price]  DEFAULT ((1)) FOR [Price]
ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF_ShiftProductionDetails_Repeat_Cycles]  DEFAULT ((0)) FOR [Repeat_Cycles]
ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF_ShiftProductionDetails_Dummy_Cycles]  DEFAULT ((0)) FOR [Dummy_Cycles]
ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF_ShiftProductionDetails_Rework_Performed]  DEFAULT ((0)) FOR [Rework_Performed]
ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF_ShiftProductionDetails_Marked_for_Rework]  DEFAULT ((0)) FOR [Marked_for_Rework]
ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF_ShiftProductionDetails_SubOperation]  DEFAULT ((1)) FOR [SubOperation]
ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF__ShiftProd__Updat__6E8B6712]  DEFAULT ('pct') FOR [UpdatedBy]
ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF__ShiftProd__Updat__6F7F8B4B]  DEFAULT (getdate()) FOR [UpdatedTS]
ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF__ShiftProd__WorkO__7073AF84]  DEFAULT ('0') FOR [WorkOrderNumber]
ALTER TABLE [dbo].[ShiftProductionDetails] ADD  CONSTRAINT [DF__ShiftProd__Finis__44AB0736]  DEFAULT ((0)) FOR [FinishedOperation]
/****** Object:  Table [dbo].[ShiftReworkDetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ShiftReworkDetails](
	[ID] [bigint] NULL,
	[Rework_Qty] [int] NULL,
	[Rework_Reason] [nvarchar](150) NULL,
	[Slno] [bigint] IDENTITY(1,1) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[ShiftReworkDetails] ADD  CONSTRAINT [DF_ShiftReworkDetails_Rejection_Qty]  DEFAULT ((0)) FOR [Rework_Qty]
ALTER TABLE [dbo].[ShiftReworkDetails] ADD  CONSTRAINT [DF__ShiftRewo__Updat__689D8392]  DEFAULT ('pct') FOR [UpdatedBy]
ALTER TABLE [dbo].[ShiftReworkDetails] ADD  CONSTRAINT [DF__ShiftRewo__Updat__6991A7CB]  DEFAULT (getdate()) FOR [UpdatedTS]
ALTER TABLE [dbo].[ShiftReworkDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_ShiftReworkDetails_ShiftProductionDetails] FOREIGN KEY([ID])
REFERENCES [dbo].[ShiftProductionDetails] ([ID])
ALTER TABLE [dbo].[ShiftReworkDetails] CHECK CONSTRAINT [FK_ShiftReworkDetails_ShiftProductionDetails]
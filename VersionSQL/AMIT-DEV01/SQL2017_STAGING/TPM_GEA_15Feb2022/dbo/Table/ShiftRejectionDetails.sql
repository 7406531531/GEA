/****** Object:  Table [dbo].[ShiftRejectionDetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ShiftRejectionDetails](
	[ID] [bigint] NULL,
	[Rejection_Qty] [int] NULL,
	[Rejection_Reason] [nvarchar](150) NULL,
	[Slno] [bigint] IDENTITY(1,1) NOT NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[ShiftRejectionDetails] ADD  CONSTRAINT [DF_ShiftRejectionDetails_Rejection_Qty]  DEFAULT ((0)) FOR [Rejection_Qty]
ALTER TABLE [dbo].[ShiftRejectionDetails] ADD  CONSTRAINT [DF__ShiftReje__Updat__65C116E7]  DEFAULT ('pct') FOR [UpdatedBy]
ALTER TABLE [dbo].[ShiftRejectionDetails] ADD  CONSTRAINT [DF__ShiftReje__Updat__66B53B20]  DEFAULT (getdate()) FOR [UpdatedTS]
ALTER TABLE [dbo].[ShiftRejectionDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_ShiftRejectionDetails_ShiftProductionDetails] FOREIGN KEY([ID])
REFERENCES [dbo].[ShiftProductionDetails] ([ID])
ALTER TABLE [dbo].[ShiftRejectionDetails] CHECK CONSTRAINT [FK_ShiftRejectionDetails_ShiftProductionDetails]
/****** Object:  Table [dbo].[ToolTransaction]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ToolTransaction](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[ToolCategory] [nvarchar](50) NOT NULL,
	[ToolId] [nvarchar](50) NOT NULL,
	[PONumber] [nvarchar](50) NOT NULL,
	[TransactionDate] [datetime] NULL,
	[Quantity] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[LoginUser] [nvarchar](50) NULL,
	[Remarks] [nvarchar](100) NULL,
 CONSTRAINT [PK_ToolTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ToolTransaction]  WITH NOCHECK ADD  CONSTRAINT [FK_ToolTransaction_ToolStockManagement] FOREIGN KEY([ToolCategory], [ToolId], [PONumber])
REFERENCES [dbo].[ToolStockManagement] ([ToolCategory], [ToolID], [PONumber])
ALTER TABLE [dbo].[ToolTransaction] CHECK CONSTRAINT [FK_ToolTransaction_ToolStockManagement]
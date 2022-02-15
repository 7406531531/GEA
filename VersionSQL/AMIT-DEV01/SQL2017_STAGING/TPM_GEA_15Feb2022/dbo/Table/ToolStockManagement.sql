/****** Object:  Table [dbo].[ToolStockManagement]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ToolStockManagement](
	[ToolCategory] [nvarchar](50) NOT NULL,
	[ToolID] [nvarchar](50) NOT NULL,
	[PONumber] [nvarchar](50) NOT NULL,
	[PurchaseDate] [datetime] NULL,
	[PurchaseQuantity] [int] NULL,
	[InStores-Good] [int] NULL,
	[Instores-Used] [int] NULL,
	[InShop] [int] NULL,
 CONSTRAINT [PK_ToolStockManagement] PRIMARY KEY CLUSTERED 
(
	[ToolCategory] ASC,
	[ToolID] ASC,
	[PONumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
/****** Object:  Table [dbo].[ItemsReceivedFromVendor]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ItemsReceivedFromVendor](
	[VendorName] [nvarchar](50) NOT NULL,
	[OrderNumber] [nvarchar](50) NOT NULL,
	[LineItem] [nvarchar](50) NOT NULL,
	[DCnumber] [nvarchar](50) NOT NULL,
	[VendorDCnumber] [nvarchar](50) NOT NULL,
	[VendorDCdate] [datetime] NULL,
	[TotalQuantity] [int] NULL,
	[AcceptedQuantity] [int] NULL,
	[RejectedQuantity] [int] NULL,
	[ReworkQuantity] [int] NULL,
	[User] [nvarchar](50) NULL,
	[Remarks] [nvarchar](100) NULL,
 CONSTRAINT [PK_ItemsReceivedFromVendor] PRIMARY KEY CLUSTERED 
(
	[VendorName] ASC,
	[OrderNumber] ASC,
	[LineItem] ASC,
	[DCnumber] ASC,
	[VendorDCnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ItemsReceivedFromVendor]  WITH NOCHECK ADD  CONSTRAINT [FK_ItemsReceivedFromVendor_ItemsSentToVendor] FOREIGN KEY([VendorName], [OrderNumber], [LineItem], [DCnumber])
REFERENCES [dbo].[ItemsSentToVendor] ([VendorName], [OrderNumber], [LineItem], [DCnumber])
ALTER TABLE [dbo].[ItemsReceivedFromVendor] CHECK CONSTRAINT [FK_ItemsReceivedFromVendor_ItemsSentToVendor]
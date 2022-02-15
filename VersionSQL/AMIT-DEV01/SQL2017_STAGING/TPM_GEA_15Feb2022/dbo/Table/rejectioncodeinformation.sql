/****** Object:  Table [dbo].[rejectioncodeinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[rejectioncodeinformation](
	[rejectionid] [nvarchar](50) NULL,
	[rejectionno] [int] IDENTITY(1,1) NOT NULL,
	[rejectiondescription] [nvarchar](100) NULL,
	[Catagory] [nvarchar](50) NULL,
	[interfaceid] [nvarchar](50) NULL,
	[SubCategory] [nvarchar](50) NULL,
 CONSTRAINT [PK_rejectioncodeinformation] PRIMARY KEY CLUSTERED 
(
	[rejectionno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
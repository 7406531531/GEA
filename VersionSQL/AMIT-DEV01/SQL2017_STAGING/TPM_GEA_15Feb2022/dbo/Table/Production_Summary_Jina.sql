/****** Object:  Table [dbo].[Production_Summary_Jina]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Production_Summary_Jina](
	[Date] [datetime] NOT NULL,
	[Shift] [nvarchar](50) NOT NULL,
	[Machine] [nvarchar](50) NOT NULL,
	[WorkOrderNumber] [nvarchar](50) NOT NULL,
	[Component] [nvarchar](50) NOT NULL,
	[Operation] [nvarchar](50) NOT NULL,
	[Operator] [nvarchar](50) NOT NULL,
	[Qty] [int] NULL,
	[TextValue1] [nvarchar](50) NULL,
	[TextValue2] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[cycles] [int] NULL,
	[ReworkPerformed] [int] NULL,
 CONSTRAINT [PK_Production_Summary_Jina] PRIMARY KEY CLUSTERED 
(
	[Date] ASC,
	[Shift] ASC,
	[Machine] ASC,
	[WorkOrderNumber] ASC,
	[Component] ASC,
	[Operation] ASC,
	[Operator] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Production_Summary_Jina] ADD  CONSTRAINT [DF__Productio__cycle__5C37ACAD]  DEFAULT ((0)) FOR [cycles]
ALTER TABLE [dbo].[Production_Summary_Jina] ADD  CONSTRAINT [DF__Productio__Rewor__5D2BD0E6]  DEFAULT ((0)) FOR [ReworkPerformed]
/****** Object:  Table [dbo].[RawData]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[RawData](
	[SlNo] [bigint] IDENTITY(1,1) NOT NULL,
	[DataType] [int] NULL,
	[IPAddress] [nvarchar](20) NULL,
	[Mc] [nvarchar](50) NULL,
	[Comp] [nvarchar](50) NULL,
	[Opn] [nvarchar](50) NULL,
	[Opr] [nvarchar](50) NULL,
	[SPLSTRING1] [nvarchar](50) NULL,
	[Sttime] [datetime] NULL,
	[Ndtime] [datetime] NULL,
	[SPLSTRING2] [nvarchar](4000) NULL,
	[Status] [int] NOT NULL,
	[WorkOrderNumber] [nvarchar](50) NOT NULL,
	[SPLString3] [nvarchar](500) NULL,
	[SPLString4] [nvarchar](50) NULL,
	[SPLString5] [nvarchar](50) NULL,
	[SPLString6] [nvarchar](50) NULL
) ON [PRIMARY]

CREATE CLUSTERED INDEX [IX_RawdataSlno] ON [dbo].[RawData]
(
	[SlNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[RawData] ADD  CONSTRAINT [DF__RawData__WorkOrd__194BA7E5]  DEFAULT ('0') FOR [WorkOrderNumber]
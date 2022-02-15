/****** Object:  Table [dbo].[BOSCH_FlowMeter]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[BOSCH_FlowMeter](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[mc] [nvarchar](50) NULL,
	[comp] [nvarchar](50) NULL,
	[opn] [nvarchar](50) NULL,
	[FlowValue1] [decimal](18, 4) NULL,
	[FlowValue2] [decimal](18, 4) NULL,
	[Starttime] [datetime] NULL,
	[Endtime] [datetime] NULL
) ON [PRIMARY]
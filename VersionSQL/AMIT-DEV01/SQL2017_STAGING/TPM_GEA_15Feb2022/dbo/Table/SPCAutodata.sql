/****** Object:  Table [dbo].[SPCAutodata]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[SPCAutodata](
	[Mc] [nvarchar](50) NOT NULL,
	[Comp] [nvarchar](50) NULL,
	[Opn] [nvarchar](50) NULL,
	[Opr] [nvarchar](50) NULL,
	[Dimension] [nvarchar](50) NOT NULL,
	[Value] [float] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[BatchTS] [datetime] NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[WearOffSetNumber] [nvarchar](50) NULL,
	[MeasureDimension] [nvarchar](50) NULL,
	[CorrectionValue] [nvarchar](50) NULL,
	[MONumber] [nvarchar](50) NULL,
	[BatchID] [nvarchar](50) NULL,
	[InstrumentNo] [nvarchar](50) NULL,
	[Remarks] [nvarchar](50) NULL,
	[InspectionType] [nvarchar](50) NULL
) ON [PRIMARY]
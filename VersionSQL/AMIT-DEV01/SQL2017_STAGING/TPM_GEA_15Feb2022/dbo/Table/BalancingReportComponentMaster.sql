/****** Object:  Table [dbo].[BalancingReportComponentMaster]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[BalancingReportComponentMaster](
	[Component] [nvarchar](50) NULL,
	[Param1] [nvarchar](50) NULL,
	[Tol_g] [decimal](5, 2) NULL,
	[R_mm] [float] NULL,
	[Dim_mm] [float] NULL,
	[ISO] [nvarchar](50) NULL,
	[Unit] [decimal](7, 2) NULL,
	[Param2] [nvarchar](50) NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
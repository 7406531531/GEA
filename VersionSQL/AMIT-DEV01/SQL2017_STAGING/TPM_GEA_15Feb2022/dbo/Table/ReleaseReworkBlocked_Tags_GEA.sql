/****** Object:  Table [dbo].[ReleaseReworkBlocked_Tags_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ReleaseReworkBlocked_Tags_GEA](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductionOrder] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[Description] [nvarchar](100) NULL,
	[PartNumber] [nvarchar](50) NULL,
	[LocationOfExamination] [nvarchar](50) NULL,
	[Supplier] [nvarchar](50) NULL,
	[Quantity] [float] NULL,
	[Examiner] [nvarchar](50) NULL,
	[ExaminerDate] [datetime] NULL,
	[SpecialReleaseBy] [nvarchar](50) NULL,
	[SpecialReleaseByDate] [datetime] NULL,
	[ReworkProcedure] [nvarchar](500) NULL,
	[Comments] [nvarchar](500) NULL,
	[TagType] [nvarchar](50) NULL
) ON [PRIMARY]
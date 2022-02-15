/****** Object:  Table [dbo].[CreateSchDuleTemp1]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[CreateSchDuleTemp1](
	[SLNo] [bigint] IDENTITY(1,1) NOT NULL,
	[Reports] [nvarchar](max) NULL,
	[ExportsType] [nvarchar](50) NULL,
	[RunReportOn] [nvarchar](max) NULL,
	[RunReportForEvery] [nvarchar](50) NULL,
	[PlantIDAll] [bit] NULL,
	[MachineIDAll] [bit] NULL,
	[OperatorIDAll] [bit] NULL,
	[ShiftIDAll] [bit] NULL,
	[RunReportforEveryVisibility] [nvarchar](50) NULL,
	[RunReportOnVisibity] [nvarchar](max) NULL,
	[TemplateName] [nvarchar](max) NULL,
	[GroupIDAll] [bit] NULL,
 CONSTRAINT [PK_CreateSchDuleTemp1] PRIMARY KEY CLUSTERED 
(
	[SLNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
/****** Object:  Table [dbo].[DNCprograms]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[DNCprograms](
	[ProgramFileName] [nvarchar](50) NOT NULL,
	[CAMshaftNo] [nvarchar](50) NULL,
	[NoOfCAMs] [int] NULL,
	[NoOfEccentricity] [int] NULL,
	[EccentricityNo] [nvarchar](50) NULL,
	[Cylinder] [nvarchar](50) NULL,
	[Customer] [nvarchar](50) NULL,
	[CAMangle] [smallint] NULL,
 CONSTRAINT [PK_DNCprograms] PRIMARY KEY CLUSTERED 
(
	[ProgramFileName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
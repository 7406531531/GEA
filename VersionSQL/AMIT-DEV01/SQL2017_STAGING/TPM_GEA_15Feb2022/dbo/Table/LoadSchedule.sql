/****** Object:  Table [dbo].[LoadSchedule]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[LoadSchedule](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[Shift] [nvarchar](50) NOT NULL,
	[Machine] [nvarchar](50) NOT NULL,
	[Component] [nvarchar](50) NOT NULL,
	[Operation] [int] NULL,
	[IdealCount] [int] NULL,
	[JobCardno] [nvarchar](25) NULL,
	[PDT] [int] NULL,
	[StdCycleTime] [float] NULL,
	[ShiftTarget] [float] NULL,
 CONSTRAINT [PK_LoadSchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
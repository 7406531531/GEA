/****** Object:  Table [dbo].[AssemblyActivityMaster_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[AssemblyActivityMaster_GEA](
	[IDD] [bigint] IDENTITY(1,1) NOT NULL,
	[Station] [nvarchar](50) NULL,
	[OperationNo] [nvarchar](50) NULL,
	[Activity] [nvarchar](50) NULL,
	[IsDefault] [bit] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedTS] [datetime] NULL,
	[StdCycletime] [float] NULL,
	[Componentid] [nvarchar](50) NULL,
	[StdSetupTime] [float] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[AssemblyActivityMaster_GEA] ADD  CONSTRAINT [DF_AssemblyActivityMaster_GEA_IsDefault]  DEFAULT ((0)) FOR [IsDefault]
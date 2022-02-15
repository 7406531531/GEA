/****** Object:  Table [dbo].[ProcessParameterTransaction_MGTL]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[ProcessParameterTransaction_MGTL](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineID] [nvarchar](50) NULL,
	[ParameterID] [int] NULL,
	[ParameterBitType] [nvarchar](50) NULL,
	[UpdatedtimeStamp] [datetime] NULL,
	[ParameterBitColumn] [nvarchar](50) NULL
) ON [PRIMARY]
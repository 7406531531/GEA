/****** Object:  Table [dbo].[Focas_OperationHistoryTemp]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_OperationHistoryTemp](
	[OperationType] [nvarchar](500) NULL,
	[OperationValue] [nvarchar](1000) NULL,
	[ODateTime] [nvarchar](100) NULL,
	[MachineID] [nvarchar](50) NULL
) ON [PRIMARY]
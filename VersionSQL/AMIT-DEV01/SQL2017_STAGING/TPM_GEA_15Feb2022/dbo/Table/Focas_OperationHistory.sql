/****** Object:  Table [dbo].[Focas_OperationHistory]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_OperationHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[OperationType] [nvarchar](300) NULL,
	[OperationValue] [nvarchar](500) NULL,
	[ODateTime] [nvarchar](100) NULL,
	[MachineID] [nvarchar](50) NULL,
	[TypeNumber] [int] NULL,
 CONSTRAINT [PK_Focas_OperationHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
/****** Object:  Table [dbo].[PlantInformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[PlantInformation](
	[PlantID] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[SlNo] [int] IDENTITY(1,1) NOT NULL,
	[PlantCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_PlantInformation] PRIMARY KEY CLUSTERED 
(
	[PlantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
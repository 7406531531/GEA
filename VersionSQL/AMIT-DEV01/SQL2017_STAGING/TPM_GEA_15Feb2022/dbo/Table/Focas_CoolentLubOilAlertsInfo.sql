/****** Object:  Table [dbo].[Focas_CoolentLubOilAlertsInfo]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Focas_CoolentLubOilAlertsInfo](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MachineId] [nvarchar](50) NOT NULL,
	[AlertType] [nvarchar](50) NOT NULL,
	[AlertTimestamp] [datetime] NOT NULL,
	[QtyAtAlert] [decimal](18, 3) NOT NULL,
	[Ack_User] [nvarchar](50) NOT NULL,
	[Ack_Timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_Focas_CoolentLubOilAlertsInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
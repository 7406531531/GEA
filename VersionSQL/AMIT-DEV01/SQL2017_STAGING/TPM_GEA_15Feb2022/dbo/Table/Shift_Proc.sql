/****** Object:  Table [dbo].[Shift_Proc]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Shift_Proc](
	[SSession] [nvarchar](50) NOT NULL,
	[Machine] [nvarchar](50) NOT NULL,
	[Mdate] [datetime] NULL,
	[Mshift] [nvarchar](50) NULL,
	[MShiftStart] [datetime] NOT NULL,
	[MshiftEnd] [datetime] NULL,
	[UtilTime] [float] NULL,
	[MachineInt] [nvarchar](50) NULL,
 CONSTRAINT [PK_Shift_Proc] PRIMARY KEY CLUSTERED 
(
	[SSession] ASC,
	[Machine] ASC,
	[MShiftStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
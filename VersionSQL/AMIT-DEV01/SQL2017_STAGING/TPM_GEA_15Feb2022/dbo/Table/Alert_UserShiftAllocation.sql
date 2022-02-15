/****** Object:  Table [dbo].[Alert_UserShiftAllocation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[Alert_UserShiftAllocation](
	[SlNo] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [nvarchar](100) NOT NULL,
	[ShiftDate] [datetime] NOT NULL,
	[ShiftID] [smallint] NOT NULL,
 CONSTRAINT [PK_Alert_UserShiftAllocation] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[ShiftDate] ASC,
	[ShiftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
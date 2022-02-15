/****** Object:  Table [dbo].[shiftdetails]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[shiftdetails](
	[ShiftName] [nvarchar](20) NULL,
	[StartTime] [int] NULL,
	[NoofHrs] [int] NULL,
	[fromdate] [smalldatetime] NULL,
	[slno] [int] IDENTITY(1,1) NOT NULL,
	[Running] [smallint] NULL,
	[shiftid] [tinyint] NULL,
	[FromDay] [smallint] NULL,
	[ToDay] [smallint] NULL,
	[FromTime] [datetime] NULL,
	[ToTime] [datetime] NULL,
 CONSTRAINT [PK_shiftdetails] PRIMARY KEY CLUSTERED 
(
	[slno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[shiftdetails] ADD  CONSTRAINT [DF_shiftdetails_StartTime]  DEFAULT ((0)) FOR [StartTime]
ALTER TABLE [dbo].[shiftdetails] ADD  CONSTRAINT [DF_shiftdetails_NoofHrs]  DEFAULT ((0)) FOR [NoofHrs]
ALTER TABLE [dbo].[shiftdetails] ADD  CONSTRAINT [DF_shiftdetails_Running]  DEFAULT ((0)) FOR [Running]
ALTER TABLE [dbo].[shiftdetails] ADD  CONSTRAINT [DF_shiftdetails_shiftid]  DEFAULT ((0)) FOR [shiftid]
ALTER TABLE [dbo].[shiftdetails] ADD  CONSTRAINT [DF_shiftdetails_FromDay]  DEFAULT ((0)) FOR [FromDay]
ALTER TABLE [dbo].[shiftdetails] ADD  CONSTRAINT [DF_shiftdetails_ToDay]  DEFAULT ((0)) FOR [ToDay]
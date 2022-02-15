/****** Object:  Table [dbo].[EfficiencyTarget]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[EfficiencyTarget](
	[MachineID] [nvarchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[AE] [smallint] NULL,
	[PE] [smallint] NULL,
	[QE] [smallint] NULL,
	[OE] [smallint] NULL,
	[LogicalDayStart] [datetime] NULL,
	[LogicalDayEnd] [datetime] NULL,
	[TargetLevel] [char](10) NOT NULL,
 CONSTRAINT [PK_EfficiencyTarget_1] PRIMARY KEY CLUSTERED 
(
	[MachineID] ASC,
	[StartDate] ASC,
	[EndDate] ASC,
	[TargetLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[EfficiencyTarget]  WITH CHECK ADD  CONSTRAINT [FK_EfficiencyTarget_machineinformation] FOREIGN KEY([MachineID])
REFERENCES [dbo].[machineinformation] ([machineid])
ALTER TABLE [dbo].[EfficiencyTarget] CHECK CONSTRAINT [FK_EfficiencyTarget_machineinformation]
/****** Object:  Table [dbo].[EmployeeGroups]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[EmployeeGroups](
	[GroupID] [nvarchar](50) NOT NULL,
	[OperatorID] [nvarchar](50) NOT NULL,
	[Slno] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[EmployeeGroups]  WITH NOCHECK ADD  CONSTRAINT [FK_EmployeeGroups_employeeinformation] FOREIGN KEY([OperatorID])
REFERENCES [dbo].[employeeinformation] ([Employeeid])
ALTER TABLE [dbo].[EmployeeGroups] CHECK CONSTRAINT [FK_EmployeeGroups_employeeinformation]
/****** Object:  Table [dbo].[employeeinformation]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[employeeinformation](
	[Employeeid] [nvarchar](50) NOT NULL,
	[employeeno] [int] NULL,
	[Name] [nvarchar](150) NULL,
	[designation] [nvarchar](100) NULL,
	[qualification] [nvarchar](100) NULL,
	[address1] [nvarchar](100) NULL,
	[address2] [nvarchar](100) NULL,
	[phone] [nvarchar](50) NULL,
	[operate] [smallint] NOT NULL,
	[setting] [smallint] NULL,
	[maintain] [smallint] NULL,
	[status] [smallint] NULL,
	[isadmin] [smallint] NULL,
	[upassword] [nvarchar](15) NULL,
	[interfaceid] [nvarchar](50) NULL,
	[Company_default] [bit] NULL,
	[Email] [nvarchar](500) NULL,
	[MobileNo] [nvarchar](500) NULL,
	[EmployeeImage] [varbinary](max) NULL,
	[EmployeeRole] [nvarchar](50) NULL,
	[Role] [nvarchar](50) NULL,
 CONSTRAINT [PK_employeeinformation] PRIMARY KEY CLUSTERED 
(
	[Employeeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[employeeinformation] ADD  CONSTRAINT [DF_employeeinformation_employeeno]  DEFAULT ((0)) FOR [employeeno]
ALTER TABLE [dbo].[employeeinformation] ADD  CONSTRAINT [DF_employeeinformation_operate]  DEFAULT ((0)) FOR [operate]
ALTER TABLE [dbo].[employeeinformation] ADD  CONSTRAINT [DF_employeeinformation_setting]  DEFAULT ((0)) FOR [setting]
ALTER TABLE [dbo].[employeeinformation] ADD  CONSTRAINT [DF_employeeinformation_maintain]  DEFAULT ((0)) FOR [maintain]
ALTER TABLE [dbo].[employeeinformation] ADD  CONSTRAINT [DF_employeeinformation_status]  DEFAULT ((0)) FOR [status]
ALTER TABLE [dbo].[employeeinformation] ADD  CONSTRAINT [DF_employeeinformation_isadmin]  DEFAULT ((0)) FOR [isadmin]
ALTER TABLE [dbo].[employeeinformation] ADD  CONSTRAINT [Company_defaultDefault]  DEFAULT ((0)) FOR [Company_default]
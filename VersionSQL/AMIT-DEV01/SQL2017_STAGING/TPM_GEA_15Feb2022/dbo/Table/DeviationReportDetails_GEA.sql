/****** Object:  Table [dbo].[DeviationReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[DeviationReportDetails_GEA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[PartName] [nvarchar](50) NULL,
	[PartNo] [nvarchar](50) NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL,
	[JobCardNo] [nvarchar](50) NULL,
	[DevRequestedBy] [nvarchar](50) NULL,
	[Signature] [nvarchar](50) NULL,
	[Supplier] [nvarchar](50) NULL,
	[Inhouse] [nvarchar](50) NULL,
	[DeviationQty] [nvarchar](20) NULL,
	[ReceivedQty] [nvarchar](20) NULL,
	[Visual] [bit] NULL,
	[Dimensional] [bit] NULL,
	[Material] [bit] NULL,
	[Functional] [bit] NULL,
	[Process] [bit] NULL,
	[Other] [bit] NULL,
	[Permanent] [bit] NULL,
	[DeviationDescription] [nvarchar](200) NULL,
	[Negligible] [bit] NULL,
	[Minor] [bit] NULL,
	[Moderate] [bit] NULL,
	[Major] [bit] NULL,
	[Severe] [bit] NULL,
	[EffectDescription] [nvarchar](200) NULL,
	[RootCause] [nvarchar](200) NULL,
	[CorrectiveAction] [nvarchar](200) NULL,
	[PreventiveAction] [nvarchar](200) NULL,
	[DeviationApproved] [bit] NULL,
	[DeviationNotApproved] [bit] NULL,
	[QAHead] [nvarchar](100) NULL,
	[TechnicalHead] [nvarchar](100) NULL,
	[QASign] [nvarchar](50) NULL,
	[SignDate] [datetime] NULL,
	[Place] [nvarchar](50) NULL,
	[Confirmation] [int] NULL,
	[MachineID] [nvarchar](50) NULL,
	[DevNo] [nvarchar](50) NULL
) ON [PRIMARY]
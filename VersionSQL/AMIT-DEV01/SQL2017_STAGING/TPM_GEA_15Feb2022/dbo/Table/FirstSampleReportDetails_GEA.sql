/****** Object:  Table [dbo].[FirstSampleReportDetails_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[FirstSampleReportDetails_GEA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PartNo] [nvarchar](50) NULL,
	[ProductionOrderNo] [nvarchar](50) NULL,
	[Inspection1] [bit] NULL,
	[Inspection2] [bit] NULL,
	[Inspection3] [bit] NULL,
	[InspectionDate] [datetime] NULL,
	[Reason_NewSupplier] [bit] NULL,
	[Reason_NewPart] [bit] NULL,
	[Reason_AmendedSpecific] [bit] NULL,
	[Reason_Amended] [bit] NULL,
	[Reason_Other] [bit] NULL,
	[Reason_RepetativeInspection] [bit] NULL,
	[Supplier] [nvarchar](50) NULL,
	[Material] [nvarchar](50) NULL,
	[NoOfSamples] [nvarchar](50) NULL,
	[DocumentType1] [bit] NULL,
	[DocumentType2] [bit] NULL,
	[DocumentType3] [bit] NULL,
	[InputStockUsed1] [bit] NULL,
	[InputStockUsed2] [bit] NULL,
	[InputStockUsed3] [nvarchar](50) NULL,
	[InspectionCarriedBit] [bit] NULL,
	[Comment] [nvarchar](300) NULL,
	[Date] [datetime] NULL,
	[Signature] [nvarchar](50) NULL,
	[Material_MechanicalTest] [bit] NULL,
	[Material_AnalysisCheck] [bit] NULL,
	[Material_Structure] [bit] NULL,
	[Material_Other] [bit] NULL,
	[GEAComments] [nvarchar](250) NULL,
	[Dimension_Check] [bit] NULL,
	[Dimension_Check1] [bit] NULL,
	[Dimension_Check2] [bit] NULL,
	[Dimension_Check3] [bit] NULL,
	[GEAReasonForRejection] [nvarchar](200) NULL,
	[RejDate] [datetime] NULL,
	[RejSignature] [nvarchar](50) NULL,
	[RevNo] [nvarchar](50) NULL,
	[RevDate] [datetime] NULL,
	[Confirmation] [int] NULL,
	[MeasuringComment] [nvarchar](250) NULL,
	[MeasuringCommentBit] [bit] NULL,
	[MeasuringCommentDate] [datetime] NULL,
	[MeasuringCommentSignature] [nvarchar](50) NULL,
	[IAWStandard] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[GrnNo] [nvarchar](50) NULL
) ON [PRIMARY]
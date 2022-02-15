/****** Object:  Table [dbo].[SPC_Characteristic]    Committed by VersionSQL https://www.versionsql.com ******/

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
CREATE TABLE [dbo].[SPC_Characteristic](
	[MachineID] [nvarchar](50) NOT NULL,
	[ComponentID] [nvarchar](50) NOT NULL,
	[OperationNo] [int] NOT NULL,
	[CharacteristicCode] [nvarchar](50) NOT NULL,
	[CharacteristicID] [nvarchar](50) NOT NULL,
	[SpecificationMean] [nvarchar](50) NULL,
	[LSL] [nvarchar](50) NULL,
	[USL] [nvarchar](50) NULL,
	[UOM] [nvarchar](50) NULL,
	[SampleSize] [nvarchar](50) NULL,
	[Interval] [nvarchar](50) NULL,
	[InstrumentType] [nvarchar](50) NULL,
	[InProcessInterval] [nvarchar](50) NULL,
	[InspectionDrawing] [nvarchar](50) NULL,
	[Datatype] [nvarchar](50) NULL,
	[SetupApprovalInterval] [nvarchar](50) NULL,
	[Specification] [nvarchar](50) NULL,
	[MacroLocation] [int] NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UpperOperatingZoneLimit ] [float] NULL,
	[LowerOperatingZoneLimit ] [float] NULL,
	[UpperWarningZoneLimit ] [float] NULL,
	[LowerWarningZoneLimit ] [float] NULL,
	[CuUSL] [decimal](18, 4) NULL,
	[CuLSL] [decimal](18, 4) NULL,
	[UTNO] [nvarchar](50) NULL,
	[BLNo] [nvarchar](50) NULL,
	[MPPNo] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[CompInterfaceId] [nvarchar](50) NULL,
	[OpnInterfaceId] [nvarchar](50) NULL,
	[ToolNumber] [nvarchar](50) NULL,
	[PlanNoAndRevNo] [nvarchar](50) NULL,
	[InspectedBy] [nvarchar](50) NULL,
	[IsEnabled] [nvarchar](5) NULL,
	[AppliesToOpr] [nvarchar](5) NULL,
	[AppliesToQuality] [nvarchar](5) NULL,
	[IsMandatoryForOpr] [nvarchar](5) NULL,
	[IsMandatoryForQuality] [nvarchar](5) NULL,
	[InputMethod] [nvarchar](50) NULL,
	[Channel] [nvarchar](50) NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[SPC_Characteristic] ADD  CONSTRAINT [DF__SPC_Chara__Appli__0F6E0347]  DEFAULT ((0)) FOR [AppliesToOpr]
ALTER TABLE [dbo].[SPC_Characteristic] ADD  CONSTRAINT [DF__SPC_Chara__Appli__10622780]  DEFAULT ((0)) FOR [AppliesToQuality]
ALTER TABLE [dbo].[SPC_Characteristic] ADD  CONSTRAINT [DF__SPC_Chara__IsMan__11564BB9]  DEFAULT ((0)) FOR [IsMandatoryForOpr]
ALTER TABLE [dbo].[SPC_Characteristic] ADD  CONSTRAINT [DF__SPC_Chara__IsMan__124A6FF2]  DEFAULT ((0)) FOR [IsMandatoryForQuality]
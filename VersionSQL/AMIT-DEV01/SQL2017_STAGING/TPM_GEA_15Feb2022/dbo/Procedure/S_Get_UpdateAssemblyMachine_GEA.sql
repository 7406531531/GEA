/****** Object:  Procedure [dbo].[S_Get_UpdateAssemblyMachine_GEA]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[S_Get_UpdateAssemblyMachine_GEA]
@OldMachine nvarchar(50)='',
@NewMachine nvarchar(50)=''
AS
BEGIN

update PlantMachine set MachineID=@NewMachine where MachineID=@OldMachine

update PlantMachineGroups set MachineID=@NewMachine where MachineID=@OldMachine

update machineinformation set MachineID=@NewMachine where MachineID=@OldMachine

update componentoperationpricing set MachineID=@NewMachine where MachineID=@OldMachine

update PlannedDownTimes set Machine=@NewMachine where Machine=@OldMachine

update TempPlannedDownTimes set Machine=@NewMachine where Machine=@OldMachine

update HolidayList set MachineID=@NewMachine where MachineID=@OldMachine

update MO set MachineID=@NewMachine where MachineID=@OldMachine

update ShiftProductionDetails set MachineID=@NewMachine where MachineID=@OldMachine

update ShiftDownTimeDetails set MachineID=@NewMachine where MachineID=@OldMachine



update AssemblyActivityMaster_GEA set Station=@NewMachine where Station=@OldMachine

update AssemblyActivitySchedules_GEA set Machineid=@NewMachine where Machineid=@OldMachine

update AssemblyActivityTransaction_GEA set Machineid=@NewMachine where Machineid=@OldMachine

update AssemblyActivityTransaction_GEA set Machineid=@NewMachine where Machineid=@OldMachine

update ActivityMaster_MGTL set MachineID=@NewMachine where machineid=@OldMachine

update BlueCardTransaction_GEA set Machineid=@NewMachine where Machineid=@OldMachine

update DecanterChecklistPackingTransaction_GEA set Machineid=@NewMachine where Machineid=@OldMachine

update DecanterChecklistTransaction_GEA set Machineid=@NewMachine where Machineid=@OldMachine

update DecanterFinalTestingPackingTransaction_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update DeviationReportDetails_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update DyePenetrationReportDetails_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update ElectrotechnicalTransaction_GEA set MachineID=@NewMachine where machineid=@OldMachine

update FinalInspectionTransaction_GEA set MachineID=@NewMachine where machineid=@OldMachine

update FirstSampleMeasuringReportDetails_GEA set MachineID=@NewMachine where machineid=@OldMachine

update FirstSampleMeasuringReportDetails1_GEA set MachineID=@NewMachine where machineid=@OldMachine

update FirstSampleReportDetails_GEA set MachineID=@NewMachine where machineid=@OldMachine

update HardnessReportDetails_GEA set MachineID=@NewMachine where machineid=@OldMachine

update InspectionTransaction_GEA set MachineID=@NewMachine where machineid=@OldMachine

update InternalQualityReportDetails_GEA set MachineID=@NewMachine where machineid=@OldMachine

update LoginInfo_NonMachining_GEA set Machine=@NewMachine where Machine=@OldMachine

update MachineDataAssemblyAccessories_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update MachineDataAssemblyDescription_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update MachineDataAssemblySpecification_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update NoiseMeasurementTransaction_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update NonConformanceReportDetails_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update NonMachiningEvents_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update ParkedScheduleDetails_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update Quality_8DReportTransaction_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update QualityIncomingActionDetails_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update QualityTransaction_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update ReleaseReworkBlocked_Tags_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update RunningScheduleDetails_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update ScheduleCalculateMethod_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update ScheduleDetails_GEA set MachineID=@NewMachine where MachineID=@OldMachine

update VibrationTestProtocolTransaction_GEA set MachineID=@NewMachine where MachineID=@OldMachine


end
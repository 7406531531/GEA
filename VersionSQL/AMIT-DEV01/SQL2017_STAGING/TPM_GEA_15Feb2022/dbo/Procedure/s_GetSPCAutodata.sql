/****** Object:  Procedure [dbo].[s_GetSPCAutodata]    Committed by VersionSQL https://www.versionsql.com ******/

 --[dbo].[s_GetSPCAutodata] '2019-01-24 09:55:58.100','2019-01-25 09:55:58.100','ABI1','12125A56','10','DIA_031','10'
CREATE    PROCEDURE [dbo].[s_GetSPCAutodata]
@Starttime datetime,
@Endtime datetime,
@Machineid nvarchar(50),
@Componentid nvarchar(50),
@Operationno int,
@Dimension nvarchar(50),
@GroupSize int,
@View nvarchar(50)='' 
AS
BEGIN

Create table #SPC
(
	[SLNO] bigint IDENTITY (1, 1) NOT NULL,
	[BatchTS] Datetime,
	[Value] float,
	[BatchID] int
)

Declare @Samplesize as int
Select @samplesize = Isnull(Valueintext,5) from shopdefaults where parameter='SPC_SampleSize'

If @view=''
BEGIN

	if  ((select ValueInText FROM ShopDefaults WHERE Parameter = 'SPCCompOpnSet') = 'SPCMaster')
	BEGIN
		Insert into #SPC([BatchTS],[Value])
		select Top (@samplesize*@GroupSize) [BatchTS],[Value] 
		from SPCAutodata A
		inner join machineinformation M on M.machineid=A.mc
		inner join SPC_Characteristic SP on M.machineid=SP.machineid 
		and A.comp=SP.Componentid
		and A.opn=SP.operationno and A.Dimension=SP.CharacteristicID
		where [BatchTS]>=@starttime and BatchTS<=@Endtime
		and SP.machineid=@machineid and SP.componentid=@componentid 
		and SP.operationno=@operationno and SP.CharacteristicCode=@Dimension
		Order by [BatchTS],[Value] desc
	END
	ELSE 
	BEGIN
		Insert into #SPC([BatchTS],[Value])
		select Top (@samplesize*@GroupSize) [BatchTS],[Value] from SPCAutodata A
		inner join machineinformation M on M.interfaceid=A.mc
		inner join Componentinformation CI on CI.interfaceid=A.comp
		inner join Componentoperationpricing CO on CO.interfaceid=A.opn and 
		CO.machineid=M.machineid and CO.componentid=CI.Componentid
		inner join SPC_Characteristic SP on CO.machineid=SP.machineid and CO.componentid=SP.Componentid
		and CO.operationno=SP.operationno and A.Dimension=SP.CharacteristicID
		where [BatchTS]>=@starttime and BatchTS<=@Endtime
		and SP.machineid=@machineid and SP.componentid=@componentid 
		and SP.operationno=@operationno and SP.CharacteristicCode=@Dimension
		Order by [BatchTS],[Value] desc
	END
END

If @view='PickLastestValues'
BEGIN
		Insert into #SPC([BatchTS],[Value])
		select Top (@samplesize*@GroupSize) [BatchTS],[Value] from SPCAutodata A
		inner join machineinformation M on M.interfaceid=A.mc
		inner join SPC_Characteristic SP on M.machineid=SP.machineid 
		and A.comp=SP.Componentid
		and A.opn=SP.operationno and A.Dimension=SP.CharacteristicID
		where SP.machineid=@machineid and SP.componentid=@componentid 
		and SP.operationno=@operationno and SP.CharacteristicCode=@Dimension and A.Value>0
		Order by [BatchTS] desc,[Value] desc
END

Declare @SPC_BatchingRecords as nvarchar(50)
Select @SPC_BatchingRecords = Isnull(Valueintext,'BasedOnSampleSize') from shopdefaults where parameter='SPC_BatchingRecords'
select @SPC_BatchingRecords='BasedOnSampleSize'

Declare @BatchTS Datetime,@BatchTS_Prev datetime
Declare @BatchID int,@BatchID_Prev int,@SLNO bigint
Declare @GetBatchID CURSOR 

If @SPC_BatchingRecords='BasedOnSampleSize'
BEGIN
	set @GetBatchID = CURSOR FOR
	Select [SLNO],[BatchTS] from #SPC order by [BatchTS]
	OPEN @GetBatchID

	FETCH NEXT FROM @GetBatchID INTO @SLNO,@BatchTS

	set @BatchID =1
	set @BatchID_Prev=1

	WHILE @@FETCH_STATUS = 0
	BEGIN
		If  @BatchID<@Samplesize
		BEGIN
			Update #SPC set [BatchID] = @BatchID_Prev where SLNO=@SLNO
			set @BatchID = @BatchID + 1
		END
		Else
		BEGIN
			Update #SPC set [BatchID] = @BatchID_Prev where SLNO=@SLNO	
			set @BatchID_Prev = @BatchID_Prev + 1
			set @BatchID = 1	
		end

	FETCH NEXT FROM @GetBatchID INTO @SLNO,@BatchTS
	END
END
ELSE
BEGIN
	set @GetBatchID = CURSOR FOR
	Select [SLNO],[BatchTS] from #SPC order by [BatchTS]
	OPEN @GetBatchID

	FETCH NEXT FROM @GetBatchID INTO @SLNO,@BatchTS

	set @BatchID_Prev =1
	set @BatchTS_Prev = @BatchTS

	WHILE @@FETCH_STATUS = 0
	BEGIN
		If  @BatchTS_Prev=@BatchTS
		BEGIN
			Update #SPC set [BatchID] = @BatchID_Prev where SLNO=@SLNO
		END
		Else
		BEGIN
			set @BatchID_Prev = @BatchID_Prev + 1
			set @BatchTS_Prev = @BatchTS
			Update #SPC set [BatchID] = @BatchID_Prev where SLNO=@SLNO		
		end

	FETCH NEXT FROM @GetBatchID INTO @SLNO,@BatchTS
	END
END
CLOSE @GetBatchID;
DEALLOCATE @GetBatchID;

Select * from #SPC where [BatchID] <= @GroupSize 

END
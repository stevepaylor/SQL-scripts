USE CMP13
declare @p13 bit
set @p13=1
exec spPlayerAwardInfoGet @PlayerID=14562,@CasinoId=3,@PrizeID=10003773,@IsSDS=0,@IsJunketComp=0,@GamingDt='2016-09-26 00:00:00',@EmpId=377,@IsPostGamePts=0,@IsRefusedPatron=0,@BucketGroupId=default,@IsAllowOverEarnRequired=0,@AccessIdList=N'-1,',@IsPlayerEarnAmountBalanced=@p13 output
select @p13

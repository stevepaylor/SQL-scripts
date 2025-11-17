-- TranID of the transaction with the issue


select * from tslotrating where tranid = '10841638924'
select top 100 * from tplayercard where playerid=10748931

-- 
select * from tawards where RelatedTranId=10841638924
select * from tPlayerComps where tranid in (select tranid from tawards where relatedTranid=10803834953)
select * from tplayerpoints where tranid in (select tranid from tawards where relatedTranid=10803834953)

-- PlayerID = 10003832
-- Change the related tran ID to any ID 
select * from tawards where tranid='10841641821' and Ref1='Voided By SDS Credit Key Off Transaction' and PlayerId=10748931 and RelatedTranId=10841638924
update tawards set RelatedTranId='10803847799' where tranid='10841641821' and Ref1='Voided By SDS Credit Key Off Transaction' and PlayerId=10748931 and RelatedTranId=10841638924

-- Roll Back to the old tran ID
select * from tawards where tranid='10803847794' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=10003832 and RelatedTranId=10803847799
update tawards set RelatedTranId='10803834953' where tranid='10803847794' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=10003832 and RelatedTranId=10803847799



-- TranID of the transaction with the issue  -- Player ID  - 750454
select * from tslotrating where tranid = '10882772429'

-- 
select * from tawards where RelatedTranId=10888370657
select * from tPlayerComps where tranid in (select tranid from tawards where relatedTranid=10831296532)
select * from tplayerpoints where tranid in (select tranid from tawards where relatedTranid=10831296532)

-- PlayerID = 10003832
-- Change the related tran ID to any ID  -- tranid='10831299026' and 
select * from tawards where tranid='10831299026' and  Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=750454 and RelatedTranId=10831296532
update tawards set RelatedTranId='10803847799' where tranid='10831299026' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=750454 and RelatedTranId=10831296532

-- Roll Back to the old tran ID -- To run after confirmation
select * from tawards where tranid='10831299026' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=750454 and RelatedTranId=10803847799
update tawards set RelatedTranId='10831296532' where tranid='10831299026' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=750454 and RelatedTranId=10803847799



--NEW  10851861786


select * from tslotrating where tranid = '10882772429'
select top 100 * from tplayercard where playerid=10821155

-- 
select * from tawards where RelatedTranId=10882772429
---select * from tPlayerComps where tranid in (select tranid from tawards where relatedTranid=10849718686)
---select * from tplayerpoints where tranid in (select tranid from tawards where relatedTranid=10849718686)

-- PlayerID = 10003832
-- Change the related tran ID to any ID 
select * from tawards where tranid='10882772184' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=10821155 and RelatedTranId=10882772429
--  changing it to 10882772430
update tawards set RelatedTranId='10882772429' where tranid='10882772184' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=10821155 and RelatedTranId=10882772430
-- Need to set it back to  10882772429




-- Roll Back to the old tran ID
select * from tawards where tranid='10850182996' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=704419 and RelatedTranId=10803841212
update tawards set RelatedTranId='10850176917' where tranid='10850182996' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=704419 and RelatedTranId=10803841212



-- TranID of the transaction with the issue  -- Player ID  - 750454
select * from tslotrating where tranid = '10831296532'

-- 
select * from tawards where RelatedTranId=10831296532
select * from tPlayerComps where tranid in (select tranid from tawards where relatedTranid=10831296532)
select * from tplayerpoints where tranid in (select tranid from tawards where relatedTranid=10831296532)

-- PlayerID = 10003832
-- Change the related tran ID to any ID  -- tranid='10831299026' and 
select * from tawards where tranid='10831299026' and  Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=750454 and RelatedTranId=10831296532
update tawards set RelatedTranId='10803847799' where tranid='10831299026' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=750454 and RelatedTranId=10831296532

-- Roll Back to the old tran ID -- To run after confirmation
select * from tawards where tranid='10831299026' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=750454 and RelatedTranId=10803847799
update tawards set RelatedTranId='10831296532' where tranid='10831299026' and Ref1='Voided by SDS Jackpot Adjustment' and PlayerId=750454 and RelatedTranId=10803847799












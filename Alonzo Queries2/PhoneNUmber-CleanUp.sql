--drop table #phonetemp
SELECT
REPLACE(REPLACE(REPLACE(phonenumber, 
 '(', ''),
')', ''),
'-', '') AS phonenumber
into #phonetemp
FROM tPlayerPhone

select *
From #phonetemp pn
WHERE pn.PhoneNumber not LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' -- is +1(xxx)xxx-xxxx
and pn.PhoneNumber not LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' -- is (xxx)xxx-xxxx
and (phonenumber not like '%11111%'
and phonenumber not like '%00000%'
and phonenumber not like '%12345%')
619 423 1210


select distinct phonenumber
From #phonetemp 
WHERE len(phonenumber) > 10

-- Emails with no numbers -- 42822
select *
From tPlayerPhone pn
WHERE pn.PhoneNumber LIKE '%[A-Z]%' -- is +1(xxx)xxx-xxxx
-- 

-- Empty phone number 352962
select PhoneNumber,*
From tPlayerPhone pn
WHERE pn.PhoneNumber =''

-- Emails start with 00 2248
select PhoneNumber,*
From tPlayerPhone pn
WHERE pn.PhoneNumber like '00%' 

-- Emails start with 11 53167
select PhoneNumber,*
From tPlayerPhone pn
WHERE pn.PhoneNumber like '11%' 

-- Emails start with 11 53167
select PhoneNumber,*
From tPlayerPhone pn
WHERE pn.PhoneNumber like '2222%' 


-- Emails start with 12345 81
select PhoneNumber,*
From tPlayerPhone pn
WHERE pn.PhoneNumber like '12345%' 

--Phone number with less than 10 -- 24825
select PhoneNumber,*
From tPlayerPhone pn
WHERE len(pn.PhoneNumber) > 1 AND len(pn.PhoneNumber) < 10
AND pn.PhoneNumber NOT LIKE '%[A-Z]%'

select PhoneNumber,*
From tPlayerPhone pn
WHERE pn.PhoneNumber like '0%'

select PhoneNumber,*
From tPlayerPhone pn
WHERE pn.PhoneNumber like '11%'



---  ALL COMBINED

-- Emails with no numbers -- 132520
select PhoneNumber, playerid
INTO #phone
From tPlayerPhone pn
WHERE pn.PhoneNumber LIKE '%[A-Z]%' or  
pn.PhoneNumber ='' or 
pn.PhoneNumber like '0000%' or 
pn.PhoneNumber like '11%' or 
pn.PhoneNumber like '2222%' or
pn.PhoneNumber like '12345%' or 
(len(pn.PhoneNumber) > 1 AND len(pn.PhoneNumber) < 7 AND pn.PhoneNumber NOT LIKE '%[A-Z]%')
--453057
Delete PN FROM tPlayerPhone PN INNER JOIN #phone p on p.playerid=pn.PlayerId and p.phonenumber = pn.PhoneNumber

-- Emails with no numbers -- 352621
select PhoneNumber, playerid, contacttypeid
From tPlayerPhone pn
WHERE pn.PhoneNumber ='' 

-- to update CMP
UPDATE tp
SET ModifiedDtm = GETUTCDATE() 
FROM tPlayer tp INNER JOIN #phone e on e.PlayerId = tp.PlayerId 







Select top 500 dbo.fnFormatPhoneNumber(phonenumber) from tPlayerPhone

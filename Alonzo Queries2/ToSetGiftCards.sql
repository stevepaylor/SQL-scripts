select top 100000 * from tplayercard tpc inner join tplayer tp on tpc.playerid = tp.playerid 
where acct between '90013001' and '90018002' 

-- TO UPDATE PLAYE INFO
----update tplayer
set firstname ='VIEJAS', lastName='GIFTCARD', DisplayName='VIEJAS GIFTCARD', PlayerTypeid=6, PIN='9DA48889DF50752F', IsNoMail=1, IsReturnMail=0, Clubstate=30
where playerid in (select playerid from tplayercard where acct between '90013001' and '90018002' )

--CLUB STAE
---update tplayer
SET Clubstate=30
where playerid in (select playerid from tplayercard where acct between '90013001' and '90018002' )

-- TO UPDATE PLAYER BIRTHDAY
----
---update tPlayerAttributeDtl 
set BirthDt =NULL
where playerid in (select playerid from tplayercard where acct between '90013001' and '90018002' )


-- TO UPDATE ADDRESS
----
---update tPlayerAddress 
set Address1='5000 WILLOWS ROAD', City='Alpine', Country='USA', Stateid=51, Countryid=270, Countryname='USA', PostalCodeid=12052, PostalCode=91901
where playerid in (select playerid from tplayercard where acct between '90013001' and '90018002' ) and ContactTYPEID=1



select * from tplayer
where playerid in (select playerid from tplayercard where acct between '90013001' and '90018002' )


select  isreturnmail, * from tplayer
where playerid in (select playerid from tplayercard where acct between '90012001' and '90013002' )

select BirthDt, * from tPlayerAttributeDtl
where playerid in (select playerid from tplayercard where acct between '90012001' and '90013002' )

select * from tPlayerAddress
where playerid in (select playerid from tplayercard where acct in ('90012001','90013001' ))

select * from tPlayerGroup
where playerid in (select playerid from tplayercard where acct in ('90012001','90012002', '90013001', '90013002' ))


select * from tPlayerGroup
where playerid in (select playerid from tplayercard where acct between '90013001' and '90018002')



---select top 100 * from tPlayerAttributeDtl
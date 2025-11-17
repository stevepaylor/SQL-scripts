Update tPlayerAwardPointsDtl
Set AwardPoints = 0
Where PlayerId = 1486599
And StatusCode = 80

select top 100 * from tPlayerAwardPointsDtl
where playerid= (select playerid from tplayercard where acct=21000219)
And StatusCode = 80



Update tPlayerAwardPointsDtl
Set AwardPoints = 0
Where PlayerId = (select playerid from tplayercard where acct=21000219)
And StatusCode = 80


20832681 

select top 10 * from tplayercard where acct=20832681
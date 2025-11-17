
select acct, FirstName, LastName, gamingdt, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ta.POSTDTM) as TimeTaken from tAwards ta inner join
tprize tp on ta.prizeid = tp.PrizeID
inner join viewPlayersViejas vp on ta.playerid = vp.playerid
where PrizeCode in ('P19IGA4ATT', 'P19IGA4F20') and gamingdt='09/23/19'
order by DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ta.POSTDTM) asc


select dbo.fn_GetPlayerPicturePath(acct) As picturepath,acct,  FirstName, LastName, gamingdt, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ta.POSTDTM) as Hour from tAwards ta inner join
tprize tp on ta.prizeid = tp.PrizeID
inner join viewPlayersViejas vp on ta.playerid = vp.playerid
where PrizeCode in ('P19IGA4ATT', 'P19IGA4F20') and gamingdt='09/23/19'
order by DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ta.POSTDTM) asc 

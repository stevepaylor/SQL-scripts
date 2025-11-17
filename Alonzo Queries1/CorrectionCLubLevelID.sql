--Run to get list of players having ClubState-ClubLevel mismatch 
select  Acct,pl.PlayerId,pl.ClubState 'PlayerClubState',pl.ClubLevelId 'PlayerClubLevel',cl.ClubLevelId'CorrectClubLevel' from tplayer (nolock) pl join tplayercard (nolock) pc on pc.PlayerId = pl.PlayerId
join tClubLevels (nolock) cl on cl.ClubState = pl.ClubState
where pl.ClubLevelId != cl.ClubLevelId order by 3 desc 

--Correction Script
Update ply set ply.clublevelid = cl.clublevelid from tplayer ply join tClubLevels cl on ply.ClubState = cl.ClubState
where ply.ClubLevelId != cl.ClubLevelId

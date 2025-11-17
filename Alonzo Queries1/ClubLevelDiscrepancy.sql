select top 100 player_club_level, clubstatus, modifiedDTM, acct,   * from tableau.player_dim pd 
inner join cmktdb13cPR.cmp13.[dbo].[viewPlayersViejas] vp
on pd.player_id = vp.playerid
where player_club_level <> clubstatus
and player_club_level<>'TRIBAL GOLD'

and acct in (20440065,
20785097,
12645658,
10007891,
20042569,
10009853
)


select top 100 * from cmktdb13cPR.cmp13.[dbo].[viewPlayersViejas]


select top 100 * from tplayer
655799
511631
350105
1436574
939051
304528
363423


update tplayer
set ModifiedDtm='2021-12-23 21:14:02.33 +00:00'
where playerid in
(
655799,
511631,
350105,
1436574,
939051,
304528,
363423
)


ADJPRMO

select top 100 * from viewawa
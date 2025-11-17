

select top 100 * from tplayer
order by ModifiedDtm desc


-----update tplayer set LastEditedDTM='2020-03-25 18:53:33.66 +00:00', ModifiedDtm='2020-03-25 18:53:33.66 +00:00'
where playerid in
(
Select count(*)
from MSBIDB01DV.vdw.[tableau].[player_dim]
where player_Address1 = 'Null'
or player_Address2  = 'Null'
or player_city = 'Null'
or player_State = 'Null'
or player_country = 'Null'
or player_zip = 'Null'
)

select top 100 * from MSBIDB01DV.vdw.[tableau].[player_dim]
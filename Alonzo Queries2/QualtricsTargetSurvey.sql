
IF OBJECT_ID('tempdb..#trips', 'U') IS NOT NULL
DROP TABLE #trips
select count(*) as TotalTripsBeforeCovid, 
      (select count(*) from tableau.player_daily_fact
              where gaming_date between '2020-05-18' and '2020-08-17' and player_club_level='GOLD'
              and Player_isemailsend=1 and player_host<>'N/A' and player_geo_distance<=150 and gaming_days=1
              and player_account_number = a.player_account_number
              group by player_account_number) as TotalTripsAfterCovid ,
        player_account_number 
              INTO #trips
from tableau.player_daily_fact a
              where gaming_date between '2019-12-21' and '2020-03-20' and player_club_level='GOLD'
              and Player_isemailsend=1 and player_host<>'N/A' and player_geo_distance<=150 and gaming_days=1
              group by player_account_number


IF OBJECT_ID('tempdb..#trips2', 'U') IS NOT NULL
DROP TABLE #trips2
select count(*) as TotalTripsBeforeCovid, 
      (select count(*) from tableau.player_daily_fact
              where gaming_date between '2020-05-18' and '2020-08-17' and player_club_level='PLATINUM'
              and Player_isemailsend=1 and player_host<>'N/A' and player_geo_distance<=150 and gaming_days=1
              and player_account_number = a.player_account_number
              group by player_account_number) as TotalTripsAfterCovid ,
        player_account_number 
              INTO #trips2
from tableau.player_daily_fact a
              where gaming_date between '2019-12-21' and '2020-03-20' and player_club_level='PLATINUM'
              and Player_isemailsend=1 and player_host<>'N/A' and player_geo_distance<=150 and gaming_days=1
              group by player_account_number

GO 

Select 
'VJC' as PropertyCode,
tp.player_first_name as FirstName,
tp.player_last_name as LastName,
tp.player_host as HostName,
---'viejas' + CAST(ROW_NUMBER() OVER(order by tp.player_account_number) as nvarchar(4))  + '@viejas.com' as Email,
tp.player_email  as Email,
tp.player_last_trip_date as maxTripDt,
tp.player_account_number as Acct,
tp.player_club_level as ClubStatus,
'GOLD-NoReturn' as SurveyType
from [tableau].[player_dim] tp
where
tp.player_isbanned = 0 and 
tp.Player_isemailsend=1 
and tp.player_club_level='GOLD'
and tp.player_last_trip_date <='2020-05-18' 
and tp.player_host<>'N/A'
and tp.player_geo_distance<=150
and tp.player_email  <>'' and UPPER(tp.player_email) not in
		(
		'N@V',
		'N@VB',
		'N@VIEJAS',
		'N@VIEJAS.CM',
		'N@VIEJAS.COM',
		'N@VJS',
		'N@VJS.COM',
		'N9O@VIEJAS',
		'NIO@VIEJAS',
		'NO@V',
		'NO@V',
		'NO@V.COM',
		'NO@VC',
		'NO@VEIAJS.COM',
		'NO@VEIJAS.COM',
		'NO@VI',
		'NO@VI.COM',
		'NO@VIE',
		'NO@VIE.COM',
		'NO@VIE.COM', 
		'NO@VIE.CON',
		'NO@VIEAJS',
		'NO@VIEAS.COM',
		'NO@VIEGAS.COM',
		'NO@VIEJ.COM',
		'No@VIEJA',
		'NO@VIEJA.COM',
		'NO@VIEJAAS.COM', 
		'NO@VIEJAS',
		'NO@VIEJAS',
		'NO@VIEJAS.C0M', 
		'NO@VIEJAS.COMLORI',
		'NO@VIEJAS.VCOM',
		'NO@VIEJAS0516.COM',
		'NO@VIEJJAS.COM', 
		'NO@VIEJQAS.COM', 
		'NO@VIEJS.COM',
		'NO@VIEJSA.COM',
		'NO@VIEJSA.COM', 
		'NO@VIEJSAS.COM',
		'NO@VIELAS',
		'NO@VIERJAS.COM',
		'NO@VIIEJAS',
		'NO@VIJEAS',
		'NO@VIJEAS.COM',
		'NO@VIJEAS.COM', 
		'NO@VJ.COM',
		'NO@VJS',
		'NO@VJS.COM',
		'NO@VVIEJAS.COM',
		'NOEMAIL@VIEJAS',
		'NOEMAIL@VIEJAS.COM',
		'NOMAIL@VIEJAS.COM',
		'NONAME@VIEJAS.COM',
		'NOP@VIEJAS',
		'NOPE@VIEJAS.COM',
		'NOVIEJAS@COM',
		'NOVIEJAS@VIEJAS.COM',
		'NOZ@VIEJAS',
		'NO@VIEJAS.COM',
		'NO@VIEJAS.COM',
		'NNOMAIL@VIEJAS.COM',
		'NO@VIEJAS.COPM',
		'10@VIEJAS.COM',
		'NO@VIEJAS.NET',
		'NO@NOVIEJAS.COM',
		'NOT@VIEJAS.COM',
		'NOI@VIEJAS.COM',
		'N@V.COM',
		'NO@VIEJAS.NET',
		'NA@VIEJAS',
		'N@V.COM',
		'ME@VIEJAS.COM',
		'NO0@VIEJAS',
		'NO@VIEJIAS.COM',
		'NO@VIE.COJM',
		'NO@VIEJAS.CCOM',
		'NONE@VIEJAS.COM',
		'NO@VIEAS',
		'NO@VIEJAS.CON',
		'V@V',
		'N.@V.COM',
		'NOEMAIL@VIEAJS.COM',
		'NO@VIEAJS.COM',
		'NO@V',
		'NO@VIEJAS',
		'NO@VIJAS.COM',
		'NO@VI',
		'N0@VI'
		)

UNION ALL


Select 
'VJC' as PropertyCode,
tp.player_first_name as FirstName,
tp.player_last_name as LastName,
tp.player_host as HostName,
---'viejas' + CAST(ROW_NUMBER() OVER(order by tp.player_account_number) as nvarchar(4))  + '@viejas.com' as Email,
tp.player_email  as Email,
tp.player_last_trip_date as maxTripDt,
tp.player_account_number as Acct,
tp.player_club_level as ClubStatus,
'Platinum-NoReturn' as SurveyType
from [tableau].[player_dim] tp
where
tp.player_isbanned = 0 and 
tp.Player_isemailsend=1 
and tp.player_club_level='PLATINUM'
and tp.player_last_trip_date <='2020-05-18' 
and tp.player_host<>'N/A'
and tp.player_geo_distance<=150
and tp.player_email  <>'' and UPPER(tp.player_email) not in
		(
		'N@V',
		'N@VB',
		'N@VIEJAS',
		'N@VIEJAS.CM',
		'N@VIEJAS.COM',
		'N@VJS',
		'N@VJS.COM',
		'N9O@VIEJAS',
		'NIO@VIEJAS',
		'NO@V',
		'NO@V',
		'NO@V.COM',
		'NO@VC',
		'NO@VEIAJS.COM',
		'NO@VEIJAS.COM',
		'NO@VI',
		'NO@VI.COM',
		'NO@VIE',
		'NO@VIE.COM',
		'NO@VIE.COM', 
		'NO@VIE.CON',
		'NO@VIEAJS',
		'NO@VIEAS.COM',
		'NO@VIEGAS.COM',
		'NO@VIEJ.COM',
		'No@VIEJA',
		'NO@VIEJA.COM',
		'NO@VIEJAAS.COM', 
		'NO@VIEJAS',
		'NO@VIEJAS',
		'NO@VIEJAS.C0M', 
		'NO@VIEJAS.COMLORI',
		'NO@VIEJAS.VCOM',
		'NO@VIEJAS0516.COM',
		'NO@VIEJJAS.COM', 
		'NO@VIEJQAS.COM', 
		'NO@VIEJS.COM',
		'NO@VIEJSA.COM',
		'NO@VIEJSA.COM', 
		'NO@VIEJSAS.COM',
		'NO@VIELAS',
		'NO@VIERJAS.COM',
		'NO@VIIEJAS',
		'NO@VIJEAS',
		'NO@VIJEAS.COM',
		'NO@VIJEAS.COM', 
		'NO@VJ.COM',
		'NO@VJS',
		'NO@VJS.COM',
		'NO@VVIEJAS.COM',
		'NOEMAIL@VIEJAS',
		'NOEMAIL@VIEJAS.COM',
		'NOMAIL@VIEJAS.COM',
		'NONAME@VIEJAS.COM',
		'NOP@VIEJAS',
		'NOPE@VIEJAS.COM',
		'NOVIEJAS@COM',
		'NOVIEJAS@VIEJAS.COM',
		'NOZ@VIEJAS',
		'NO@VIEJAS.COM',
		'NO@VIEJAS.COM',
		'NNOMAIL@VIEJAS.COM',
		'NO@VIEJAS.COPM',
		'10@VIEJAS.COM',
		'NO@VIEJAS.NET',
		'NO@NOVIEJAS.COM',
		'NOT@VIEJAS.COM',
		'NOI@VIEJAS.COM',
		'N@V.COM',
		'NO@VIEJAS.NET',
		'NA@VIEJAS',
		'N@V.COM',
		'ME@VIEJAS.COM',
		'NO0@VIEJAS',
		'NO@VIEJIAS.COM',
		'NO@VIE.COJM',
		'NO@VIEJAS.CCOM',
		'NONE@VIEJAS.COM',
		'NO@VIEAS',
		'NO@VIEJAS.CON',
		'V@V',
		'N.@V.COM',
		'NOEMAIL@VIEAJS.COM',
		'NO@VIEAJS.COM',
		'NO@V',
		'NO@VIEJAS',
		'NO@VIJAS.COM',
		'NO@VI',
		'N0@VI'
		)

UNION ALL


Select 
'VJC' as PropertyCode,
tp.player_first_name as FirstName,
tp.player_last_name as LastName,
tp.player_host as HostName,
--'viejas' + CAST(ROW_NUMBER() OVER(order by tp.player_account_number) as nvarchar(4))  + '@viejas.com' as Email,
tp.player_email  as Email,
tp.player_last_trip_date as maxTripDt,
tp.player_account_number as Acct,
tp.player_club_level as ClubStatus,
'Gold-LowReturn' as SurveyType
from [tableau].[player_dim] tp
where
player_account_number in 
(
       Select player_account_number from #trips where
       (TotalTripsBeforeCovid - TotalTripsAfterCovid) >= 4
       AND TotalTripsAfterCovid is not null 
)

and tp.player_email  <>'' and UPPER(tp.player_email) not in
		(
		'N@V',
		'N@VB',
		'N@VIEJAS',
		'N@VIEJAS.CM',
		'N@VIEJAS.COM',
		'N@VJS',
		'N@VJS.COM',
		'N9O@VIEJAS',
		'NIO@VIEJAS',
		'NO@V',
		'NO@V',
		'NO@V.COM',
		'NO@VC',
		'NO@VEIAJS.COM',
		'NO@VEIJAS.COM',
		'NO@VI',
		'NO@VI.COM',
		'NO@VIE',
		'NO@VIE.COM',
		'NO@VIE.COM', 
		'NO@VIE.CON',
		'NO@VIEAJS',
		'NO@VIEAS.COM',
		'NO@VIEGAS.COM',
		'NO@VIEJ.COM',
		'No@VIEJA',
		'NO@VIEJA.COM',
		'NO@VIEJAAS.COM', 
		'NO@VIEJAS',
		'NO@VIEJAS',
		'NO@VIEJAS.C0M', 
		'NO@VIEJAS.COMLORI',
		'NO@VIEJAS.VCOM',
		'NO@VIEJAS0516.COM',
		'NO@VIEJJAS.COM', 
		'NO@VIEJQAS.COM', 
		'NO@VIEJS.COM',
		'NO@VIEJSA.COM',
		'NO@VIEJSA.COM', 
		'NO@VIEJSAS.COM',
		'NO@VIELAS',
		'NO@VIERJAS.COM',
		'NO@VIIEJAS',
		'NO@VIJEAS',
		'NO@VIJEAS.COM',
		'NO@VIJEAS.COM', 
		'NO@VJ.COM',
		'NO@VJS',
		'NO@VJS.COM',
		'NO@VVIEJAS.COM',
		'NOEMAIL@VIEJAS',
		'NOEMAIL@VIEJAS.COM',
		'NOMAIL@VIEJAS.COM',
		'NONAME@VIEJAS.COM',
		'NOP@VIEJAS',
		'NOPE@VIEJAS.COM',
		'NOVIEJAS@COM',
		'NOVIEJAS@VIEJAS.COM',
		'NOZ@VIEJAS',
		'NO@VIEJAS.COM',
		'NO@VIEJAS.COM',
		'NNOMAIL@VIEJAS.COM',
		'NO@VIEJAS.COPM',
		'10@VIEJAS.COM',
		'NO@VIEJAS.NET',
		'NO@NOVIEJAS.COM',
		'NOT@VIEJAS.COM',
		'NOI@VIEJAS.COM',
		'N@V.COM',
		'NO@VIEJAS.NET',
		'NA@VIEJAS',
		'N@V.COM',
		'ME@VIEJAS.COM',
		'NO0@VIEJAS',
		'NO@VIEJIAS.COM',
		'NO@VIE.COJM',
		'NO@VIEJAS.CCOM',
		'NONE@VIEJAS.COM',
		'NO@VIEAS',
		'NO@VIEJAS.CON',
		'V@V',
		'N.@V.COM',
		'NOEMAIL@VIEAJS.COM',
		'NO@VIEAJS.COM',
		'NO@V',
		'NO@VIEJAS',
		'NO@VIJAS.COM',
		'NO@VI',
		'N0@VI'
		)


UNION ALL



Select
'VJC' as PropertyCode,
tp.player_first_name as FirstName,
tp.player_last_name as LastName,
tp.player_host as HostName,
---'viejas' + CAST(ROW_NUMBER() OVER(order by tp.player_account_number) as nvarchar(4))  + '@viejas.com' as Email,
tp.player_email  as Email,
tp.player_last_trip_date as maxTripDt,
tp.player_account_number as Acct,
tp.player_club_level as ClubStatus,
'Platinum-LowReturn' as SurveyType
from [tableau].[player_dim] tp
where
player_account_number in 
(
       Select player_account_number from #trips2 where
       (TotalTripsBeforeCovid - TotalTripsAfterCovid) >= 4
       AND TotalTripsAfterCovid is not null 
)

and tp.player_email  <>'' and UPPER(tp.player_email) not in
		(
		'N@V',
		'N@VB',
		'N@VIEJAS',
		'N@VIEJAS.CM',
		'N@VIEJAS.COM',
		'N@VJS',
		'N@VJS.COM',
		'N9O@VIEJAS',
		'NIO@VIEJAS',
		'NO@V',
		'NO@V',
		'NO@V.COM',
		'NO@VC',
		'NO@VEIAJS.COM',
		'NO@VEIJAS.COM',
		'NO@VI',
		'NO@VI.COM',
		'NO@VIE',
		'NO@VIE.COM',
		'NO@VIE.COM', 
		'NO@VIE.CON',
		'NO@VIEAJS',
		'NO@VIEAS.COM',
		'NO@VIEGAS.COM',
		'NO@VIEJ.COM',
		'No@VIEJA',
		'NO@VIEJA.COM',
		'NO@VIEJAAS.COM', 
		'NO@VIEJAS',
		'NO@VIEJAS',
		'NO@VIEJAS.C0M', 
		'NO@VIEJAS.COMLORI',
		'NO@VIEJAS.VCOM',
		'NO@VIEJAS0516.COM',
		'NO@VIEJJAS.COM', 
		'NO@VIEJQAS.COM', 
		'NO@VIEJS.COM',
		'NO@VIEJSA.COM',
		'NO@VIEJSA.COM', 
		'NO@VIEJSAS.COM',
		'NO@VIELAS',
		'NO@VIERJAS.COM',
		'NO@VIIEJAS',
		'NO@VIJEAS',
		'NO@VIJEAS.COM',
		'NO@VIJEAS.COM', 
		'NO@VJ.COM',
		'NO@VJS',
		'NO@VJS.COM',
		'NO@VVIEJAS.COM',
		'NOEMAIL@VIEJAS',
		'NOEMAIL@VIEJAS.COM',
		'NOMAIL@VIEJAS.COM',
		'NONAME@VIEJAS.COM',
		'NOP@VIEJAS',
		'NOPE@VIEJAS.COM',
		'NOVIEJAS@COM',
		'NOVIEJAS@VIEJAS.COM',
		'NOZ@VIEJAS',
		'NO@VIEJAS.COM',
		'NO@VIEJAS.COM',
		'NNOMAIL@VIEJAS.COM',
		'NO@VIEJAS.COPM',
		'10@VIEJAS.COM',
		'NO@VIEJAS.NET',
		'NO@NOVIEJAS.COM',
		'NOT@VIEJAS.COM',
		'NOI@VIEJAS.COM',
		'N@V.COM',
		'NO@VIEJAS.NET',
		'NA@VIEJAS',
		'N@V.COM',
		'ME@VIEJAS.COM',
		'NO0@VIEJAS',
		'NO@VIEJIAS.COM',
		'NO@VIE.COJM',
		'NO@VIEJAS.CCOM',
		'NONE@VIEJAS.COM',
		'NO@VIEAS',
		'NO@VIEJAS.CON',
		'V@V',
		'N.@V.COM',
		'NOEMAIL@VIEAJS.COM',
		'NO@VIEAJS.COM',
		'NO@V',
		'NO@VIEJAS',
		'NO@VIJAS.COM',
		'NO@VI',
		'N0@VI'
)





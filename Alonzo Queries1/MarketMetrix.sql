SELECT  'VJC' as PropertyCode, max(TripDt) as maxTripDt,DATEDIFF(d, max(TripDt) , GETDATE()), FirstName,LastName, tPE1.EmailAddress, tp.Acct, tp.ClubStatus, SetupDtm
FROM tTrip tTp (NOLOCK)
INNER JOIN viewPlayersViejas tp on tTp.PlayerId = tp.PlayerId
left join dbo.tPlayerEmail tPE1 on tp.PlayerId = tPE1.PlayerId and tPE1.ContactTypeId = 1
where tPE1.EmailAddress<>'' and UPPER(tPE1.EmailAddress) not in

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

and IsBanned = 0 
and tTp.playerid in
(
select DISTINCT PlayerID from viewAllRatingsViejasNoAwards where
(DATEDIFF(d, GamingDt , GETDATE()) =1) 
)

Group by tp.PlayerId, FirstName,LastName,EmailAddress, tp.Acct, tp.ClubStatus, SetupDtm
having  (DATEDIFF(d, max(TripDt) , GETDATE()) =1) 
order by SetupDtm desc

select tripdt, count(*) from tTrip
where tripdt>='11/01/2018'
group by tripdt
order by tripdt
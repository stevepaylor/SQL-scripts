Select
a.*,
pv.acct,
p.prizename,
geo_distance

INTO #Awards
From [CMKTDB13Cpr].[cmp13].dbo.viewawardsviejas a (nolock)
join [CMKTDB13Cpr].[cmp13].dbo.viewplayersviejas pv (nolock) on a.playerid = pv.PlayerId
join [MSBIDB01dv].[vdw].[tableau].[player_daily_fact] td (nolock) on a.playerid = td.player_id and a.gamingdt = td.gaming_date
join [CMKTDB13Cpr].[cmp13].dbo.tprize p (nolock) on a.prizecode = p.prizecode
where
gamingdt >= '01/01/2019'
and (a.BonusPromo1 <> 0 or a.AwardUsed <> 0)
and a.prizecode <> 'CSHWDCR'
and a.prizecode <> 'CSHDEPCR'
and a.prizecode <> 'CSHWDPR'

---select top 10 * from #Awards

---DROP table  #Awards


select
acct,
gamingdt,
a.prizecode,
SUM(CASE WHEN (((a.PrizeCode like 'L[0-9][0-9][A-L]%'
       or prizename like '%Loyalty Mail%'
       or prizename like '%club cash%')
       and GamingDt between '2018-08-01' and '2018-12-31'
       and (geo_distance <= 150 or geo_distance is null))
or ((a.PrizeCode like 'L[0-9][0-9][A-L]%' or prizename like '%Loyalty Mail%'or prizename like '%club cash%')
       and GamingDt < '2018-08-01')
or ((a.PrizeCode like 'L[0-9][0-9][A-L]F[0-9][M-N]%'
       or prizename like '%Loyalty Mail%'
       or prizename like '%club cash%')
       and GamingDt >= '2019-01-01'))
and a.PrizeCode not like 'S[0-9][0-9][A-L]%'
and a.PrizeCode not like 'P[0-9][0-9][A-L]%'
And a.PrizeCode not like 'L[0-9][0-9][A-L]F[0-9][K]%'
And a.PrizeCode not like 'L[0-9][0-9][A-L]F[0-9][O-P]%'
AND a.AwardCode = 'p' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END ) as award_FPAwarded_ActiveNL,
 
SUM(CASE WHEN (prizename like '%inactive%' or prizename like '%Welcome Back Offer%'
or a.PrizeCode like 'L[0-9][0-9]F[0-9][O-P]%')
AND a.AwardCode = 'p' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END ) as 'award_FPAwarded_INActiveNL',
 
SUM(CASE WHEN (prizename like '%outer%'
or a.PrizeCode like 'L[0-9][0-9]F[0-9][K]%')
AND a.AwardCode = 'p' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END) as 'award_FPAwarded_OuterMarketNL',
 
SUM(CASE WHEN (prizename like '%new member%offer%'
       or a.PrizeCode like '%NewMem%')
AND a.AwardCode = 'P' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END) as 'award_FPAwarded_NewMember',
 
SUM(CASE WHEN (a.PrizeCode like 'FPCC%'
       or a.prizecode in ('BnsFPC10', 'BnsFPC20', 'BnsFPC30','ECash-FPC'))
and a.PrizeCode not like 'P[0-9][0-9]%' 
and a.PrizeCode not like 'S[0-9][0-9]%'
and a.PrizeCode not like 'L[0-9][0-9]%'
AND a.AwardCode = 'p' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END) as 'award_FPAwarded_Discretionary',
 
SUM(CASE WHEN ((a.PrizeCode like 'S[0-9][0-9][A-L]%'
or prizename like '%frenzy%'
or prizename like '%double days%'
or prizename like '%Free Play Day Offer%'
or prizename like '%Supplemental cash offer%'
or prizename like '%Supplement cash offer%'
or prizename like '%Monday blowout%'
or prizename like '%Christmas%Free Play Cash%'
or prizename like '%New Years%Free Play Cash%'
or prizename like '%Thanksgiving%Free Play Cash%'
or prizename like '%Veterans%Free Play Cash%'
or a.prizecode in ('0117BRZBB$','0117BRZFPC','0317PBB25','0317RQL100','0317SBB25','0417Brz20A','0417Brz20B', '1217RQL100', '0317Brz20A', '0317Brz20B', '0317Brz20C', '0317Brz20D', '0617OTC025','0617RQL100', 'BRZSIL$20A','BRZSIL$20B')
and a.PrizeCode not like 'L[0-9][0-9][A-L]%') 
and a.PrizeCode not like 'P[0-9][0-9][A-L]%') 
AND a.AwardCode = 'p' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END ) as 'award_FPAwarded_Supplemental',
 
SUM(CASE WHEN (a.PrizeCode like 'P[0-9][0-9]%'
       or a.prizecode like 'GldTue%'
       or a.prizecode = 'Snr$5SNW'
       or a.prizecode in ('$5Brochure', '0117B0005A', '0117B0010A', '0117B0025A', '0117B0050A', '0117B0100A',
'0117BBP$10', '0117BP0100', '0117BP1000', '0117BP2500', '0117BPG100', '0117JKP250',
'0117JKP500', '0117JKPT1k', '0117LBB$10', '0117LNY025','0117LNY050', '0117LNY100', '0117LST$25', '0118BT1000', '0118BT1500', '0118BT2500',
'0118BT4000', '0118BT500', '0118F$1000', '0118FP$100', '0118GO$50', '0118HB$100', '0118J$30',
'0118R$100', '0118R$1000', '0118R$125', '0118R$1250', '0118R$1500', '0118R$200', '0118R$450',
'0118R$550', '0118S$100', '0118S$1000', '0118S$125', '0118S$1250', '0118S$1500', '0118S$200',
'0118S$450', '0118S$550', '0118SWBT', '0217B0005A', '0217B0010A', '0217B0025A', '0217B0050A', '0217B0100A',
'0217BBP$10', '0217BGFT$5', '0217BGFT10', '0217BGFT20','0217BGFT30', '0217BP0100', '0217BP1000',
'0217BP2500', '0217BPG100', '0217BT1000', '0217BT1500', '0217BT2500', '0217BT4000', '0217BT500', '0217JKP250',
'0217JKP500', '0217JKPT1k', '0217JSC$20', '0217LRE25A', '0217LST$25', '0217MGBB25', '0217SSG25A', '0217ST100',
'0217ST1000', '0217ST1500', '0217ST200', '0217ST2500', '0217ST300', '0217ST500', '0218BBP$10', '0218BP000S',
'0218BP0100', '0218BP1000', '0218BP2500', '0218BT500', '0218CP50A', '0218HB$100', '0218L$100', '0218L$1000',
'0218L$125', '0218L$1250', '0218L$1500', '0218L$200', '0218L$450', '0218L$550', '0218S$150', '0218S$1500',
'0218S$200', '0218S$350', '0218S$550', '0218S$750', '0218SB$100', '0218SB$200', '0218SB$800', '0218SBP$50',
'0218Sun$40', '0317B0005A', '0317B0010A', '0317B0025A', '0317B0050A', '0317B0100A', '0317BACSPL', '0317BBP$10',
'0317BP000S', '0317BP1000', '0317BP2500', '0317HS500A', '0317HS500B', '0317HS500C', '0317HS500D', '0317HS500E',
'0317JKP250', '0317JKP500', '0317JKPT1k', '0317LST$25', '0317ST100', '0317ST1000', '0317ST1500', '0317ST200',
'0317ST2500', '0317ST300', '0317ST500', '0317VNM$20', '0417B0005A', '0417B0010A', '0417B0025A', '0417B0050A',
'0417B0100A', '0417BACSPL', '0417BBP$10', '0417BP$10', '0417BP0100', '0417BP1000', '0417BP2500', '0417BPG100',
'0417BSpr50', '0417HB$100', '0417HS$500', '0417JKP250', '0417JKP500', '0417JKPT1k', '0417LST$25', '0417SST',
'0417ST100', '0417ST1000', '0417ST1500', '0417ST200', '0417ST2500', '0417ST300', '0417ST500', '0417SWBT',
'0417TaxHot', '0517B0005A', '0517B0010A', '0517B0025A', '0517B0050A', '0517B0100A', '0517BACSPL', '0517BR$50',
'0517BR100', '0517BR50', '0517BR75', '0517BT1000', '0517BT1500', '0517BT2500', '0517BT4000', '0517BT500',
'0517GE$150', '0517HB$100', '0517HS$500', '0517JKP250', '0517JKP500', '0517JKPT1k', '0517LRE25A', '0517LST$25',
'0517MDP$25', '0517PM$200', '0517ReactB', '0517ReactC', '0517ReactD', '0517ReactE', '0517ReactF', '0517ReactG',
'0517ReactH', '0517SP$100', '0517ST100', '0517ST1000', '0517ST1500', '0517ST200', '0517ST2500', '0517ST300',
'0517ST500', '0517SWBT', '0617B0005A', '0617B0010A', '0617B0025A', '0617B0050A', '0617B0100A', '0617BA1k5',
'0617BACSPL', '0617BBP$10', '0617BP$10', '0617BP0100', '0617BP1000', '0617BP2500', '0617BPG100', '0617BT1000',
'0617BT2000', '0617BT3000', '0617BT5000', '0617BT8000', '0617HB$100', '0617JKP250', '0617JKP500', '0617JKPT1k',
'0617LST$25', '0617OTC025', '0617ST100', '0617ST1000', '0617ST1500', '0617ST200', '0617ST2500',
'0617ST300', '0617ST500', '0617SWBT', '0717B0005A', '0717B0010A', '0717B0025A', '0717B0050A',
'0717B0100A', '0717BT1000', '0717BT1500', '0717BT2500', '0717BT4000', '0717BT500', '0717FFBB25',
'0717GG100', '0717GG1000', '0717GG150', '0717GG200', '0717GG250', '0717GG2500', '0717GG500', '0717MM500',
'0717OTC050', '0717ST100', '0717ST1000', '0717ST1500', '0717ST200', '0717ST2500', '0717ST300', '0717ST500',
'0717SWBT', '0817B0005A', '0817B0010A', '0817B0025A', '0817B0050A', '0817B0100A', '0817BACSPL',
'0817BTSPL', '0817FN100', '0817FN200', '0817FN800', '0817GG100', '0817GG1000', '0817GG150', '0817GG200','0817GG250',
'0817GG2500', '0817GG500', '0817HB$100', '0817LRE28A', '0817SWBT', '0817SWP', '0817VIPFPC', '0817WG100', '0817WG1000',
'0817WG1500', '0817WG200', '0817WG2500', '0817WG300', '0817WG500', '0817WP1000', '0817WP1500', '0817WP200','0917B0005A',
'0917B0010A', '0917B0025A', '0917B0050A', '0917B0100A', '0917BACSPL', '0917BBP$10', '0917BM$10', '0917BP0100',
'0917BP1000', '0917BP2500', '0917BTSPL', '0917FBP100', '0917FBP200', '0917FBP300', '0917FBP400', '0917FBP500',
'0917FNSPL', '0917HB$100', '0917PP10', '0917PP15', '0917RQL100',
'0917ST100', '0917ST1000',
'0917ST1500',	'18250',	'1117ST1500',	'N18IB5B010',	'1017S$100',	'GRPFPC100',	'1216RQL100',	'VEL$5-11',	'1017GG150',	'CP_FPC',	'1216BP2500',	'TLC$20FPC',	'1117BB1500',	'K0717SW25',	'1217J$1500',	'VEL$5-3',
'0917ST200',	'30_Test',	'1117ST200',	'N18IB5B025',	'1017S$1000',	'GRPFPC25',	'1216VIPFPC',	'VEL$5-12',	'1017GG200',	'DayBT$100',	'1216BPG100',	'TripAdv$10',	'1117BB200',	'K0717SW250',	'1217J$200',	'VEL$5-30',
'0917ST2500',	'45_Test',	'1117ST2500',	'OTCREDEMPT',	'1017S$125',	'GRPFPC5',	'1217BACSPL',	'VEL$5-13',	'1017GG250',	'DayBT$150',	'1216HHS05',	'TuePts$100',	'1117BB400',	'K0817SW1K',	'1217J$450',	'VEL$5-4',
'0917ST300',	'60_Test',	'1117ST300',	'PlatUpgrd',	'1017S$1250',	'GRPFPC50',	'1217BBP$10',	'VEL$5-16',	'1017GG2500',	'DayBT$250',	'1216HHS10',	'TuePts$200',	'1117BB500',	'K0817SW25',	'1217J$550',	'VEL$5-5',
'0917ST500',	'B_Plat$200',	'1117ST500',	'PromoTest',	'1017S$150',	'HCTourFP',	'1217BP0100',	'VEL$5-18',	'1017GG500',	'DayBT$400',	'1216HHS15',	'TuePts$300',	'1117BB600',	'K0817SW250',	'1217LRE25A',	'VEL$5-6',
'0917SWBT',	'BaccReb10H',	'1117SWBT',	'PW_Test',	'1017S$1500',	'Hotel20',	'1217BP1000',	'VEL$5-2',	'1017HA10',	'DayBT$50',	'1216JKP250',	'TuePts$400',	'1117BT1000',	'K0917GTAtt',	'1217S$100',	'VEL$5-7',
'0917Way$1K',	'BngSS$10',	'1216B0005A',	'Salt25FPC',	'1017S$200',	'Hotel50',	'1217BP2500',	'VEL$5-20',	'1017HA15',	'DayBT$500',	'1216JKP500',	'VEL$25-1',	'1117BT1500',	'K1216BPAtt',	'1217S$1000',	'VEL$5-8',
'0917Way$2K',	'BngSS$25',	'1216B0010A',	'SF$50FPC',	'1017S$300',	'HotOrbFPC',	'1217BPG100',	'VEL$5-21',	'1017HA20',	'E18IE4F01K',	'1216JKPT1K',	'VEL$25-2',	'1117BT2500',	'Marriott20',	'1217S$125',	'VEL$5-9',
'0917Way500',	'BW$100FPC',	'1216B0025A',	'SF$75FPC',	'1017S$500',	'JackpotFPC',	'1217BTSPL',	'VEL$5-22',	'1017HA400',	'E18IE4F100',	'1216LRE25A',	'VEL$25-3',	'1117BT4000',	'Mil$5FPC',	'1217S$1250',	'Viet$10FPC',
'0917Way750',	'BW$10FPC',	'1216B0050A',	'Test_ProCh',	'1017S$750',	'K0118J$30',	'1217HB$100',	'VEL$5-23',	'1017HA60',	'E18IE4F300',	'1216LST$25',	'VEL$25-4',	'1117BT500',	'MilM$5FPC',	'1217S$1500',	'Waves$10',
'1017BACSPL',	'BW$50FPC',	'1216B0100A',	'TestAFPC',	'1017SST',	'K0217BPAtt',	'1217J$100',	'VEL$5-24',	'1017HB$100',	'FPC$5-1',	'1216PAP25',	'VEL$5-1',	'1117CP25A',	'N18Email15',	'1217S$200',	'15_Test',
'1017BTSPL',	'BW$5FPC',	'1216BBP$10',	'testfpc',	'1017SWBT',	'K0217BPGst',	'1217J$1000',	'VEL$5-25',	'1017LRE25A',	'GRPFPC10',	'1216PAP50',	'VEL$5-10',	'1117ST100',	'N18Email25',	'1217S$450',	'18005',
'1017GG100',	'BW2$5FPC',	'1216BP0100',	'TESTSPIN2',	'1117BACSPL',	'K0218LGCFP',	'1217J$125',	'VEL$5-26',	'1217SWBT',	'18050',	'1217SST',	'1802LNY28',	'1117ST1000',	'N18IB5A025',	'1217S$550',	'1802LNY18',
'1017GG1000',	'CITP_$5PFC',	'1216BP1000',	'TGOTC$100',	'1117BB1000',	'K0717SW1K',	'1217J$1250',	'VEL$5-27',								
 
'Z1803F50') AND a.AwardCode = 'p') THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END ) as 'award_FPAwarded_PromoWinner',
 
SUM(CASE WHEN (a.PrizeCode like 'BUS%' or a.PrizeCode like 'Chtbus%')
and a.PrizeCode not like 'P[0-9][0-9]%'
and a.PrizeCode not like 'S[0-9][0-9]%'
and a.PrizeCode not like 'L[0-9][0-9]%'
AND a.AwardCode = 'p' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END ) as 'award_FPAwarded_Bus',
 
SUM(CASE WHEN (trancode = 'ADJPRMO' and  [Ref1]= 'Promo1 Expiration adjustments') then NetPromo1 Else 0 END) as 'award_FPAwarded_ExpirationofFP',
 
SUM(CASE WHEN a.PrizeCode like 'SvcRcFP%'
and a.PrizeCode not like 'P[0-9][0-9]%'
and a.PrizeCode not like 'S[0-9][0-9]%'
and a.PrizeCode not like 'L[0-9][0-9]%'
AND a.AwardCode = 'p' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END) as 'award_FPAwarded_ServiceRecovery',
 
SUM(CASE WHEN (((a.PrizeCode like 'L[0-9][0-9][A-L]%'
       or prizename like '%Loyalty Mail%'
       or prizename like '%club cash%')
       and GamingDt between '2018-08-01' and '2018-12-31'
       and (geo_distance <= 150 or geo_distance is null))
or ((a.PrizeCode like 'L[0-9][0-9][A-L]%' or prizename like '%Loyalty Mail%'or prizename like '%club cash%')
       and GamingDt < '2018-08-01')
or ((a.PrizeCode like 'L[0-9][0-9][A-L]T[0-9][M-N]%'
       or prizename like '%Loyalty Mail%'
       or prizename like '%club cash%')
       and GamingDt >= '2019-01-01'))
and a.PrizeCode not like 'S[0-9][0-9][A-L]%'
and a.PrizeCode not like 'P[0-9][0-9][A-L]%'
And a.PrizeCode not like 'L[0-9][0-9][A-L]T[0-9][K]%'
And a.PrizeCode not like 'L[0-9][0-9][A-L]T[0-9][O-P]%'
AND a.AwardCode = 'V'
THEN a.awardused Else 0 END ) as 'award_PromoChipUsed_ActiveNL',
 
SUM(CASE WHEN (prizename like '%outer%'
or a.PrizeCode like 'L[0-9][0-9][K]%')
AND a.AwardCode = 'V' THEN a.awardused Else 0 END) as 'award_PromoChipUsed_OuterMarketNL',
 
SUM(CASE WHEN (prizename like '%inactive%' or prizename like '%Welcome Back Offer%'
or a.PrizeCode like 'L[0-9][0-9][O-P]%')
AND a.AwardCode = 'V' THEN a.awardused Else 0 END ) as 'award_PromoChipUsed_INActiveNL',
 
SUM(CASE WHEN (prizename like '%new member%offer%'
       or a.PrizeCode like '%NewMem%')
AND a.AwardCode = 'V' THEN a.awardused Else 0 END) as 'award_PromoChipUsed_NewMember',
 
SUM(CASE WHEN ((a.PrizeCode like 'S[0-9][0-9][A-L]%'
or prizename like '%frenzy%')
and a.PrizeCode not like 'L[0-9][0-9][A-L]%'
and a.PrizeCode not like 'P[0-9][0-9][A-L]%') 
AND a.AwardCode = 'V' THEN a.awardused Else 0 END ) as 'Award_PromoChipUsed_Supplemental',
 
SUM(CASE WHEN (a.PrizeCode like 'P[0-9][0-9]%'
       or a.prizecode like 'GldTue%'
       or a.prizecode = 'Snr$5SNW'
       or a.prizecode in ('0218BT500','BaccReb10H')
AND a.AwardCode = 'v') THEN a.awardused Else 0 END )  as 'Award_PromoChipUsed_PromoWinner',
SUM(CASE WHEN (a.PrizeCode like 'SvcRcFP%')
and a.PrizeCode not like 'P[0-9][0-9]%'
and a.PrizeCode not like 'S[0-9][0-9]%'
and a.PrizeCode not like 'L[0-9][0-9]%'
AND a.AwardCode = 'v' THEN a.awardused Else 0 END ) as 'Award_PromoChipUsed_ServiceRecovery',
SUM(CASE WHEN (a.PrizeCode like 'FP_NNC%' or a.prizecode like 'NNCComp%')
and a.PrizeCode not like 'P[0-9][0-9]%'
and a.PrizeCode not like 'S[0-9][0-9]%'
and a.PrizeCode not like 'L[0-9][0-9]%'
AND a.AwardCode = 'V' THEN a.AwardUsed Else 0 END) as 'Award_PromoChipUsed_Discrectionary',
SUM(CASE WHEN (
       (
       (a.PrizeCode like 'L[0-9][0-9][A-L]%'
       or prizename like '%Loyalty Mail%'
       or prizename like '%club cash%')
       and GamingDt between '2018-08-01' and '2018-12-31'
       and (geo_distance <= 150 or geo_distance is null))
or
((a.PrizeCode like 'L[0-9][0-9][A-L]%' or prizename like '%Loyalty Mail%'or prizename like '%club cash%')
       and GamingDt < '2018-08-01')
or
((a.PrizeCode like 'L[0-9][0-9][A-L]B[0-9][M-N]%'
       or prizename like '%Loyalty Mail%'
       or prizename like '%club cash%')
       and GamingDt >= '2019-01-01'))
and a.PrizeCode not like 'S[0-9][0-9][A-L]%'
and a.PrizeCode not like 'P[0-9][0-9][A-L]%'
And a.PrizeCode not like 'L[0-9][0-9][A-L]B[0-9][K]%'
And a.PrizeCode not like 'L[0-9][0-9][A-L]B[0-9][O-P]%'
AND a.AwardCode = 'C'
THEN a.awardused Else 0 END ) as 'Award_BingoCashUsed_ActiveNL',
SUM(CASE WHEN (prizename like '%inactive%' or prizename like '%Welcome Back Offer%'
or a.PrizeCode like 'L[0-9][0-9][A-L]B[0-9][O-P]%')
AND a.AwardCode = 'C' THEN a.awardused Else 0 END ) as 'Award_BingoCashUsed_INActiveNL',
SUM(CASE WHEN (prizename like '%outer%'
or a.PrizeCode like 'L[0-9][0-9][A-L]B[0-9][K]%')
AND a.AwardCode = 'C' THEN a.awardused Else 0 END) as 'Award_BingoCashUsed_OuterMarketNL',
SUM(CASE WHEN (prizename like '%new member%offer%'
       or a.PrizeCode like '%NewMem%')
AND a.AwardCode = 'C' THEN a.awardused Else 0 END) as 'Award_BingoCashUsed_NewMember',
SUM(CASE WHEN
(a.PrizeCode like 'S[0-9][0-9][A-L]%' or prizename like '%frenzy%') 
AND a.AwardCode = 'C' THEN a.awardused Else 0 END ) as 'Award_BingoCashUsed_Supplemental',
SUM(CASE WHEN (a.PrizeCode like 'P[0-9][0-9]%'  AND a.AwardCode = 'c') THEN a.awardused Else 0 END ) as 'Award_Cash_PromoWinner',
sum (case when a.prizecode like 'C[0-9][0-9]%' and a.prizecode not in ('C18HFB1040', 'C18HFB1050','C18HFB1100','C18HFB1075','C18HFB1015','C18HFB1025') and a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') THEN a.AwardUsed ELSE 0 END) as 'Award_FB_Marketing',
sum (case when a.prizecode in ('SvcRc30All', 'SvcRc30F&B', 'SvcRcFood') and a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') THEN a.AwardUsed ELSE 0 END) as  'Award_FB_ServiceRecovery',
sum (case when a.prizecode like 'Bus%' and a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') THEN a.AwardUsed ELSE 0 END) as  'Award_FB_Bus',
sum (case when a.prizecode in ('HostComp', 'Onst30All', 'Onst30F&B', 'Onst7All', 'Onst7Buff', 'Onst7F&B') and a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') THEN a.AwardUsed ELSE 0 END) as  'Award_FB_Discretionary',
sum (case when a.prizecode = 'opera1' THEN a.AwardUsed ELSE 0 END) as  'Hotel',
sum (case when a.prizecode = 'MVPBuff' and a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') THEN a.AwardUsed ELSE 0 END) as  'Award_FB_Plat_Buffet',
SUM(CASE WHEN a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO')
and (a.prizecode like '&partner%' or a.prizecode like '%cityfest%') THEN a.AwardUsed ELSE 0 END) as 'Award_FB_PR',
SUM(CASE WHEN a.AwardCode = 'I'
and trancode IN ('authcomp')
and a.prizecode like 'SC001'
and a.awardused > '0'
THEN a.AwardUsed ELSE 0 END) as 'SelfComp'
From 

#Awards a

--[CMKTDB13Dpr].[cmp13].dbo.viewawardsviejas a (nolock)
--join viewplayersviejas pv (nolock) on a.playerid = pv.PlayerId
--join [MSBIDB02dv].[vdw].[tableau].[player_daily_fact] td (nolock) on a.playerid = td.player_id and a.gamingdt = td.gaming_date
--join [CMKTDB13Dpr].[cmp13].dbo.tprize p (nolock) on a.prizecode = p.prizecode


where
gamingdt >= '1/1/2019'
and (a.BonusPromo1 <> 0 or a.AwardUsed <> 0)
and a.prizecode <> 'CSHWDCR'
and a.prizecode <> 'CSHDEPCR'
and a.prizecode <> 'CSHWDPR'
group by acct, gamingdt, a.prizecode
 

Declare @acct as varchar(10)
Set @acct='20129753'

---[dbo].[p_GetGuestOfferReportKiosk] '21106534'


	SELECT	p.PrizeId,p.PrizeCode,
				p.PrizeName,
				CONVERT(VARCHAR(8), p.EffectiveDtmNoGMT, 1) AS PrizeEffectivedt,
				CONVERT(VARCHAR(8), p.ValidThroughDtmNoGMT, 1) AS PrizeValidThroughDT,
				'$' + CAST(p.AuthAward AS VARCHAR) AS AuthAward
		FROM	dbo.viewPrizesViejas p WITH (NOLOCK)
		WHERE	p.PrizeCode IN (
								SELECT	LEFT(RIGHT(RTRIM(vpt.TagCode),11),LEN(RIGHT(RTRIM(vpt.TagCode),11))-1)
								FROM	dbo.viewpltags vpt WITH (NOLOCK)
								JOIN	dbo.tPlayerCard tpc WITH (NOLOCK) ON vpt.PlayerId = tpc.PlayerId
								WHERE	tpc.acct = CONVERT(NVARCHAR(50), @acct) 
										AND (vpt.TagCode LIKE'PromoOffer%' OR vpt.TagCode LIKE 'Upgrdoffer%')
										AND vpt.IsPlayerTagInactive = 0 
										----AND CONVERT(VARCHAR(8), getdate(), 1)  BETWEEN p.EffectiveDtmNoGMT AND p.ValidThroughDtmNoGMT
								)
				AND p.IsInactive = 0 
				----AND p.AuthAward > 0
 
		UNION
 
		SELECT	p.PrizeId,p.PrizeCode,
				p.PrizeName,
				CONVERT(VARCHAR(8), p.EffectiveDtmNoGMT, 1) AS PrizeEffectivedt,
				CONVERT(VARCHAR(8), p.ValidThroughDtmNoGMT, 1) AS PrizeValidThroughDT,
				'$' + CAST(p.AuthAward AS VARCHAR) AS AuthAward
		FROM	dbo.viewPrizesViejas p WITH (NOLOCK)
        WHERE	p.PrizeCode IN (
								SELECT	LEFT(RIGHT(RTRIM(vpt.TagCode),11),LEN(RIGHT(RTRIM(vpt.TagCode),11))-1)
								FROM	dbo.viewpltags vpt WITH (NOLOCK)
								JOIN	dbo.tPlayerCard tpc WITH (NOLOCK) ON vpt.PlayerId = tpc.PlayerId
								WHERE	tpc.acct = CONVERT(NVARCHAR(50), @acct) 
										AND (vpt.TagCode LIKE'PromoOffer%' OR vpt.TagCode LIKE 'Upgrdoffer%')
										AND vpt.IsPlayerTagInactive = 0 
										AND p.EffectiveDtmNoGMT >= CONVERT(VARCHAR(8), getdate(), 1) 
								)
				AND p.IsInactive = 0 
				AND p.AuthAward > 0
		
		ORDER BY	PrizeEffectivedt ASC


SELECT
  pls.Acct
, tgs.PlayerID
, wtl.OfferCategory
, CAST(REPLACE(wtl.OfferDescription1,',','') AS NVARCHAR(255)) AS OfferDescription1
, CAST(REPLACE(wtl.OfferDescription2,',','') AS NVARCHAR(255)) AS OfferDescription2
, CAST(REPLACE( wtl.OfferDescription3,',','') AS NVARCHAR(255)) AS OfferDescription3
, wtl.BeginDate
, wtl.EndDate

FROM dbo.viewPlTags AS tgs WITH (NOLOCK)

INNER JOIN Website_Tag_List AS wtl WITH (NOLOCK) 
ON tgs.TagCode = wtl.TagCode 

INNER JOIN dbo.viewPlayersViejas AS pls WITH (NOLOCK) 
ON tgs.PlayerID = pls.PlayerID

WHERE GETDATE() BETWEEN wtl.BeginDate AND wtl.EndDate
and acct=@acct
order by OfferCategory desc, BeginDate asc


select acct, ta.Prizecode as Prizeid, gamingdt, ta.AuthAward, prizename from viewAwardsViejas ta with(nolock)
inner join viewPlayersViejas tp with(nolock) on ta.playerid = tp.playerid
inner join viewPrizesViejas tpr with(nolock) on ta.PrizeCode = tpr.PrizeCode

where acct=@acct and isopenitem=1 

--and 
----where isopenitem=1 and 
--(
--ta.Prizecode='OnSt7F&B' or 
--ta.Prizecode='OnSt30F&B' or 
--ta.Prizecode='Onst7Buff' or 
--ta.Prizecode='OnSt7Rtl' or 
--ta.Prizecode='OnSt30Rtl' or 
--ta.Prizecode='Onsite7' or 
--ta.Prizecode='Onsite30' or 
--ta.Prizecode='MangmtComp' or 
--ta.Prizecode='OnSt7All' or 
--ta.Prizecode='OnSt30All' or
--ta.Prizecode like 'SvcRc30%'
--)

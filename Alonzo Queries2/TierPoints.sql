select top 1000 * from  [tCompPtsConfig] c inner join tgame tg on c.GameID = tg.GameId
where c.GameID=1


select top 100 * from tgame

select top 100 * from tDept


SELECT sum(basePTS)
FROM [CMP13].[dbo].[tAccumKey] AK WITH (NOLOCK) 
JOIN [CMP13].[dbo].[tAccum1DayPts] DP WITH (NOLOCK) ON DP.AccumId = AK.AccumId 
JOIN [CMP13].dbo.viewPlayersViejas P WITH (NOLOCK) ON AK.PlayerID = P.PlayerId 
JOIN [CMP13].dbo.tBucketGroup BG WITH (NOLOCK) ON BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '2021-01-01' AND GETDATE()
AND acct IN('10053992','20061494') 
AND BucketGroupTypeId = 4
---and basepts>0
ORDER BY BasePts 



SUM(BasePts) AS 'TierPoints'
--into MSBIDB02dv.vdw3.[2105_NLMailFile]
From #topinfo tp 
left JOIN [CMKTDB13DPC].[CMP13].DBO.[viewAccum1Month] A on A.playerid = tp.player_id and A.PeriodBeginDtm BETWEEN '1/1/2021' AND getdate()
AND a.bucketgroupid <> 1


select top 100 * from [viewAccum1Month]


select top 100 * from [viewAccum1Month]
where PlayerID=10053992

select 
SUM(BasePts) AS 'TierPoints'
From [viewAccum1Month] 
where PeriodBeginDtm BETWEEN '1/1/2021' AND getdate()
AND bucketgroupid <> 1 and PlayerID=10053992

select top 100 * from [viewAccum1Month] 




SELECT Acct,SUM(BasePts) AS TotalBasePoints 
--SELECT *
FROM [CMP13].[dbo].[tAccumKey] AK WITH (NOLOCK) 
JOIN [CMP13].[dbo].[tAccum1DayPts] DP WITH (NOLOCK) ON DP.AccumId = AK.AccumId 
JOIN [CMP13].dbo.viewPlayersViejas P WITH (NOLOCK) ON AK.PlayerID = P.PlayerId 
JOIN [CMP13].dbo.tBucketGroup BG WITH (NOLOCK) ON BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '2021-01-01' AND GETDATE()
AND acct IN('10124288','20061494','20650684') 
AND BucketGroupTypeId = 4
--ORDER BY BasePts
GROUP BY Acct 

select top 100 * from tplayerpoints
where BucketGroupId <>1
 

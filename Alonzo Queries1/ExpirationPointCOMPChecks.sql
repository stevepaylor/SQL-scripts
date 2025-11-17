/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [GamingDt]
      ,[TranCode]
      ,[PrizeCode]
      ,sum([NetComp]) as Expired_Comps
      ,[Ref1]
      
  FROM [CMP13].[dbo].[viewAwardsViejas] where GamingDt between '1/1/19' and '11/30/19' and AdjCompDr <> 0 and Ref1 = 'Comp Expiration adjustments'
  group by TranCode, PrizeCode, Ref1, GamingDt
  order by GamingDt


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [GamingDt]
      ,[TranCode]
      ,[PrizeCode]
      ,sum([NetPts])/1000 as Expired_Pts
      ,[Ref1]
      
  FROM [CMP13].[dbo].[viewAwardsViejas] where GamingDt between '1/1/19' and '11/30/19' and Ref1 = 'Points Expiration adjustments'
  group by TranCode, PrizeCode, Ref1, GamingDt
  order by GamingDt




  select top 1000 * from [CMP13].[dbo].[viewAwardsViejas] 
  where Trancode='ADJPTS' and ref1='Points Expiration adjustments'
  order by tranid desc
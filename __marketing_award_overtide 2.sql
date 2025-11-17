/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PrizeCode]
      ,[award_rollup]
      ,[dw_timestamp]
      ,[timestamp]
      ,[AwardCode]
  FROM [vDW].[player].[tab_award_fact_PRIZE_code_override]

WHERE PrizeCode LIKE 'P19%'
   OR PrizeCode Like 'P20%'
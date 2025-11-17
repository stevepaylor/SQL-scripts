
select sum(BasePts) from tplayerpoints  --- 66773 Points
where playerid=1426933 and GamingDt>'2020-07-01' and BucketGroupId<>1

GO

select acct, sum(BasePts), ClubStatus from tplayerpoints tp inner join viewPlayersViejas vpv on tp.playerid = vpv.PlayerId
where GamingDt between '2019-11-30' and  '2020-06-30' and BucketGroupId<>1 and ClubStatus<>'PLATINUM'
group by acct, ClubStatus
having sum(BasePts)>=500000 ---and ClubStatus<>'Platinum'


select top 100 * from viewPlayersViejas


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Acct]
      ,[PlayerID]
         ,[Non-Poker_Base_Points]
      ,[Current_Tier]
      ,[Current_Requal_Message_YN]
      ,[Current_Requal_Qualification_Period_Start_Date]
      ,[Current_Requal_Qualification_Period_End_Date]
      ,[Current_Requal_Valid_Through_Date]
      ,[Current_Requal_Tier]
      ,[Current_Requal_Upgrade_Tier]
      ,[Points_To_Current_Requal_Upgrade_Tier]
      ,[Next_Requal_Qualification_Period_Start_Date]
      ,[Next_Requal_Play_Through_Date]
      ,[Next_Requal_Qualification_Period_End_Date]
      ,[Next_Requal_Date]
      ,[Next_Requal_Tier]
      ,[Next_Requal_Upgrade_Message_YN]
      ,[Next_Requal_Upgrade_Tier]
      ,[Points_To_Next_Requal_Upgrade_Tier]
      ,[Points_To_Next_Requal_Upgrade_Tier_Percentage]
      
  FROM [RequalDB].[dbo].[MV_Requal_Meter_Data_Export]
  where acct='20775733'



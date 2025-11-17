 SELECT
      p1.[PlayerId]
      --,[IsVoid]
      ,count(p1.[Ref1]) 'notes'
      --,[Ref2]
      --,[PriorityCode]
      --,[IsOpenItem]
         ,count( distinct p2.IsReturnMail) 'no_mail'

  FROM [CMP13].[dbo].[tPlayerNote] p1
  join CMP13.dbo.viewPlayersViejas p2 on p1.PlayerId = p2.playerid
  where ref1 like '%update address%' or ref1 like '%bad address%'
  and isvoid = 0 and IsReturnMail = 1
  group by p1.playerid

  having count(ref1) >= 3 and count(p2.IsReturnMail) >= 1

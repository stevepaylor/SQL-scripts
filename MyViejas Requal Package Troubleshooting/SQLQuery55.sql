SELECT mP.[PlayerID], mP.[GamingDt], Sum((
      CASE 
         WHEN [DeptID] <> 'POKR' THEN [BasePts]
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN [DeptID] = 'POKR' THEN [BasePts]
         ELSE 0
      END)) AS Poker_Base_Points
   FROM [mv_Patron_Ratings_By_Dept] as mP

        WHERE  PlayerID = 956862

   GROUP BY mP.[PlayerID], mP.[GamingDt]
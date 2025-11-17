SELECT 
    t1.playerid,
    t1.CreatedBy,
    t3.empid,
    t1.cre_TM_Number,
    t3.empnum,
    t1.ModifiedBy,
    t2.empid,
    t1.mod_TM_Number,
    t2.empnum
  FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_Other_Cleanup_Deletes] t1
  left join cmp13.dbo.temp t2 on t1.modifiedby = t2.empid
  left join cmp13.dbo.temp t3 on t1.CreatedBy = t3.empid
  where (cast(t1.mod_tm_number as varchar) <> cast(t2.empnum as varchar)) or (cast(t1.cre_tm_number as varchar) <> cast(t3.empnum as varchar))

UPDATE [Viejas_Custom_Processes].[dbo].[tPlayerEmail_Other_Cleanup_Deletes]
SET mod_TM_Number = 0
WHERE ModifiedBy = 847



  SELECT 
    t1.playerid,
    t1.CreatedBy,
    t3.empid,
    t1.cre_TM_Number,
    t3.empnum,
    t1.ModifiedBy,
    t2.empid,
    t1.mod_TM_Number,
    t2.empnum
  FROM [Viejas_Custom_Processes].[dbo].[tPlayerPhone_Cleanup_Deletes] t1
  left join cmp13.dbo.temp t2 on t1.modifiedby = t2.empid
  left join cmp13.dbo.temp t3 on t1.CreatedBy = t3.empid
  where (cast(t1.mod_tm_number as varchar) <> cast(t2.empnum as varchar)) or (cast(t1.cre_tm_number as varchar) <> cast(t3.empnum as varchar))
--WHERE t1.CreatedBy = 220

UPDATE [Viejas_Custom_Processes].[dbo].[tPlayerPhone_Cleanup_Deletes]
SET cre_TM_Number = 13614 
WHERE CreatedBy = 220
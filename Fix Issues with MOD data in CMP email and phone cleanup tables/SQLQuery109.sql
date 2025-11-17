SELECT 
    t1.playerid,
    t1.CreatedBy,
    t3.empid,
    t1.cre_TM_Number,
    t3.empnum AS tEmp_CRE_empnum,
    t1.ModifiedBy,
    t2.empid,
    t1.mod_TM_Number,
    t2.empnum AS tEmp_MOD_empnum
  FROM Viejas_Custom_Processes.dbo.tPlayerPhone_Cleanup_Deletes AS t1
 join cmp13.dbo.temp t2 on t1.modifiedby = t2.empid
 join cmp13.dbo.temp t3 on t1.CreatedBy = t3.empid
  where ((cast(t1.mod_tm_number as varchar) <> cast(t2.empnum as varchar)) or (cast(t1.cre_tm_number as varchar) <> cast(t3.empnum as varchar))) 
	 --AND cast(t1.mod_tm_number as varchar) = cast(t3.empnum as varchar)

  --SELECT 
  --  t1.playerid,
  --  t1.CreatedBy,
  --  t3.empid,
  --  t1.cre_TM_Number,
  --  t3.empnum,
  --  t1.ModifiedBy,
  --  t2.empid,
  --  t1.mod_TM_Number,
  --  t2.empnum
  --FROM [Viejas_Custom_Processes].[dbo].[tPlayerPhone_Cleanup_Deletes] t1
  --left join cmp13.dbo.temp t2 on t1.modifiedby = t2.empid
  --left join cmp13.dbo.temp t3 on t1.CreatedBy = t3.empid
  --where (cast(t1.mod_tm_number as varchar) <> cast(t2.empnum as varchar)) or (cast(t1.cre_tm_number as varchar) <> cast(t3.empnum as varchar))
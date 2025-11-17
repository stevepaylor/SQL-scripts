--JOIN CMPAPI.dbo.v_TM mod 
--on tpp.ModifiedBy = mod.EmpId

SELECT 
    t1.playerid,
    t1.CreatedBy,
    --t3.empid,
    t1.cre_TM_Number,
    --t3.TEAM_MEMBER_NUM AS v_TM_CRE_TEAM_MEMBER_NUM,
    t1.ModifiedBy,
    t2.empid,
    t1.mod_TM_Number,
    t2.TEAM_MEMBER_NUM AS v_TM_MOD_TEAM_MEMBER_NUM

FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_Other_Cleanup_Deletes] t1

LEFT Join CMPAPI.dbo.v_TM t2 
on t1.modifiedby = t2.empid

--join CMPAPI.dbo.v_TM t3 
--on t1.CreatedBy = t3.empid

where t1.mod_tm_number <> t2.TEAM_MEMBER_NUM
  AND t1.modifiedby IS NOT NULL
	AND t2.empid IS NOT NULL
	AND t1.mod_tm_number IS NOT NULL
	AND t2.TEAM_MEMBER_NUM IS NOT NULL

--(45163 
   --or t1.cre_tm_number <> t3.TEAM_MEMBER_NUM

--where ((cast(t1.mod_tm_number as varchar) <> cast(t2.TEAM_MEMBER_NUM as varchar)) 
--   or (cast(t1.cre_tm_number as varchar) <> cast(t3.TEAM_MEMBER_NUM as varchar)))
	 --AND t1.mod_TM_Number = t3.TEAM_MEMBER_NUM

SELECT *
FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_Other_Cleanup_Deletes]
WHERE playerid = 212

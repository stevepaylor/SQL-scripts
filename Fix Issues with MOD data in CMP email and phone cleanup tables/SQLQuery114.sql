SELECT
  target.PlayerId
, target.ContactTypeId
, target.PhoneNumber
, target.DeletedFromCMP13_TS
, target.ModifiedBy
--, source.EmpId
, target.mod_TM_Number
--, source.TEAM_MEMBER_NUM

FROM Viejas_Custom_Processes.dbo.tPlayerPhone_Cleanup_Deletes AS target
--LEFT JOIN CMPAPI.dbo.v_TM AS source
--ON target.ModifiedBy = source.EmpId

--WHERE target.mod_TM_Number <> source.TEAM_MEMBER_NUM
--WHERE target.PlayerId = 212

ORDER BY target.PlayerId

SELECT 
    t1.playerid,
    t1.CreatedBy,
    --t3.empid,
    t1.cre_TM_Number,
    --t3.empnum AS tEmp_CRE_empnum,
    t1.ModifiedBy,
    t2.empid,
    t1.mod_TM_Number,
    t2.empnum AS tEmp_MOD_empnum
FROM Viejas_Custom_Processes.dbo.tPlayerPhone_Cleanup_Deletes AS t1
  join cmp13.dbo.temp t2 on t1.modifiedby = t2.empid
  --left join cmp13.dbo.temp t3 on t1.CreatedBy = t3.empid

WHERE t1.PlayerId = 212
--ORDER BY t1.PlayerId


  where cast(t1.mod_tm_number as varchar) <> cast(t2.empnum as varchar) 
     --or (cast(t1.cre_tm_number as varchar) <> cast(t3.empnum as varchar)))
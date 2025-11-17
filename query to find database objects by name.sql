 SELECT  o.type_desc AS Object_Type
       ,  s.name AS Schema_Name
       ,  o.name AS Object_Name
    FROM  sys.objects o 
    JOIN  sys.schemas s
      ON  s.schema_id = o.schema_id
   WHERE  o.type NOT IN ('S'  --SYSTEM_TABLE
                        ,'PK' --PRIMARY_KEY_CONSTRAINT
                        ,'D'  --DEFAULT_CONSTRAINT
                        ,'C'  --CHECK_CONSTRAINT
                        ,'F'  --FOREIGN_KEY_CONSTRAINT
                        ,'IT' --INTERNAL_TABLE
                        ,'SQ' --SERVICE_QUEUE
                        ,'TR' --SQL_TRIGGER
                        ,'UQ' --UNIQUE_CONSTRAINT
                        )
AND o.name like '%HRPICT%'

ORDER BY
o.type_desc
       ,  s.name
       ,  o.name
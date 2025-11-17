MERGE CASIDBLIS01PR.<dbname>.dbo.<tablename> AS TT -- Target Table
USING SDSVJPRD.<schemaname>.<tablename> AS ST -- Source Table  
ON  TT.<key1> = ST.<key1>
AND TT.<key2> = ST.<key2>

-- WHEN MATCHED THEN IGNORE \ DO NOTHING

WHEN NOT MATCHED THEN INSERT 
  (
  <key1>
, <key2>
, <other_columns>
  ) 
  VALUES 
  (
  ST.<key1>
, ST.<key2>
, ST.<other_columns>
  );
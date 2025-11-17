--SP_HELP Table1
DECLARE @dbname SYSNAME
    ,@no VARCHAR(35), @yes VARCHAR(35), @none VARCHAR(35)
SELECT @no = 'no', @yes = 'yes', @none = 'none'

DECLARE @precscaletypes NVARCHAR(150)
SELECT @precscaletypes = N'TINYINT,SMALLINT,DECIMAL,INT,BIGINT,REAL,MONEY,FLOAT,NUMERIC,SMALLMONEY,DATE,TIME,DATETIME2,DATETIMEOFFSET,'




SELECT  
		'Schema'                = TABLE_SCHEMA ,
		'TableName'				= TABLE_NAME ,
		'TableType'             = TABLE_TYPE ,
        'Column_name'           = name,
        'Type'                  = TYPE_NAME(user_type_id),
        'Computed'              = CASE WHEN ColumnProperty(object_id, name, 'IsComputed') = 0 THEN @no ELSE @yes END,
        'Length'                    = CONVERT(INT, max_length),
        'Prec'                  = CASE WHEN  CHARINDEX(TYPE_NAME(system_type_id) + ',', @precscaletypes) > 0
                                    THEN CONVERT(CHAR(5),ColumnProperty(object_id, name, 'precision'))
                                    ELSE '     ' END,
        'Scale'                 = CASE WHEN  CHARINDEX(TYPE_NAME(system_type_id) + ',', @precscaletypes) > 0
                                    THEN CONVERT(CHAR(5),OdbcScale(system_type_id,scale))
                                    ELSE '     ' END,
        'Nullable'              = CASE WHEN  IS_NULLABLE = 0 THEN 'no' ELSE 'yes' END,
        'TrimTrailingBlanks'    = CASE ColumnProperty(OBJECT_ID, name, 'UsesAnsiTrim')
                                    WHEN 1 THEN @no
                                    WHEN 0 THEN @yes
                                    ELSE '(n/a)' END,
        'FixedLenNullInSource'  = CASE 
                    WHEN TYPE_NAME(system_type_id) NOT IN  ('VARBINARY','VARCHAR','BINARY','CHAR')
                        THEN '(n/a)'
                    WHEN IS_NULLABLE = 0 THEN @no ELSE @yes 
                    END,
        'Collation'     = collation_name
    FROM sys.all_columns cols
	JOIN INFORMATION_SCHEMA.TABLES tbls
	ON cols.object_id = OBJECT_ID(tbls.TABLE_NAME)

		WHERE TYPE_NAME(user_type_id) IN ('float')
	   OR (TYPE_NAME(user_type_id) IN ('decimal','numberic')
	  AND CASE WHEN  CHARINDEX(TYPE_NAME(system_type_id) + ',', @precscaletypes) > 0
                                    THEN CONVERT(CHAR(5),OdbcScale(system_type_id,scale))
                                    ELSE '     ' END  = 2)

--SELECT *
--FROM INFORMATION_SCHEMA.TABLES
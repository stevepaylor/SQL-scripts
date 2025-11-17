SELECT TOP (1000) [TableName]
      ,[create_date]
      ,[referencing_schema_name]
      ,[referencing_entity_name]
      ,[Row_Count]
  FROM [CMP13_b4_refresh].[dbo].[temproary_backuptables_nothavingPrimarykey]

  order by [create_date] desc

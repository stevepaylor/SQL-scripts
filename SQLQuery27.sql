DECLARE @SQL NVARCHAR(128) = 'ALTER USER Redshirt2 WITH LOGIN = Redshirt2'

		  EXECUTE sp_executesql @SQL
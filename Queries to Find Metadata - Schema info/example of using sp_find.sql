USE [DBA]
GO

EXEC sp_Find 
	  @SearchText = 'additional%data'
	, @DBName = Null
	, @PreviewTextSize = 100
	, @SearchDBsFlag = 'Y'
	, @SearchJobsFlag = 'N'
	, @SearchSSISFlag = 'N'

GO


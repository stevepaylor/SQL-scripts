
EXECUTE DBA.dbo.IndexOptimize
@Databases = 'CMP13',
@FragmentationLow = NULL,
@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel1 = 5,
@FragmentationLevel2 = 30,
@FillFactor = 90,
@SortInTempdb = 'Y',
@LogToTable = 'Y',
@Indexes = 'CMP13.dbo.tPlayerDir'

EXECUTE DBA.dbo.IndexOptimize
@Databases = 'CMP13',
@FragmentationLow = NULL,
@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel1 = 5,
@FragmentationLevel2 = 30,
@FillFactor = 90,
@SortInTempdb = 'Y',
@LogToTable = 'Y',
@Indexes = 'CMP13.dbo.tPlayerDir'
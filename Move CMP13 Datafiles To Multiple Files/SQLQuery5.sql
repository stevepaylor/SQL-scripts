USE master;
GO
ALTER DATABASE CMP13
ADD FILE
(
    NAME = CMP13_data_1,
    FILENAME = 'G:\CMP13_data_1.ndf',
    SIZE = 400000MB,
    MAXSIZE = 400000MB,
    FILEGROWTH = 0MB
);
GO

--add (@numfiles-1) files to file group
SELECT @loopcntr = 2;
WHILE @loopcntr &lt;= @numfiles BEGIN
    SELECT @NewLogicalName = @LogicalName + '_' + CAST(@loopcntr as varchar(5))
    SELECT @NewPhysicalName = REPLACE(@PhysicalName , '.mdf', '_' + CAST(@loopcntr as varchar(5))+'.ndf')
    SELECT @sql = 'ALTER DATABASE [' + DB_NAME() + '] ADD FILE ('+ @crlf    +
            'NAME = ' + @NewLogicalName + ',' + @crlf + 
            'FILENAME = ' + QUOTENAME(@NewPhysicalName, '''') + ',' + @crlf + 
            'SIZE = ' + CAST(@NewFSizeMB as VARCHAR(max)) + 'MB,' + @crlf +
            'MAXSIZE = ' + CAST(@NewFSizeMB as VARCHAR(max)) + 'MB,' + @crlf + 
            'FILEGROWTH = 0MB) TO FILEGROUP ' + QUOTENAME(@FileGroupName) +';' + @crlf + @crlf
    PRINT @sql
    --exec (@sql)
    SELECT @loopcntr += 1
END
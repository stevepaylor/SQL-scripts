--create FUNCTION dbo.fc_FileExists(@path varchar(8000))
--RETURNS BIT
--AS
--BEGIN
--     DECLARE @result INT
--     EXEC master.dbo.xp_fileexist @path, @result OUTPUT
--     RETURN cast(@result as bit)
--END;
--GO

select DBA.dbo.fc_FileExists('C:\Monitor_SSRS\ReportCurrentTimestampX.txt');

EXEC master.dbo.xp_fileexist '\\CASIDB12PR\Monitor_SSRS\ReportCurrentTimestampX.txt'

EXEC master.dbo.xp_fileexist 'C:\Monitor_SSRS\ReportCurrentTimestampX.CSV'

DECLARE @isExists INT
exec master.dbo.xp_fileexist 'C:\Monitor_SSRS\ReportCurrentTimestampx.txt', 
@isExists OUTPUT
SELECT case @isExists 
when 1 then 'Yes' 
else 'No' 
end as isExists

print @isExists

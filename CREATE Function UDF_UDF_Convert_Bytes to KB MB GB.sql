CREATE FUNCTION UDF_UDF_Convert_Bytes (
@BytesVal BIGINT
,@ConvertTo CHAR(2) -- Kb, Mb, Gb, Tb
)
RETURNS DECIMAL(25,3)
AS 
BEGIN 
RETURN @BytesVal / POWER(1024.0, CASE @ConvertTo
WHEN 'Kb' THEN 1 
WHEN 'Mb' THEN 2
WHEN 'Gb' THEN 3
WHEN 'Tb' THEN 4 
  END ) 
END
--GO 

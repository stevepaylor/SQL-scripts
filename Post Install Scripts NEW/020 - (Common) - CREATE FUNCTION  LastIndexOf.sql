USE DBA
GO

CREATE FUNCTION [dbo].[LastIndexOf] (@stringToFind varchar(max), @stringToSearch varchar(max))
RETURNS INT
AS
BEGIN
    RETURN (LEN(@stringToSearch) - CHARINDEX(@stringToFind,REVERSE(@stringToSearch))) + 1
END
GO
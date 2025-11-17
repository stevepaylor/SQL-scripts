SELECT [SSN], [Salary] FROM [HR].[Employees]

DECLARE @SSN [char](11) = '795-73-9838'
SELECT [SSN], [Salary] FROM [HR].[Employees]
WHERE [SSN] = @SSN
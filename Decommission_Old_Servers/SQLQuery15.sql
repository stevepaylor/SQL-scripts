
/***
..." failed with the following error: "Login failed for user 'LS_RW'.". Possible failure reasons: Problems with the query, "ResultSet" 
	property not set correctly, parameters not set correctly, or connection not established correctly.
**/

[Execute SQL Task] Error: Executing the query "DECLARE @CTR INT;
SET @CTR = 1;

WHILE @CTR < 10
	..." failed with the following error: "Could not find server 'OPSDBA01PR' in sys.servers. Verify that the correct server name was specified. 
	If necessary, execute the stored procedure sp_addlinkedserver to add the server to sys.servers.". 
	Possible failure reasons: Problems with the query, "ResultSet" property not set correctly, parameters not set correctly, or connection 
	not established correctly.


	DECLARE @CTR INT;
SET @CTR = 1;

WHILE @CTR < 10
	BEGIN 
		INSERT INTO OPSDBA01PR.TESTDB1.dbo.Table1 (Col1, Col2)
		VALUES ('Some data from SSIS package on MSBIDB01DV thru connection to OPSDBA01PR', @CTR)
	
	SET @CTR = @CTR + 1;
END 

[Execute SQL Task] Error: Executing the query "DECLARE @CTR INT;
SET @CTR = 1;

WHILE @CTR < 10
	..." failed with the following error: "Could not find server 'OPSDBA01PR' in sys.servers. Verify that the correct server name was specified. If necessary, execute the stored procedure sp_addlinkedserver to add the server to sys.servers.". Possible failure reasons: Problems with the query, "ResultSet" property not set correctly, parameters not set correctly, or connection not established correctly.


	Could not find server  in sys.servers. Verify that the correct server name was specified. 
	If necessary, execute the stored procedure sp_addlinkedserver to add the server to sys.servers.". 
	Possible failure reasons: Problems with the query, "ResultSet" property not set correctly, parameters not set correctly, or connection 
	not established correctly.
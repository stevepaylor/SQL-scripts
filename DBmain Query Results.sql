EXEC msdb.dbo.sp_send_dbmail
@recipients=N'spaylor@viejas.com',
@body='Query Results Are Attached', 
@subject ='Query Results',
@profile_name ='SSISDB22PR',
@query ='exec MyViejasSSIS.dbo.USP_MV_File_Upload_Confirm', 
@attach_query_result_as_file = 1,
@query_result_separator =',',
@query_result_no_padding=1,
@query_attachment_filename ='QueryResults.csv'

USE msdb ;  
GO  

EXEC dbo.sp_update_schedule  
    @name = 'Sunday at 10PM',  
    @new_name = '01 - Sunday at 10PM' ;  
GO 

EXEC dbo.sp_update_schedule  
    @name = 'Sunday at 11:30PM',  
    @new_name = '02 - Sunday at 11:30PM' ;  

EXEC dbo.sp_update_schedule  
    @name = 'Monday at 1AM',  
    @new_name = '03 - Monday at 1AM' ;  
GO 

EXEC dbo.sp_update_schedule  
    @name = 'Monday at 10PM',  
    @new_name = '04 - Monday at 10PM' ;  
GO 

EXEC dbo.sp_update_schedule  
    @name = 'Monday at 11:30PM',  
    @new_name = '05 - Monday at 11:30PM'  ;  

EXEC dbo.sp_update_schedule  
    @name = 'Tuesday at 1AM',  
    @new_name = '06 - Tuesday at 1AM' ;  
GO 

EXEC dbo.sp_update_schedule  
    @name = 'Tuesday at 10PM',  
    @new_name = '07 - Tuesday at 10PM' ;  
GO 

EXEC dbo.sp_update_schedule  
    @name = 'Tuesday at 11:30PM',  
    @new_name = '08 - Tuesday at 11:30PM' ;  

EXEC dbo.sp_update_schedule  
    @name = 'Wednesday at 1AM',  
    @new_name = '09 - Wednesday at 1AM' ;  
GO 


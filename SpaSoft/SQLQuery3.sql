/* userfile fix */
ALTER TABLE userfile 
ADD flag1_1 VARCHAR(max) NULL, 
    flag2_1 VARCHAR(max) NULL, 
    flag4_1 VARCHAR(max) NULL, 
    flag5_1 VARCHAR(max) NULL;
	
go

update userfile set flag1_1 = flag1,
					flag2_1 = flag2,
					flag4_1 = flag4,
					flag5_1 = flag5;

go
					
ALTER TABLE userfile 
DROP COLUMN flag1, 
		flag2, 
		flag4, 
		flag5;

go
		
ALTER TABLE userfile 
ADD flag1 VARCHAR(max) NULL, 
    flag2 VARCHAR(max) NULL, 
    flag4 VARCHAR(max) NULL, 
    flag5 VARCHAR(max) NULL;

go
	
update userfile set flag1 = flag1_1,
					flag2 = flag2_1,
					flag4 = flag4_1,
					flag5 = flag5_1;

go
					
ALTER TABLE userfile 
DROP COLUMN flag1_1, 
		flag2_1, 
		flag4_1, 
		flag5_1;

go
		

/* kuserfile fix */
ALTER TABLE kuserfile 
ADD flag1_1 VARCHAR(max) NULL, 
    flag2_1 VARCHAR(max) NULL, 
    flag4_1 VARCHAR(max) NULL, 
    flag5_1 VARCHAR(max) NULL;

go

update kuserfile set flag1_1 = flag1,
					flag2_1 = flag2,
					flag4_1 = flag4,
					flag5_1 = flag5;

go

ALTER TABLE kuserfile 
DROP COLUMN flag1, 
		flag2, 
		flag4, 
		flag5;
		
go

ALTER TABLE kuserfile 
ADD flag1 VARCHAR(max) NULL, 
    flag2 VARCHAR(max) NULL, 
    flag4 VARCHAR(max) NULL, 
    flag5 VARCHAR(max) NULL;

go

update kuserfile set flag1 = flag1_1,
					flag2 = flag2_1,
					flag4 = flag4_1,
					flag5 = flag5_1;

go

ALTER TABLE kuserfile 
DROP COLUMN flag1_1, 
		flag2_1, 
		flag4_1, 
		flag5_1;

go
		
/* gsys_userfile fix */
ALTER TABLE gsys_userfile 
ADD flag1_1 VARCHAR(max) NULL, 
    flag2_1 VARCHAR(max) NULL, 
    flag4_1 VARCHAR(max) NULL, 
    flag5_1 VARCHAR(max) NULL;
	
go

update gsys_userfile set flag1_1 = flag1,
					flag2_1 = flag2,
					flag4_1 = flag4,
					flag5_1 = flag5;

go
					
ALTER TABLE gsys_userfile 
DROP COLUMN flag1, 
		flag2, 
		flag4, 
		flag5;

go
		
ALTER TABLE gsys_userfile 
ADD flag1 VARCHAR(max) NULL, 
    flag2 VARCHAR(max) NULL, 
    flag4 VARCHAR(max) NULL, 
    flag5 VARCHAR(max) NULL;

go
	
update gsys_userfile set flag1 = flag1_1,
					flag2 = flag2_1,
					flag4 = flag4_1,
					flag5 = flag5_1;

go
					
ALTER TABLE gsys_userfile 
DROP COLUMN flag1_1, 
		flag2_1, 
		flag4_1, 
		flag5_1;

go
		
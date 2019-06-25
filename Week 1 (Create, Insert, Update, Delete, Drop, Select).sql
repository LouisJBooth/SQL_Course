-- 0. Drop table INSTRUCTOR in case it already exists
DROP TABLE INSTRUCTOR ;

-- ***Solution***
-- drop table INSTRUCTOR
-- ;



-- 1. Create table INSTRUCTOR
CREATE TABLE INSTRUCTOR (
	INS_ID INT NOT NULL PRIMARY KEY,
	LASTNAME VARCHAR(255) NOT NULL,
	FIRSTNAME VARCHAR(255),
	CITY VARCHAR(255),
	COUNTRY CHAR(2)) ;
	
-- ***Solution***
-- CREATE TABLE INSTRUCTOR
--   (ins_id INTEGER PRIMARY KEY NOT NULL, 
--    lastname VARCHAR(15) NOT NULL, 
--    firstname VARCHAR(15) NOT NULL, 
--    city VARCHAR(15), 
--    country CHAR(2)
--   )
--   ;

-- Defaulted to VARCHAR(255) for names out of habit; chose not to restrict columns from having null values (save for the primary key and last name) 
-- as incomplete data is better than no data, and it can always be discarded or corrected for later 



-- 2A. Insert single row for Rav Ahuja
INSERT INTO INSTRUCTOR
	(INS_ID, LASTNAME, FIRSTNAME, CITY, COUNTRY)
VALUES
	('1', 'Ahuja', 'Rav', 'Toronto', 'CA') ;

-- ***Solution***
-- INSERT INTO INSTRUCTOR
--   (ins_id, lastname, firstname, city, country)
--   VALUES 
--   (1, 'Ahuja', 'Rav', 'Toronto', 'CA')
-- ;



-- 2B. Insert the two rows for Raul and Hima
INSERT INTO INSTRUCTOR
	(INS_ID, LASTNAME, FIRSTNAME, CITY, COUNTRY)
VALUES
	('2', 'Chong', 'Raul', 'Toronto', 'CA'),
	('3', 'Vasudevan', 'Hima', 'Chicago', 'US') ;

-- ***Solution***
-- INSERT INTO INSTRUCTOR
--   VALUES
--   (2, 'Chong', 'Raul', 'Toronto', 'CA'),
--   (3, 'Vasudevan', 'Hima', 'Chicago', 'US')
-- ;



-- 3. Select all rows in the table
SELECT * FROM INSTRUCTOR ;

-- ***Solution***
-- SELECT * FROM INSTRUCTOR
-- ;



-- 3B. Select FIRSTNAME, LASTNAME and COUNTRY where CITY is Toronto
SELECT FIRSTNAME,
	LASTNAME,
	COUNTRY
FROM INSTRUCTOR
WHERE CITY = 'Toronto' ;

-- ***Solution***
-- SELECT firstname, lastname, country from INSTRUCTOR where city='Toronto'
-- ;



-- 4. Change the city for Rav to Markham
UPDATE INSTRUCTOR
SET CITY = 'Markham'
WHERE INS_ID = 1 ;

-- ***Solution***
-- UPDATE INSTRUCTOR SET city='Markham' where ins_id=1
-- ;



-- 5. Delete the row for Raul Chong
DELETE FROM INSTRUCTOR
WHERE INS_ID = 2 ;

-- ***Solution***
-- DELETE FROM INSTRUCTOR where ins_id=2
-- ;



-- 5B. Retrieve all rows from the table
SELECT * FROM INSTRUCTOR ;

-- ***Solution***
-- SELECT * FROM INSTRUCTOR 
-- ;
------------------------------------------
--DDL statement for table 'HR' database--
--------------------------------------------

CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL, 
                            F_NAME VARCHAR(255) NOT NULL,  -- Edit: 255 bytes
                            L_NAME VARCHAR(255) NOT NULL,  -- Edit: 255 bytes
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(255), -- Edit: 255 bytes
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));
                            
 CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL, 
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));
 
 CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL, 
                            JOB_TITLE VARCHAR(255) ,  -- Edit: 255 bytes
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL, 
                            DEP_NAME VARCHAR(255) ,  -- Edit: 255 bytes
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9) NOT NULL,  --Edit: Add NOT NULL condition for Primary Key
                            PRIMARY KEY (LOC_ID));  -- Edit: Change Primary Key

CREATE TABLE LOCATIONS (
                            LOC_ID CHAR(9) NOT NULL,  -- Edit: LOCT_ID to LOC_ID
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOC_ID,DEP_ID_LOC));  -- Edit: LOCT_ID to LOC_ID
 
 -- Question 1: Were there any warnings loading data into the JOBS table?
 -- What can be done to resolve this?
 
 -- 1. JOB_TITLE column was restricted to 15 bytes, rows were truncated due to this constraint,
 -- the fix is to increase the byte limit (accounting for a 1 or 2 byte prefix),
 -- chose to go with 255 to account for the possibility of different types of encoding


-- Question 2: Did all rows from the source file load successfully in the DEPARTMENT table? If not,
-- are you able to figure out why not? 

-- 2. The primary key for DEPARTMENTS is not unique, DEPT_ID_DEP holds the value of 5 for two separate rows.
-- A better primary key for this table is LOC_ID, which is unique to each location



-- Query 1: Retrieve all employees whose address is in Elgin,IL 
SELECT EMP_ID, F_NAME, L_NAME, ADDRESS
FROM EMPLOYEES
WHERE ADDRESS LIKE '%Elgin,IL%' ;
-- ***Solution***
-- select F_NAME , L_NAME
-- from EMPLOYEES
-- where ADDRESS LIKE '%Elgin,IL%' ;


-- Query 2: Retrieve all employees who were born during the 1970's.
SELECT EMP_ID, F_NAME, L_NAME, B_DATE
FROM EMPLOYEES
WHERE B_DATE BETWEEN '01-01-1970' AND '12-31-1979' ;
-- Or
SELECT EMP_ID, F_NAME, L_NAME, B_DATE
FROM EMPLOYEES
WHERE B_DATE LIKE '%197%' ;
-- ***Solution***
-- select F_NAME , L_NAME
-- from EMPLOYEES
-- where B_DATE LIKE '197%' ;


-- Query 3: Retrieve all employees in department 5 whose salary is between 60000 and 70000 .
SELECT EMP_ID, F_NAME, L_NAME, DEP_ID, SALARY
FROM EMPLOYEES
WHERE DEP_ID in ('5')
AND (SALARY BETWEEN 60000 AND 70000)
ORDER BY SALARY ;
-- ***Solution***
-- select *
-- from EMPLOYEES
-- where (SALARY BETWEEN 60000 and 70000)  and DEP_ID = 5 ;


-- Query 4A: Retrieve a list of employees ordered by department ID.
SELECT EMP_ID, F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID ;
-- ***Solution***
-- select F_NAME, L_NAME, DEP_ID 
-- from EMPLOYEES
-- order by DEP_ID;


-- Query 4B: Retrieve a list of employees ordered in descending order by department ID and
-- within each department ordered alphabetically in descending order by last name. 
SELECT EMP_ID, F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC ;
-- ***Solution***
-- select F_NAME, L_NAME, DEP_ID 
-- from EMPLOYEES
-- order by DEP_ID desc, L_NAME desc;


-- Query 5A: For each department ID retrieve the number of employees in the department.
SELECT DEP_ID, COUNT(EMP_ID) AS EMPLOYEE_CNT
FROM EMPLOYEES
GROUP BY DEP_ID ;
-- Or
SELECT DEP_ID, COUNT(*) AS EMPLOYEE_CNT
FROM EMPLOYEES
GROUP BY DEP_ID ;
-- ***Solution***
-- select DEP_ID, COUNT(*)
-- from EMPLOYEES
-- group by DEP_ID;


-- Query 5B: For each department retrieve the number of employees in the department,
-- and the average employees salary in the department. 
SELECT DEP_ID, COUNT(*) AS EMPLOYEE_CNT, CAST(AVG(SALARY) AS DECIMAL(10,2)) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID ;
-- ***Solution***
-- select DEP_ID, COUNT(*), AVG(SALARY)
-- from EMPLOYEES
-- group by DEP_ID;


-- Query 5C: Label the computed columns in the result set of Query 5B
-- as “NUM_EMPLOYEES” and “AVG_SALARY”.
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, CAST(AVG(SALARY) AS DECIMAL(10,2)) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID ;
-- ***Solution***
-- select DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
-- from EMPLOYEES
-- group by DEP_ID;


-- Query 5D: In Query 5C order the result set by Average Salary.
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, CAST(AVG(SALARY) AS DECIMAL(10,2)) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY AVG_SALARY ;
-- ***Solution***
-- select DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
-- from EMPLOYEES
-- group by DEP_ID
-- order by AVG_SALARY;


-- Query 5E: In Query 5D limit the result to departments with fewer than 4 employees.
SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEES, CAST(AVG(SALARY) AS DECIMAL(10,2)) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING COUNT(*) <= 3
ORDER BY AVG_SALARY ;
-- ***Solution***
-- select DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
-- from EMPLOYEES
-- group by DEP_ID
-- having count(*) < 4
-- order by AVG_SALARY;
--5E alternative: if you want to use the label
-- select DEP_ID, NUM_EMPLOYEES, AVG_SALARY from
--   ( select DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY from EMPLOYEES group by DEP_ID)
--   where NUM_EMPLOYEES < 4
-- order by AVG_SALARY;


-- BONUS Query 6: Similar to 4B but instead of department ID use department name.
-- Retrieve a list of employees ordered by department name, and within
-- each department ordered alphabetically in descending order by last name. 
SELECT B.DEP_NAME, A.EMP_ID, A.F_NAME, A.L_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.DEP_ID = B.DEPT_ID_DEP
ORDER BY B.DEP_NAME, A.L_NAME DESC ;
-- ***Solution***
-- select D.DEP_NAME , E.F_NAME, E.L_NAME
-- from EMPLOYEES as E, DEPARTMENTS as D
-- where E.DEP_ID = D.DEPT_ID_DEP
-- order by D.DEP_NAME, E.L_NAME desc ;
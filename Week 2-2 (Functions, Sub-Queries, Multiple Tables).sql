-- Sub-query in WHERE clause
-- Employees earning more than the average salary
SELECT EMP_ID, F_NAME, L_NAME, SALARY
	FROM EMPLOYEES
	WHERE SALARY <
	(SELECT AVG(SALARY) FROM EMPLOYEES) ;

-- Sub-query in SELECT clause (Column Expression)
-- Comparing employee salary with average salary
SELECT EMP_ID, 
	SALARY,
	(SELECT CAST(AVG(SALARY) AS DECIMAL(10,2))
		FROM EMPLOYEES) AS AVG_SALARY
	FROM EMPLOYEES ;

-- Sub-query in FROM clause (Derived Table/Table Expression)
-- Select specific columns from table
SELECT * FROM
	(SELECT EMP_ID, F_NAME, L_NAME, DEP_ID
		FROM EMPLOYEES) AS EMP4ALL ;

-- Accessing multiple tables		
-- Retrieve only employee records in the EMPLOYEES table
-- that correspond to departments in the DEPARTMENTS table
SELECT * FROM EMPLOYEES
	WHERE DEP_ID IN (SELECT DEPT_ID_DEP FROM DEPARTMENTS) ;
	
-- Multiple tables with sub-query
-- Retrieve list of employees from EMPLOYEES table
-- that are from specific locations in DEPARTMENTS table
SELECT * FROM EMPLOYEES
	WHERE DEP_ID IN (SELECT DEPT_ID_DEP FROM DEPARTMENTS
						WHERE LOC_ID = 'L0002') ;
						
-- Retrieve department id and name for employees from DEPARTMENTS table
-- who earn more than $70,000 (SALARY from EMPLOYEES table)
SELECT DEPT_ID_DEP, DEP_NAME
	FROM DEPARTMENTS
	WHERE DEPT_ID_DEP IN (SELECT DEP_ID FROM EMPLOYEES
		WHERE SALARY > 70000) ;
		
-- Implicit join
-- Full join
SELECT * FROM EMPLOYEES, DEPARTMENTS ;
-- Using additional operands to limit the result set
SELECT * FROM EMPLOYEES, DEPARTMENTS
	WHERE EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP ;
-- Alias approach
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
	WHERE E.DEP_ID = D.DEPT_ID_DEP ;
-- Department name for each employee
SELECT EMPLOYEES.EMP_ID, DEPARTMENTS.DEP_NAME
	FROM EMPLOYEES, DEPARTMENTS
	WHERE EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP ;
-- Alias approach
SELECT E.EMP_ID, D.DEP_NAME
	FROM EMPLOYEES E, DEPARTMENTS D
	WHERE E.DEP_ID = D.DEPT_ID_DEP ;
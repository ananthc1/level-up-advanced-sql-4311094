select firstname, lastname, title,
employeeId, managerId 
from employee
LIMIT 10;

select model, EngineType
from model
limit 5;

select sql
from sqlite_schema
where name = 'employee';

-- Create a list of employees and their immediate manager...
SELECT emp.firstName, emp.lastName, emp.title,
--emp.employeeId, 
mng.firstName AS Manager_FirstName, mng.lastName as Manager_LastName
--,mng.employeeId AS managerId
from employee emp
INNER JOIN employee mng
on emp.managerId = mng.employeeId;

select sql
from sqlite_schema
where name = 'sales';

select title, count(employeeId) as count from employee GROUP by title;
select firstName, lastName, title from employee where title = 'CEO'; 

-- Find sales people who have zero sales
SELECT emp.firstName, emp.lastName, emp.title, emp.startDate, sls.salesId
from employee emp
LEFT JOIN sales sls 
on emp.employeeId=sls.employeeId
WHERE emp.title = 'Sales Person' AND sls.salesId IS NULL; -- IS NOT NULL

select sql
from sqlite_schema
where name = 'customer'; -- sales, 

-- List all customers & their sales, even if some data is gone --
SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus
INNER JOIN sales sls
    ON cus.customerId = sls.customerId 
UNION
-- UNION WITH CUSTOMERS WHO HAVE NO SALES
SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus
LEFT JOIN sales sls
    ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL
/*SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM sales sls 
LEFT JOIN customer cus 
ON sls.customerId = cus.customerId
WHERE sls.salesId IS NULL */
UNION
-- UNION WITH SALES MISSING CUSTOMER DATA
SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM sales sls
LEFT JOIN customer cus
    ON cus.customerId = sls.customerId
    --ON sls.customerId = cus.customerId
WHERE cus.customerId IS NULL;

/*SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus
LEFT JOIN sales sls 
    ON cus.customerId = sls.customerId
WHERE cus.customerId IS NULL;*/.....

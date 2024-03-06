/*
 * Q2 
 * A new government initiative to get more young people into work 
 * cuts the salary levels of all workers under 25 by 20%. 
 * Write an SQL statement to implement this policy change.
 */
UPDATE Employees
SET    salary = 0.8 * salary
WHERE  age < 25;

/*
 * Q3
 * The company has several years of growth and high profits, 
 * and considers that the Sales department is primarily responsible for this. 
 * Write an SQL statement to give all employees in the Sales department a 10% pay rise.
 */
UPDATE Employees
SET salary = 1.1 * salary
WHERE eid in (
    -- Since dname doesn't exist in the Employees table, use a subquery
    SELECT eid
    FROM WorksIn AS W
    JOIN Departments AS D on W.did = D.did 
    WHERE Departments.dname = 'Sales'
);



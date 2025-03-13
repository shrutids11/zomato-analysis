/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`classicmodels` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `classicmodels`;
-- 1--
CREATE TABLE Department (
    deptno INT PRIMARY KEY,
    dname VARCHAR(50),
    loc VARCHAR(50)
);

CREATE TABLE Employee (
    empno INT PRIMARY KEY,             
    ename VARCHAR(50) NOT NULL,
    job VARCHAR(20) DEFAULT 'CLERK',    
    mgr INT,
    hiredate DATE,
    sal DECIMAL(10, 2) CHECK (sal > 0), 
    comm DECIMAL(10, 2),
    deptno INT,                         
    FOREIGN KEY (deptno) REFERENCES Department(deptno)
);

INSERT INTO Department (deptno, dname, loc) VALUES
(10, 'OPERATIONS','BOSTON'),
(40, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO');

INSERT INTO Employee (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000.00, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100.00, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);

select * from Employee;

USE `classicmodels`;
-- 2--
CREATE TABLE Dept (
    deptno INT PRIMARY KEY,
    dname VARCHAR(50),
    loc VARCHAR(50)
);

INSERT INTO Dept (deptno, dname, loc) VALUES
(10, 'OPERATIONS', 'BOSTON'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'ACCOUNTING', 'NEW YORK');

select * from Dept;
-- 3 --
SELECT ename, sal
FROM employee
WHERE sal > 1000;

-- 4--
SELECT *
FROM employee
WHERE hiredate < '1981-09-30';

-- 5-- 

SELECT ename
FROM employee
WHERE ename LIKE '_I%';

-- 6 --

SELECT 
    ename AS "Employee Name",
    sal AS "Basic Salary",
    sal * 0.40 AS "Allowances",
    sal * 0.10 AS "P.F.",
    (sal + (sal * 0.40) - (sal * 0.10)) AS "Net Salary"
FROM 
    employee;
    
    -- 7 -- 
    
    SELECT 
    ename AS "Employee Name", 
    job  AS "designation"
FROM 
    employee
WHERE 
    mgr  IS NULL;

-- 8 -- 

SELECT 
    empno AS "Employee Number", 
    ename AS "Employee Name", 
    salary AS "Salary"
FROM 
    employees
ORDER BY 
    salary ASC;

-- 9 -- 

SELECT COUNT(DISTINCT job ) AS "Number of Job"
FROM employee;

-- 10 -- 

SELECT SUM(sal + COALESCE(comm, 0)) AS "Total Payable Salary"
FROM employee
WHERE job = 'SALESMAN';

-- 11 -- 

SELECT 
    deptno AS "Department Number", 
    job AS "Job Title", 
    AVG(sal) AS "Average Monthly Salary"
FROM 
    employee
GROUP BY 
    deptno, job
ORDER BY 
    deptno, job;
    
    -- 11 -- 

SELECT 
    Employee.ename AS EMPNAME, 
    Employee.sal AS SALARY, 
    Department.dname AS DEPTNAME
FROM 
    Employee
JOIN 
    Department
ON 
    Employee.deptno = Department.deptno;

-- 14 -- 

CREATE TABLE JobGrades (
    grade CHAR(1) PRIMARY KEY,
    lowest_sal INT NOT NULL,
    highest_sal INT NOT NULL
);

INSERT INTO JobGrades (grade, lowest_sal, highest_sal)
VALUES 
('A', 0, 999),
('B', 1000, 1999),
('C', 2000, 2999),
('D', 3000, 3999),
('E', 4000, 5000);

select * from JobGrades

-- 14 --

USE `classicmodels`;

select 
    ename AS EMPLOYEE_NAME, 
    sal AS SALARY, 
    grade AS GRADE
FROM 
    Employee
JOIN 
    JobGrades
ON 
    sal >= lowest_sal 
    AND sal <= highest_sal;
    
    -- 15 -- 
    
    SELECT 
    e1.ename AS EMPLOYEE, 
    COALESCE(e2.ename, 'No Manager') AS MANAGER
FROM 
    Employee e1
LEFT JOIN 
    Employee e2
ON 
    e1.mgr = e2.empno;
    
    -- 16 -- 
    
    SELECT 
    ename AS EMPNAME, 
    (sal + COALESCE(comm, 0)) AS TOTAL_SAL
FROM 
    Employee;
    
    -- 17 -- 
    
    SELECT 
    ename AS EMPNAME, 
    sal AS SALARY
FROM 
    Employee
WHERE 
    MOD(empno, 2) = 1; 
    
    -- 18 -- 
    
    SELECT 
    ename AS EMPNAME,
    RANK() OVER (ORDER BY sal DESC) AS ORG_SAL_RANK,
    RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS DEPT_SAL_RANK
FROM 
    Employee;
    
    -- 19 --
    
    SELECT 
    ename AS EMPNAME, 
    sal AS SALARY
FROM 
    Employee
ORDER BY 
    sal DESC
LIMIT 3;

-- 20 -- 

SELECT 
    ename AS EMPNAME, 
    deptno AS DEPARTMENT, 
    sal AS SALARY
FROM 
    (SELECT 
         ename, 
         deptno, 
         sal, 
         RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS rnk
     FROM 
         Employee) AS ranked
WHERE 
    rnk = 1;
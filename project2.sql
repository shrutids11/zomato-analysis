USE `classicmodels`;
-- 1 -- 
CREATE TABLE Salespeople (
    snum INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50),
    comm DECIMAL(4, 2)
);
INSERT INTO Salespeople (snum, sname, city, comm) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1003, 'Axelrod', 'New York', 0.10),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15);
SELECT * FROM Salespeople;

-- 2 -- 
CREATE TABLE Cust (
    cnum INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50),
    rating INT,
    snum INT
);
INSERT INTO Cust (cnum, cname, city, rating, snum) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004),
(2008, 'James', 'London', 200, 1007);
SELECT * FROM Cust;

-- 3 -- 
CREATE TABLE Orders (
    onum INT PRIMARY KEY,
    amt DECIMAL(10, 2),
    odate DATE,
    cnum INT,
    snum INT
);
INSERT INTO Orders (onum, amt, odate, cnum, snum) VALUES
(3001, 18.69, '1994-10-03', 2008, 1007),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2006, 1007),
(3009, 1713.23, '1994-10-04', 2002, 1003),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);
SELECT * FROM Orders;

-- 4 -- 

SELECT 
    s.snum AS Salesperson_Number,
    s.sname AS Salesperson_Name,
    s.city AS Salesperson_City,
    c.cnum AS Customer_Number,
    c.cname AS Customer_Name,
    c.city AS Customer_City
FROM 
    Salespeople s
INNER JOIN 
    Cust c
ON 
    s.city = c.city;
    
    -- 5 -- 
    
    SELECT 
    c.cname AS Customer_Name,
    s.sname AS Salesperson_Name
FROM 
    Cust c
INNER JOIN 
    Salespeople s
ON 
    c.snum = s.snum;
    
    -- 6 -- 
    SELECT 
    o.onum AS Order_Number,
    o.amt AS Order_Amount,
    o.odate AS Order_Date,
    c.cname AS Customer_Name,
    c.city AS Customer_City,
    s.sname AS Salesperson_Name,
    s.city AS Salesperson_City
FROM 
    Orders o
INNER JOIN 
    Cust c ON o.cnum = c.cnum
INNER JOIN 
    Salespeople s ON o.snum = s.snum
WHERE 
    c.city <> s.city;

-- 7 -- 
SELECT 
    o.onum AS Order_Number,
    c.cname AS Customer_Name
FROM 
    Orders o
INNER JOIN 
    Cust c
ON 
    o.cnum = c.cnum;
    
    -- 8 -- 
    SELECT 
    c1.cname AS Customer1_Name,
    c2.cname AS Customer2_Name,
    c1.rating AS Shared_Rating
FROM 
    Cust c1
INNER JOIN 
    Cust c2
ON 
    c1.rating = c2.rating 
    AND c1.cnum < c2.cnum; 
    
    -- 9 -- 
    SELECT 
    c1.cname AS Customer1_Name,
    c2.cname AS Customer2_Name,
    s.sname AS Salesperson_Name
FROM 
    Cust c1
INNER JOIN 
    Cust c2
ON 
    c1.snum = c2.snum 
    AND c1.cnum < c2.cnum -- Ensure each pair is listed only once
INNER JOIN 
    Salespeople s
ON 
    c1.snum = s.snum;
    
    -- 10 -- 
    SELECT 
    s1.sname AS Salesperson1_Name,
    s2.sname AS Salesperson2_Name,
    s1.city AS Shared_City
FROM 
    Salespeople s1
INNER JOIN 
    Salespeople s2
ON 
    s1.city = s2.city 
    AND s1.snum < s2.snum; 
    
    -- 11 -- 
    
   SELECT o.*
FROM Orders o
JOIN Cust c ON o.cnum = c.cnum
WHERE c.snum = (SELECT snum FROM Cust WHERE cnum = 2008);

-- 12 -- 

SELECT o.*
FROM Orders o
WHERE o.odate = '1994-10-04'
AND o.amt > (SELECT AVG(amt) FROM Orders WHERE odate = '1994-10-04');

-- 13 -- 
SELECT o.*
FROM Orders o
JOIN Salespeople s ON o.snum = s.snum
WHERE s.city = 'London';

-- 14 -- 
SELECT c.*
FROM Cust c
JOIN Salespeople s ON c.snum = s.snum
WHERE s.sname = 'Serres' 
AND c.cnum > (s.snum + 1000);

-- 15 -- 

SELECT COUNT(*)
FROM Cust c
WHERE c.rating > (SELECT AVG(rating) FROM Cust WHERE city = 'San Jose');

-- 16 -- 

SELECT s.snum, s.sname
FROM Salespeople s
JOIN Cust c ON s.snum = c.snum
GROUP BY s.snum, s.sname
HAVING COUNT(c.cnum) > 1;
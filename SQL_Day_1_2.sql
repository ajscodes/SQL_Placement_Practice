-- Create the DEPT table first, as PERSON depends on it
CREATE TABLE DEPT (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE,
    DepartmentCode VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(50) NOT NULL
);

-- Create the PERSON table with a Foreign Key
CREATE TABLE PERSON (
    PersonID INT PRIMARY KEY,
    PersonName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(8, 2) NOT NULL,
    JoiningDate DATE NOT NULL,
    City VARCHAR(100) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES DEPT(DepartmentID)
);

-- Insert data into the DEPT table
INSERT INTO DEPT (DepartmentID, DepartmentName, DepartmentCode, Location)
VALUES
(1, 'Admin', 'Adm', 'A-Block'),
(2, 'Computer', 'CE', 'C-Block'),
(3, 'Civil', 'CI', 'G-Block'),
(4, 'Electrical', 'EE', 'E-Block'),
(5, 'Mechanical', 'ME', 'B-Block'),
(6, 'Marketing', 'Mkt', 'F-Block'),
(7, 'Accounts', 'Acc', 'A-Block');

-- Insert data into the PERSON table
INSERT INTO PERSON (PersonID, PersonName, DepartmentID, Salary, JoiningDate, City)
VALUES
(101, 'Rahul Tripathi', 2, 56000.00, '2000-01-01', 'Rajkot'),
(102, 'Hardik Pandya', 3, 18000.00, '2001-09-25', 'Ahmedabad'),
(103, 'Bhavin Kanani', 4, 25000.00, '2000-05-14', 'Baroda'),
(104, 'Bhoomi Vaishnav', 1, 39000.00, '2005-02-08', 'Rajkot'),
(105, 'Rohit Topiya', 2, 17000.00, '2001-07-23', 'Jamnagar'),
(106, 'Priya Menpara', NULL, 9000.00, '2000-10-18', 'Ahmedabad'),
(107, 'Neha Sharma', 2, 34000.00, '2002-12-25', 'Rajkot'),
(108, 'Nayan Goswami', 3, 25000.00, '2001-07-01', 'Rajkot'),
(109, 'Mehul Bhundiya', 4, 13500.00, '2005-01-09', 'Baroda'),
(110, 'Mohit Maru', 5, 14000.00, '2000-05-25', 'Jamnagar'),
(111, 'Alok Nath', 2, 36000.00, '2003-03-15', 'Ahmedabad'),
(112, 'Seema Jain', 3, 28000.00, '2002-06-18', 'Baroda'),
(113, 'Karan Singh', 1, 41000.00, '2004-11-30', 'Rajkot'),
(114, 'Riya Gupta', 5, 16000.00, '2001-02-12', 'Ahmedabad'),
(115, 'Suresh Patel', 7, 32000.00, '2003-08-20', 'Jamnagar'),
(116, 'Meena Kumari', 7, 30000.00, '2004-01-01', 'Rajkot'),
(117, 'Vikram Batra', NULL, 11000.00, '2005-04-05', 'Baroda');

--DEPT:

--PART-A:

--1. Combine information from Person and Department table using cross join or Cartesian product.
SELECT P.PersonName, D.DepartmentName FROM PERSON P, DEPT D
SELECT P.PersonName, D.DepartmentName FROM PERSON P CROSS JOIN DEPT D

--2. Find all persons with their department name.
SELECT P.PersonName, D.DepartmentName FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID

--3. Find all persons with their department name & code.
SELECT P.PersonName, D.DepartmentName, D.DepartmentCode FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID

--4. Find all persons with their department code and location.
SELECT P.PersonName, D.DepartmentCode, D.Location FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID

--5. Find the detail of the person who belongs to Mechanical department.
SELECT P.PersonID, P.PersonName, P.DepartmentID, P.Salary, P.JoiningDate, P.City FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID WHERE D.DepartmentName = 'MECHANICAL'

--6. Final person’s name, department code and salary who lives in Ahmedabad city.
SELECT P.PersonName, D.DepartmentCode, P.Salary FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID WHERE P.City = 'AHMEDABAD'

--7. Find the person's name whose department is in C-Block.
SELECT P.PersonName FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID WHERE D.Location = 'C-BLOCK' 

--8. Retrieve person name, salary & department name who belongs to Jamnagar city.
SELECT P.PersonName, P.Salary, D.DepartmentName FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID WHERE P.City = 'JAMNAGAR'

--9. Retrieve person’s detail who joined the Civil department after 1-Aug-2001.
SELECT P.PersonID, P.PersonName, P.DepartmentID, P.Salary, P.JoiningDate, P.City FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID WHERE D.DepartmentName = 'CIVIL' AND P.JoiningDate > '1-AUG-2001'

--10. Display all the person's name with the department whose joining date difference with the current date is more than 365 days.
SELECT P.PersonName, D.DepartmentName FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID WHERE DATEDIFF(DAY,JoiningDate, GETDATE()) > 365

--11. Find department wise person counts.
SELECT D.DepartmentName, COUNT(P.PersonID) FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID GROUP BY D.DepartmentName

--12. Give department wise maximum & minimum salary with department name.
SELECT D.DepartmentName, MAX(P.Salary), MIN(P.Salary) FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID GROUP BY D.DepartmentName

--13. Find city wise total, average, maximum and minimum salary. 
SELECT P.City, SUM(P.Salary), AVG(P.Salary), MAX(P.Salary), MIN(P.Salary) FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID GROUP BY P.City

--14. Find the average salary of a person who belongs to Ahmedabad city.
SELECT AVG(P.Salary) FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID WHERE P.City = 'AHMEDABAD'

--15. Produce Output Like: <PersonName> lives in <City> and works in <DepartmentName> Department.
SELECT 
	P.PersonName + 'LIVES IN' + P.City + 'AND WORKS IN' + D.DepartmentName
FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID


--PART-B:

--1. Produce Output Like: <PersonName> earns <Salary> from <DepartmentName> department monthly.
SELECT P.PersonName + ' EARN ' + CAST(P.Salary AS varchar(50)) + ' FROM ' + D.DepartmentName + ' DEPARTMENT MONTHLY.' FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID 

--2. Find city & department wise total, average & maximum salaries.
SELECT P.City, D.DepartmentName, SUM(P.Salary), AVG(P.Salary), MAX(P.Salary) FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID GROUP BY P.City, D.DepartmentName

--3. Find all persons who do not belong to any department.
SELECT P.PersonID, P.PersonName, P.DepartmentID, P.Salary, P.JoiningDate, P.City FROM PERSON P LEFT JOIN DEPT D ON P.DepartmentID = D.DepartmentID WHERE D.DepartmentName IS NULL
--LEFT JOIN OR LEFT OUTER JOIN BOTH CORRECT (OUTER IS OPTIONAL)

--4. Find all departments whose total salary is exceeding 100000.
SELECT D.DepartmentName, SUM(P.Salary) FROM PERSON P RIGHT JOIN DEPT D ON P.DepartmentID = D.DepartmentID GROUP BY D.DepartmentName HAVING SUM(P.Salary) > 100000


--PART-C:

--1. List all departments who have no person.
SELECT D.DepartmentName FROM PERSON P RIGHT JOIN DEPT D ON P.DepartmentID = D.DepartmentID WHERE P.PersonID IS NULL

--2. List out department names in which more than two persons are working.
SELECT DEPT.DepartmentName,COUNT(PERSON.PersonID) as PersonCount 
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID=DEPT.DepartmentID
GROUP BY DEPT.DepartmentName
HAVING COUNT(PERSON.PersonID)>2

--3. Give a 10% increment in the computer department employee’s salary.
SELECT PERSON.PersonName,PERSON.Salary
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID=DEPT.DepartmentID
WHERE DEPT.DepartmentName='Computer'

UPDATE PERSON
SET Salary=SALARY+SALARY*0.1
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID=DEPT.DepartmentID
WHERE DEPT.DepartmentName='Computer'

SELECT PERSON.PersonName,PERSON.Salary
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID=DEPT.DepartmentID
WHERE DEPT.DepartmentName='Computer'


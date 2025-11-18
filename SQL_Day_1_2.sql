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
SELECT D.DepartmentName, COUNT(P.PersonID) FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID GROUP BY D.DepartmentName HAVING COUNT(P.PersonID)  > 2

--3. Give a 10% increment in the computer department employee’s salary.
UPDATE P
SET P.SALARY = P.SALARY * 1.10
FROM PERSON P JOIN DEPT D ON P.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'COMPUTER';

SELECT PersonName ,SALARY FROM PERSON WHERE DepartmentID IN (
	SELECT DepartmentID FROM DEPT WHERE DepartmentName = 'COMPUTER'
)


--ADVANCE SQL:

-- Create Author table
CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL,
    Country VARCHAR(50) NULL
);

-- Create Publisher table
CREATE TABLE Publisher (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL UNIQUE,
    City VARCHAR(50) NOT NULL
);

-- Create Book table with Foreign Keys
CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    AuthorID INT NOT NULL,
    PublisherID INT NOT NULL,
    Price DECIMAL(8, 2) NOT NULL,
    PublicationYear INT NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);

-- Insert into Author
INSERT INTO Author (AuthorID, AuthorName, Country)
VALUES
(1, 'Chetan Bhagat', 'India'),
(2, 'Arundhati Roy', 'India'),
(3, 'Amish Tripathi', 'India'),
(4, 'Ruskin Bond', 'India'),
(5, 'Jhumpa Lahiri', 'India'),
(6, 'Paulo Coelho', 'Brazil'),
(7, 'Sudha Murty', 'India'),
(8, 'Vikram Seth', 'India'),
(9, 'Kiran Desai', 'India'); -- Author with no books

-- Insert into Publisher
INSERT INTO Publisher (PublisherID, PublisherName, City)
VALUES
(1, 'Rupa Publications', 'New Delhi'),
(2, 'Penguin India', 'Gurugram'),
(3, 'HarperCollins India', 'Noida'),
(4, 'Aleph Book Company', 'New Delhi'),
(5, 'Westland', 'Chennai');

-- Insert into Book
INSERT INTO Book (BookID, Title, AuthorID, PublisherID, Price, PublicationYear)
VALUES
(101, 'Five Point Someone', 1, 1, 250.00, 2004),
(102, 'The God of Small Things', 2, 2, 350.00, 1997),
(103, 'Immortals of Meluha', 3, 3, 300.00, 2010),
(104, 'The Blue Umbrella', 4, 1, 180.00, 1980),
(105, 'The Lowland', 5, 2, 400.00, 2013),
(106, 'Revolution 2020', 1, 1, 275.00, 2011),
(107, 'Sita: Warrior of Mithila', 3, 3, 320.00, 2017),
(108, 'The Room on the Roof', 4, 4, 200.00, 1956),
(109, 'A Suitable Boy', 8, 2, 600.00, 1993),
(110, 'Scion of Ikshvaku', 3, 5, 350.00, 2015),
(111, 'Wise and Otherwise', 7, 2, 210.00, 2002),
(112, '2 States', 1, 1, 260.00, 2009);


--PART-A:

--1. List all books with their authors.
SELECT B.Title, A.AuthorName FROM Book B JOIN Author A ON B.AuthorID = A.AuthorID

--2. List all books with their publishers.
SELECT B.Title, P.PublisherName FROM Book B JOIN Publisher P ON B.PublisherID = P.PublisherID 

--3. List all books with their authors and publishers.
SELECT B.Title, A.AuthorName, P.PublisherName FROM Author A JOIN Book B ON A.AuthorID = B.AuthorID JOIN Publisher P ON B.PublisherID = P.PublisherID

--4. List all books published after 2010 with their authors and publisher and price.
SELECT B.Title, A.AuthorName, P.PublisherName, B.Price FROM Author A JOIN Book B ON A.AuthorID = B.AuthorID JOIN Publisher P ON B.PublisherID = P.PublisherID WHERE B.PublicationYear > 2010

--5. List all authors and the number of books they have written.
SELECT A.AuthorName, COUNT(B.BookID) FROM Author A LEFT JOIN Book B ON A.AuthorID = B.AuthorID LEFT JOIN Publisher P ON B.PublisherID = P.PublisherID GROUP BY A.AuthorName

--6. List all publishers and the total price of books they have published.
SELECT P.PublisherName, SUM(B.Price) FROM Author A JOIN Book B ON A.AuthorID = B.AuthorID JOIN Publisher P ON B.PublisherID = P.PublisherID GROUP BY P.PublisherName

--7. List authors who have not written any books.
SELECT A.AuthorName FROM Author A LEFT JOIN Book B ON A.AuthorID = B.AuthorID WHERE B.BookID IS NULL

--8. Display total number of Books and Average Price of every Author.
SELECT A.AuthorName, COUNT(B.BookID), AVG(B.Price)  FROM Author A RIGHT JOIN Book B ON A.AuthorID = B.AuthorID GROUP BY A.AuthorName

--9. lists each publisher along with the total number of books they have published, sorted from highest to lowest.
SELECT P.PublisherName, COUNT(B.BookID) FROM Book B JOIN Publisher P ON B.PublisherID = P.PublisherID GROUP BY P.PublisherName ORDER BY COUNT(B.BookID) DESC

--10. Display number of books published each year.
SELECT B.PublicationYear, COUNT(B.BookID) FROM Book B JOIN Publisher P ON B.PublisherID = P.PublisherID GROUP BY B.PublicationYear


--PART-B:

--1. List the publishers whose total book prices exceed 500, ordered by the total price.
SELECT P.PublisherName, SUM(B.Price) AS 'TOTAL PRICE' FROM Book B JOIN Publisher P ON B.PublisherID = P.PublisherID GROUP BY P.PublisherName HAVING SUM(B.Price) > 500 ORDER BY SUM(B.Price)

--2. List most expensive book for each author, sort it with the highest price.
SELECT A.AuthorName, B.Title, B.Price FROM Author A JOIN Book B ON A.AuthorID = B.AuthorID WHERE B.Price = (SELECT MAX(B2.PRICE) FROM BOOK B2 WHERE B2.AuthorID = A.AuthorID) ORDER BY B.Price DESC


--PART-C:

--1. Create Table Schema Your first task is to create the database structure. Implement the following 6-table schema. You must define all Primary Key, Foreign Key, and other constraints necessary to make the database functional and maintain data integrity.
--Emp_info(Eid, Ename, Did, Cid, Salary, Experience)
--Dept_info(Did, Dname)
--City_info(Cid, Cname, Did)
--District(Did, Dname, Sid)
--State(Sid, Sname, Cid)
--Country(Cid, Cname)

CREATE TABLE COUNTRY(
	CID INT PRIMARY KEY,
	CNAME VARCHAR(50) NOT NULL
);

CREATE TABLE STATE(
	SID INT PRIMARY KEY,
	SNAME VARCHAR(50) NOT NULL,
	CID INT NOT NULL,
	FOREIGN KEY (CID) REFERENCES COUNTRY(CID)
);

CREATE TABLE DISTRICT(
	DID INT PRIMARY KEY,
	DNAME VARCHAR(50) NOT NULL,
	SID INT NOT NULL,
	
	FOREIGN KEY (SID) REFERENCES STATE(SID)
);

CREATE TABLE CITY_INFO(
	CID INT PRIMARY KEY,
	CNAME VARCHAR(50) NOT NULL,
	DID INT NOT NULL,

	FOREIGN KEY (DID) REFERENCES DISTRICT(DID)
);

CREATE TABLE DEPT_INFO(
	DID INT PRIMARY KEY,
	DNAME VARCHAR(50) NOT NULL
);

CREATE TABLE EMP_INFO(
	EID INT PRIMARY KEY,
	ENAME VARCHAR(50),
	DID INT NOT NULL,
	CID INT NOT NULL,
	SALARY DECIMAL(10,2) NOT NULL,
	EXPERIENCE INT NOT NULL,

	FOREIGN KEY (DID) REFERENCES DEPT_INFO(DID),
	FOREIGN KEY (CID) REFERENCES CITY_INFO(CID)
);


--2. Insert Data & Test Validation Once your tables are created, perform the following:
--Insert 5 valid records into each of the 6 tables.
--After inserting valid data, write and execute at least one INSERT statement that violates a foreign key constraint you set up. Observe and understand the error message produced by the database.

INSERT INTO COUNTRY VALUES
	(1, 'India'),
	(2, 'USA'),
	(3, 'Canada'),
	(4, 'UK'),
	(5, 'Australia');

INSERT INTO State VALUES
(101, 'Gujarat', 1),
(102, 'Maharashtra', 1),
(103, 'California', 2),
(104, 'Ontario', 3),
(105, 'New South Wales', 5);


INSERT INTO District VALUES
(201, 'Rajkot', 101),
(202, 'Ahmedabad', 101),
(203, 'Mumbai', 102),
(204, 'Los Angeles', 103),
(205, 'Toronto', 104);


INSERT INTO City_info VALUES
(301, 'Rajkot', 201),
(302, 'Sanand', 202),
(303, 'Bandra', 203),
(304, 'Santa Monica', 204),
(305, 'North York', 205);

INSERT INTO Dept_info VALUES
(10, 'IT'),
(20, 'HR'),
(30, 'Sales'),
(40, 'Finance'),
(50, 'Marketing');


INSERT INTO Emp_info VALUES
(1, 'Anil Sharma', 10, 301, 80000, 5),
(2, 'Priya Singh', 20, 303, 65000, 3),
(3, 'Rajesh Kumar', 30, 302, 70000, 4),
(4, 'Meena Patel', 10, 301, 82000, 6),
(5, 'Suresh Desai', 40, 304, 95000, 8);

--FK VIOLATION
INSERT INTO Emp_info VALUES
(6, 'Fake Employee', 99, 301, 50000, 2);


--3. Display Full Employee Report.
SELECT 
    e.Ename AS EmpName,
    d.Dname AS DeptName,
    e.Salary,
    e.Experience,
    c.Cname AS CityName,
    dis.Dname AS DistrictName,
    s.Sname AS StateName,
    co.Cname AS CountryName
FROM Emp_info e
JOIN Dept_info d ON e.Did = d.Did
JOIN City_info c ON e.Cid = c.Cid
JOIN District dis ON c.Did = dis.Did
JOIN State s ON dis.Sid = s.Sid
JOIN Country co ON s.Cid = co.Cid;

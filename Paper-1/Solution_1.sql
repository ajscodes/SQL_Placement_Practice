use Placement_Practice_1

-- Create Department Table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- Create Employee Table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50),
    Mobile VARCHAR(20),
    JoiningDate DATE,
    Salary DECIMAL(10, 2),
    DeptID INT FOREIGN KEY REFERENCES Department(DeptID)
);


-- Insert Sample Departments
INSERT INTO Department (DeptID, DeptName) VALUES
(1, 'Computer'),
(2, 'Civil'),
(3, 'Mechanical'),
(4, 'HR'),
(5, 'Finance');

-- Insert Sample Employees
INSERT INTO Employee (EmpID, Name, Email, City, Mobile, JoiningDate, Salary, DeptID) VALUES
-- Q1: Changa
(101, 'Sandeep', 'sandeep@test.com', 'Mumbai', '1112223334', '2021-05-15', 50000.00, 1),
(102, 'Rajesh Kumar', 'rajesh@test.com', 'Changa', '2223334445', '2022-03-10', 55000.00, 1),

-- Q2: Joined after 01 Jun 2022, Computer or Civil
(103, 'Priya Sharma', 'priya@test.com', 'Pune', '3334445556', '2022-06-05', 60000.00, 1),
(104, 'Amit Singh', 'amit@test.com', 'Delhi', '4445556667', '2022-07-20', 62000.00, 2),

-- Q3: No mobile or email
(105, 'Sneha Patel', 'sneha@test.com', 'Pune', NULL, '2021-08-01', 58000.00, 1),
(106, 'Vikram Rathod', NULL, 'Mumbai', '6667778889', '2022-01-12', 53000.00, 2),

-- Q4/Q5: Top salaries
(107, 'Anjali Mehta', 'anjali@test.com', 'Delhi', '7778889990', '2020-02-18', 90000.00, 1),
(108, 'Manish Jain', 'manish@test.com', 'Changa', '8889990001', '2021-11-05', 85000.00, 2),
(109, 'Kavita Iyer', 'kavita@test.com', 'Pune', '9990001112', '2022-04-30', 88000.00, 1),

-- Q5: Top 3 dept wise
(110, 'Rahul Dave', 'rahul@test.com', 'Mumbai', '1231231234', '2021-09-22', 82000.00, 2),
(111, 'Meera Krishnan', 'meera@test.com', 'Delhi', '2342342345', '2022-08-14', 86000.00, 1),

-- Q9: Dept with > 9 (Computer will have 10)
(112, 'Varun Gill', 'varun@test.com', 'Pune', '3453453456', '2023-01-01', 50000.00, 1),
(113, 'Deepak Shah', 'deepak@test.com', 'Changa', '4564564567', '2023-02-11', 48000.00, 1),
(114, 'Nisha Verma', 'nisha@test.com', 'Mumbai', '5675675678', '2023-03-15', 47000.00, 1),
(115, 'Suresh Reddy', 'suresh@test.com', 'Delhi', '6786786789', '2023-04-20', 46000.00, 1),

-- Q10: Mechanical
(116, 'Rina Desai', 'rina@test.com', 'Pune', '7897897890', '2022-05-10', 60000.00, 3),
(117, 'Gaurav Kumar', 'gaurav@test.com', 'Mumbai', '8908908901', '2022-06-12', 65000.00, 3),

-- Q12: HR > 45k
(118, 'Pooja Singh', 'pooja@test.com', 'Delhi', '9019019012', '2021-07-07', 48000.00, 4),
(119, 'Alok Nath', 'alok@test.com', 'Pune', '0120120123', '2022-09-30', 40000.00, 4),

-- Q13: Same name
(120, 'Amit Singh', 'amit2@test.com', 'Pune', '1122112211', '2023-05-01', 51000.00, 5),
(121, 'Priya Sharma', 'priya2@test.com', 'Mumbai', '2233223322', '2023-06-10', 70000.00, 5);



--Question 1: List all Employees which belongs to Changa.
select name from Employee where City = 'changa'


--Question 2: List all Employees who joined after 01 Jun, 2022 and belongs to either Computer or Civil.
select e.Name, e.JoiningDate, d.DeptName
from Employee e left join Department d on e.DeptID = d.DeptID
where JoiningDate > '2022-06-01' 
group by e.Name, e.JoiningDate, d.DeptName having d.DeptName in ('computer','civil')

SELECT
    E.EmpID,
    E.Name,
    E.JoiningDate,
    D.DeptName
FROM Employee E
JOIN Department D ON E.DeptID = D.DeptID
WHERE E.JoiningDate > '2022-06-01'
  AND (D.DeptName IN ('Computer','Civil'));


  --Question 3: List all Employees with department name who don't have either mobile or email
select e.EmpID, e.Name, e.Email, e.Mobile, d.DeptName
from Employee e join Department d on e.DeptID = d.DeptID
where e.Mobile is null or e.Email  is null


--Question 4: List top 5 employees as per salaries.
select top 5 EmpID, Name, Salary
from Employee 
order by Salary desc



--**Question 5: List top 3 employees department wise as per salaries.
with RankedEmp AS (
	select 
	from Employee e join 
)


select e.City, count(e.EmpID)
from Department d join Employee e on d.DeptID = e.DeptID
group by e.City

select City, max(Salary) as MaxSal, MIN(Salary) as MinSal, avg(salary) as AvgSal
from Employee 
group by City

select DeptName, City, COUNT(EmpID)
from Employee join Department on Employee.DeptID = Department.DeptID
group by DeptName, City

select d.DeptName, count(e.EmpID)
from Employee e join Department d on e.DeptID = d.DeptID
group by d.DeptName having COUNT(e.EmpID) > 9

select e.EmpID, 1.10 * e.Salary as New_Sal
from Employee e join Department d on e.DeptID = d.DeptID
where d.DeptName in ('Mechanical')

Update Employee
set City = 'Pune'
where EmpID = 101

select * from Employee

--12 pending

--13 pending

select d.DeptName, avg(e.Salary)
from Employee e join Department d on e.DeptID = d.DeptID
group by d.DeptName 

--15 pending 
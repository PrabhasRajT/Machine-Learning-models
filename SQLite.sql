










CREATE TABLE Employee(
  ID int not NULL,
  name varchar,
  salary int,
  departmentID int,
  PRIMARY KEY(ID),
  Foreign KEY(departmentID) REFERENCES Department(id)  
);
INSERT into Employee(ID, name, salary, departmentid) VALUES(1,"JOE",70000,1),(2,"JIM",90000,1),(3,"HENRY",80000,2),(4,"SAM",60000,2),(5,"MAX",90000,1)

CREATE TABLE Department(
  ID int not NULL,
  name varchar
);
INSERT Into Department(ID, name) values(1, "IT"),(2, "SALES")
SELECT * from Employee;
SELECT * from Department;

with RankedEmployees as (
select d.name as Department, e.name as Employee, e.salary as Salary,
DENSE_RANK() OVER (PARTITION BY e.departmentid ORDER BY e.salary DESC) AS max_salary 
FROM Employee as e join Department d on e.departmentid = d.id)
SELECT Department, Employee, Salary
from RankedEmployees
where max_salary = 1


question:
Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key column for this table.
departmentId is a foreign key of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table. It is guaranteed that department name is not NULL.
Each row of this table indicates the ID of a department and its name.
 

Write an SQL query to find employees who have the highest salary in each of the departments.

Return the result table in any order.

The query result format is in the following example.
Example 1:

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

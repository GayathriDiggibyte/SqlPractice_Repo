create table employee(EmpId int primary key, Fname varchar(50), Lname varchar(50), Department varchar(50), salary int);
insert into employee(EmpId, Fname, Lname, Department, salary)
    values(1,'John','Doe','HR',55000),
          (2,'Jane','Smith','IT',60000),
          (3,'Bob','Johnson','IT',62000),
          (4,'Alice','Williams','HR',54000),
          (5,'Eva','Davis','Finance',58000),
          (6,'Mike','Brown','Finance',59000);
          
select * from employee;
#list all the employees who are having salary less than 60000
select * from employee where salary < 60000;
#list all employees in alphabetical order by last name
select * from employee order by Lname asc;
#list all employees in the it department and sort them by salary in descending order
select * from employee where department in('IT') order by salary desc;
#find the total number of employees in each department
select department,count(*) from employee group by department;
#calculate the average salary for each department, sorted in ascending order by department name
select avg(salary),department from employee group by department order by department asc;
#find the department with the highest average salary
select avg(salary),department 
from employee g
group by department 
order by avg(salary) desc;

select max(avg_salary) from (select avg(salary) as avg_salary from employee group by department) as MaxAvgSalary;


#having clause
#find the employees whose avgsalary is less than 60000
select EmpId,Fname,Lname,Department,avg(salary) from employee group by department having avg(salary)<60000;
#find departments with an average salary greater than 55000 or have more than two employees
select department,count(*) from employee group by department having avg(salary)>55000 or count(*) > 2;

#aggregate functions
#count
select count(*) from employee group by department;
#sum
select sum(salary),department from employee group by department having sum(salary)>110000;
#avg
select avg(salary),department from employee group by department having avg(salary)>60000;
#min
select min(salary),department from employee group by department;
#max
select max(salary),department from employee group by department;

#joins
#inner join


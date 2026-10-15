-- the tables were imported from CSV with the Table Data Import Wizard before running

create database if not exists employee;
use employee;
select database();

select count(*) from emp_record_table;  -- Task 1: confirm record counts for each table
select count(*) from data_science_team;
select count(*) from proj_table;

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
from  emp_record_table;    -- Task 2: employee details with department

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, emp_rating
from emp_record_table
where emp_rating<2;   -- Task 3a: employees with rating less than 2

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, emp_rating
from emp_record_table
where emp_rating between 2 and 4; -- Task 3b: employees with rating between 2 and 4

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, emp_rating
from emp_record_table
where emp_rating>4;  -- Task 3c: employees with rating greater than 4

select EMP_ID, FIRST_NAME,role,dept
from emp_record_table
where role in ('manager','ceo','president'); -- Task 4: leadership roles (Manager, President, CEO)

select EMP_ID, FIRST_NAME, LAST_NAME,ROLE, DEPT, emp_rating,
max(emp_rating) over (partition by dept) as Dept_max_rating
from emp_record_table
order by dept,emp_rating;   -- Task 5: employee rating with the max rating of their department

select ROLE,
max(salary) as max_salary,
min(salary) as min_salary
from emp_record_table
group by role
order by max_salary,min_salary;  -- Task 6: minimum and maximum salary by role

select EMP_ID, FIRST_NAME, LAST_NAME,exp,
 rank () over (order by (exp)desc) as Experience_rank 
from emp_record_table
order  by Experience_rank;  -- Task 7: rank employees by experience

create or replace view Highest_salary as 
select EMP_ID, FIRST_NAME, LAST_NAME,country,salary
from emp_record_table
where salary> 6000;
select * from Highest_salary;   -- Tasks 8 and 9: view of employees with salary above 6000, then query it

-- Task 10: index to speed up search by first name
-- Before: execution plan without the index
explain
select * from emp_record_table
where first_name = 'Eric';

-- Create the index (run once; it errors if the index already exists)
create index idx_first_name on emp_record_table(first_name(10));

-- After: execution plan using the index
explain
select * from emp_record_table
where first_name = 'Eric';

show index from emp_record_table;

select country,continent,                 -- Task 11: average salary by continent and country
round(avg(salary),2) as Average_salary
from emp_record_table
group by country,continent
order by continent, country;

with dept_avg as (                       -- Extra: departments with average salary above 6000, using a CTE
select dept,
round (avg(salary),2) as Avg_salary
from emp_record_table
group by dept
)
select dept,avg_salary
from dept_avg
where avg_salary > 6000
order by avg_salary desc;

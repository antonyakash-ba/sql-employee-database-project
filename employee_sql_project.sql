create database employee; 
use employee;
select database();
use employee;
select count(*) from emp_record_table;
select count(*) from data_science_team;
select count(*) from proj_table;

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
from  emp_record_table;

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, emp_rating
from emp_record_table
where emp_rating<2;

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, emp_rating
from emp_record_table
where emp_rating between 2 and 4;

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, emp_rating
from emp_record_table
where emp_rating>4;

select EMP_ID, FIRST_NAME,role,dept
from emp_record_table
where role in ('manager','ceo','president');

select EMP_ID, FIRST_NAME, LAST_NAME,ROLE, DEPT, emp_rating,
max(emp_rating) over (partition by dept) as Dept_max_rating
from emp_record_table
order by dept,emp_rating;

select ROLE,
max(salary) as max_salary,
min(salary) as min_salary
from emp_record_table
group by role
order by max_salary,min_salary;

select EMP_ID, FIRST_NAME, LAST_NAME,exp,
 rank () over (order by (exp)desc) as Experience_rank 
from emp_record_table
order  by Experience_rank;

create view Highest_salary as 
select EMP_ID, FIRST_NAME, LAST_NAME,country,salary
from emp_record_table
where salary> 6000;
select * from Highest_salary;

create index idx_first_name on emp_record_table(first_name(10));
explain
select * from emp_record_table
where  first_name = 'Eric';
show index from emp_record_table;

select country,continent,
round(avg(salary),2) as Average_salary
from emp_record_table
group by country,continent
order by continent, country;

with dept_avg as (
select dept,
round (avg(salary),2) as Avg_salary
from emp_record_table
group by dept
)
select dept,avg_salary
from dept_avg
where avg_salary > 6000
order by avg_salary desc;

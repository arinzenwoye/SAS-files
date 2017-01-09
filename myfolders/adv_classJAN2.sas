/** subqueries, joins and dataset creation **/

*subqueries;
proc sql;
	select avg(salary) from "/folders/myfolders/employee_information.sas7bdat";
quit;

proc sql;
	select department, avg(salary) as meansalary
	from "/folders/myfolders/employee_information.sas7bdat"
	group by department
	having meansalary < 38041.51;
quit;

proc sql;
	select department, avg(salary) as meansalary
	from "/folders/myfolders/employee_information.sas7bdat"
	group by department
	having meansalary < select avg(salary) from "/folders/myfolders/employee_information.sas7bdat";
quit;

/**subqueries can be used either with having or where **/
/* it should return only single columns */
/* a column can have multiple values */

*joins;
data one;
	input a b;
	datalines;
	1 2
	3 4 
	5 6
	7 8
	9 10
;run;

data two;
	input a c;
	datalines;
	1 3 
	3 5 
	4 6
	6 9
	7 8
;run;

/*cartesian product - produces all the combinations*/
proc sql;
	select * 
	from one, two;
quit;

/*inner join*/
proc sql;
	select * 
	from one, two
	where one.a = two.a;
quit;
	

proc sql;
	select * 
	from one inner join two
	on one.a = two.a;
quit;
	

proc sql;
	select one.a,b,c
	from one inner join two
	on one.a = two.a;
quit;

/* outter join: left, full or right */

proc sql;
	select * 
	from one left join two
	on one.a = two.a;
quit;

proc sql;
	select * 
	from one right join two
	on one.a = two.a;
quit;
	
proc sql;
	select * 
	from one full join two
	on one.a = two.a;
quit;	
	
/**Creating SAS datasets from SQL Queries **/
*method 1;
proc sql;
	create table class2 as
	select name, age, sex, height
	from sashelp.class;
quit;
*method 2;
proc sql;
	create table class3 like sashelp.class; /*only copy's column properties no rows */
quit;
*method 3;
proc sql;
	create table class4 (name char(10), gender char(1), salary numeric(8));
quit;	
	
proc sql;
	insert into class4  
	set name = "abcd", gender = "M", salary = 100000
	set name = "efgh", gender = "F", salary = 200000;
quit;

proc sql;
	insert into class4
	values("ijkl", "F", 120000)
	values("mnop", "M", 150000);
quit;	
	
	
	
	
	


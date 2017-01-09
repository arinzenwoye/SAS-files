/**CONDITIONAL PROCESSING**/
/**ITERATIVE PROCESSING**/
/**LOCAL AND GLOBAL SYMBOLS**/

*Condiitonal Processing;
/*Sales data. updated everyday: i want daily reports (proc print) and 
weekly reports (proc means) - daily report: daily basis. Weekly Report: every friday*/

%Macro Report;
	proc print data=sales;
		where order_date = "&sysdate9"d;
	run;
	%if &sysday = Friday %then %do;
	proc means data=sales;
		where order_date between %eval("&sysdate9"d - 5) and "&sysdate9"d;
		run;
	%end;
%mend;

*Iterative Processing;
/* Sales data for each year: year 2001, year 2002....year 2015 
	Report for each year and save it as a pdf file*/
	
	/** 1940 - 2015 **/
%macro year_pdf(st=1940, stop 2015);	
	%do i = &st %to &stop;
		ods pdf file= "Report&i.pdf";
		proc print data= year&i;
		run;
		ods pdf close;
	%end;
%mend;	

/** SQL **/

proc sql;
	select name,age,weight
	from sashelp.class
	WHERE AGE < 13;
	
quit;


proc sql;
select sex, sum(age) as sum_age
from sashelp.class
	age
	group by sex;
quit;

proc sql;
	select name,sex,age,(age * 12) as age_month
	from sashelp.class;
quit;

proc sql;
	select employee_id, salary, marital_status, case (marital_status)
												when("S") then salary * 0.1
												when("O") then salary * 0.15
												when("M") then salary * 0.2
												end as Bonus
	from "/folders/myfolders/employee_payroll.sas7bdat";
quit;
												






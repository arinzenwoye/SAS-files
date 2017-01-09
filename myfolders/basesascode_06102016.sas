libname rang " ";

/* Do Loops */
data compound;
     Amount=50000;
     Rate=.045;
   do i=1 to 20;      /* Loop for 20 yrs compounding yearly */
      Yearly +(Yearly+Amount)*Rate;
	  output;
	
   end;
   do i=1 to 80;
       Quarterly+((Quarterly+Amount)*Rate/4); /* Loop for 20 yrs compounding quarterly */
	   output;
   end;
run;


data compound_while;
     Amount=50000;
     Rate=.045;
   do while (yearly < 100000);      
      Yearly +(Yearly+Amount)*Rate;
	  year +1;
	 *output;
   end;   
run;

data compound_until;
     Amount=50000;
     Rate=.045;
   do until (yearly >= 100000); 
   
      Yearly + (Yearly+Amount)*Rate;
	  year +1;
	  *output;
   end;   
run;


data class_new ;
set sashelp.class;
array parameter{3} age height weight;
array benchmark {3} (20,60,150);

  
    if (parameter(i) < benchmark(i) and parameter(i+1) < benchmark(i+1) and parameter(i+2) < benchmark(i+2)) then fitness = 'healthy   ';
	else fitness = 'unhealthy';
	

run;

data class (drop=i);
set sashelp.class;
array parameter (3) age height weight;
array benchmark (3)_temporary_ (20, 60, 150);
do i=1;
if (parameter(i) < benchmark(i) and parameter (i+1)<benchmark(i+1) and parameter(i+2)<benchmark(i+2))then fitness='healthy  ';
else fitness='unhealthy';
end;
run;
/*****************************************/

/* PROC PRINT AND PROC CONTENTS*/

data sort;
	num=4; num2=88; output;
	num=7; num2=99; output; 
	num=2; num2=99; output;
	num=4; num2=99; output;
	num=5; num2=22; output;
	num=6; num2=90; output;
	num=7; num2=99; output;
	num=7; num2=23; output;
	num=7; num2=79; output;
run;

proc sort data = sort out = sort2 nodup;
	by  num;
run;

data print;
	a=9; 	b=8; 	c=2; 	output;
	a=9; 	b=7; 	c=3; 	output;
	a=9; 	b=6; 	c=2; 	output;
	a=7; 	b=99;	c=15; 	output;
	a=7; 	b=99; 	c=12; 	output;
	a=7; 	b=99; 	c=11; 	output;
	a=10; 	b=0; 	c=8; 	output;
	a=5; 	b=6; 	c=6; 	output;
	a=1; 	b=4; 	c=4; 	output;
	a=4; 	b=1; 	c=3; 	output;
	a=4; 	b=1; 	c=2; 	output;
	a=4; 	b=1; 	c=1; 	output;
run;

proc print data = print;
run;

proc print data = print noobs;
	var a  c;
	sum a;
run;

proc print data = print (obs = 5) noobs;
run;

proc print data = print (firstobs = 5) label ;
label a = "Identifier";
run;

proc contents data = print;
run;

proc contents data = print out = print_dset;
run;

/***************************************/


/***************************************/

/* PROC SORT */

proc sort data=Rang.sales  out=work.sales;
   by descending Salary;
run;

/**************************************/

/* PROC FREQ */

proc freq data=Rang.sales;
   tables Gender;
run;

/* TWO WAY FREQUENCY */

proc freq data=Rang.sales;
   tables Gender*Country;
   *where Country='AU';
run;

/* PROC MEANS */

proc means data=Rang.sales;
var salary;
class gender;
run; 

/***************************************/

/* PROC REPORT */

Proc report data=rang.emp;
	column empno job Sal;
Run;  

proc report data=rang.emp;
run;

proc report data=rang.emp nowindows  headline headskip ;
run;

proc report data=rang.emp nowindows headline headskip box;
run;

proc report data=emp.emp nowindows headline headskip ;
	column  sal comm  ;
run;

proc report data=emp.emp nowindows headline headskip ;
	column  ename sal comm  ;
run;

/* define statement: describes how to use and display a report item. if you do not use a define    	*/
/*  				 statement, then proc report uses default characteristics or                    */  																								*/
/* 					 how to use and  display a report item.											*/
/* 																									*/
/* 1.	define how each variable is used in the report.												*/
/* 2.	assign formats to variables.																*/
/* 3.	specify report column headers and column widths.											*/
/* 4.	change the order of the rows in the report.													*/;

proc report data=rang.emp nowindows headline;
column sal ;
define sal/analysis ;/*default*/
run;

proc report data=rang.emp nowindows headline;
column sal   comm ;
define sal /analysis  mean    ;
run;

proc report data=rang.emp nowindows headline;
column  deptno sal;
define deptno/order;
run;

proc report data=rang.emp nowindows headline;
column  deptno sal;
define deptno/group;
run;

proc report data=rang.emp nowindows headline;
column  deptno sal ;
define deptno/group noprint;
run;

proc report data=rang.emp nowindows headline;
column deptno  job;
define deptno/across;
run;



proc report data=emp.emp nowindows headline;
where deptno in (10,20);
column sal deptno ;
define deptno/order;
run;

proc report data=rang.emp nowindows headline box;
column   deptno job sal;
define job/across;
define deptno/group;
run;



proc report data=rang.emp nowindows headline box;
column deptno job,sal ename;
define deptno/order;
define job/across;
run;

proc report data=rang.emp nowindows headline;
column  deptno  sal,(max min mean nmiss n);/*pctn pctsum median p90*/
define deptno/group ;
run;

proc report data=emp.emp nowindows headline;
column deptno n job,(sal),mean;
define deptno/group;
define job/across;
run;


/*OL  : DRAWS A LINE OVER THE BREAK
PAGE :  STARTS A NEW PAGE
SKIP   : INSERTS A BLANK LINE
SUMMARIZE   : INSERTS SUMS OF NUMERIC VARIABLES
UL :DRAWS A LINE UNDER THE BREAK*/

proc report data=emp.emp nowindows headline;
column deptno   sal;
define deptno/order;
break after deptno/ ul  ol summarize skip  ;
/*break before deptno/ ol ul summarize skip  ;*/
run;

proc report data=emp.emp nowd headline;
column deptno ename   sal;
define deptno/order;
break after deptno/ dol dul  summarize skip page ;
run;


data rang.discounts;
   infile "C:\Users\Admin\Desktop\Rang\Data2\offers.dat";
   input @1 Cust_type 4. 
         @5 Offer_dt mmddyy8.
         @14 Item_gp $8. 
         @22 Discount percent3.;
run;

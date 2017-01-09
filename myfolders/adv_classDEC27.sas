/*MACROS*/
/*submit repititive codes or redundant coding*/
/*submit code as per real time*/
/*conditional submiting code*/

title 'student with age less than 14'
proc print data=sashelp.class;
where age < 14;
run;

/*TOKENS: NAME TOKEN(proc, print..), SPECIAL TOKEN(<, >, ;), NUMBER TOKEN(14,15..), 
LITERAL TOKEN(quotation marks:words in quotations regared as a single token)*/

/* MACRO TRIGGERS: & % */
/* MACRO VARIABLES: GLOBAL SYMBOL TABLE, AUTOMATIC, USER DEFINED */

/*%put is a macro statement - this will display the content of whatever we write in a log 
window */

%put this is my sas session;

%put _automatic_; /* this will show you a list of all macros - shows all the real
time values*/

/* DATA FOR SALES FOR DAY TO DAY BASIS */

proc print data = dsn;
where order_date = "27dec2016"d; /*d: used to convert into date*/
run;

/* if you want to do this daily - use macros */
proc print data = dsn;
where order_date = "&sysdate9"d; /* & is a macro trigger and will give you the real time date*/
run;

%let yr = 2008;
data sales_&yr;
	set sales;
	where year(hire_date) = &yr;
	run;
title "orders placed in &yr"; /* has to be double quotes so it can scan the quotation. if single quotation it is a literal token and will be taken as one thing */
proc print data = sales_&yr;
run;	

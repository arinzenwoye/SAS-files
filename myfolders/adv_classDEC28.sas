/*MACRO DEFINITION*/
/*MACRO FUNCTION*/

/* % is used for macro statement while & is used for macro variables */
%let year = 2011;
%let type = 3;
data order1;
	set work.order;
	where year(order_date) = &year and order_type = &type;
run;
proc print data=order1;
	title "ordes for &year and type &type";
run;

/* instead of using so many let statements we will use macros */

*defining a macro: orders;
%macro orders;
	data order1;
		set work.order;
		where year(order_date) = 2008 and order_type = 1;
	run;
	proc print data=order1;
		title "ordes for 2008 and type 1";
	run;
%mend;


%orders;
*store macro in a permanent library called rang;
options mstored sasmstore= rang;
%macro orders / store source;
	data order1;
		set work.order;
		where year(order_date) = 2008 and order_type = 1;
	run;
	proc print data=order1;
		title "ordes for 2008 and type 1";
	run;
%mend;


*creating a dynamic macro - this is also a positional parameter; 
%macro orders (year, type);
	data order1;
		set work.order;
		where year(order_date) = &year and order_type = &type;
	run;
	proc print data=order1;
		title "ordes for &year and type &type";
	run;
%mend;

%orders(2009,3); /*note that year and type macro variables are stored in local symbol table 
not the usual global symbol table */

* keyword parameter;
%macro orders1 (year=2008, type=);
	data order1;
		set work.order;
		where year(order_date) = &year and order_type = &type;
	run;
	proc print data=order1;
		title "ordes for &year and type &type";
	run;
%mend;

%orders1(year=2007, type=1);
%orders1(type=1, year=2007); /* can change position/order */
%orders1(type=1) /*added advantage of a default value */ 
/* do not use ; after because it is a call not a statement */

/*****MACRO FUNCTIONS*****/

/* %scan */;
%let value = abc.def;
%let value2 = %scan(&value, 2, .);
%put &value // &value2;

/* %substr */
%put &sysdate9;
%put %substr(&sysdate9,3,3);

/* %eval */
%let value = 2012;
%let value2 = &value + 1; /*problem is that it will give 2012 + 1 */
%put &value // &value2;
*solution;
%let value = 2012;
%let value2 = %eval(&value + 1); /* use for expressions that need evaluation */
%put &value // &value2;

/* %str - it masks special characters like @, ;,. */
%let year = 2009;
%let title = year value is %str("&year");
%put &title;
/* %nrstr */
%let year = 2009;
%let title = year value is %nrstr("&year"); /* supresses the basic functionality of special characters */
%put &title;

/* %sysfunc - allows us to use SAS functions in a macro environment or on macro variables */
%let a = my company name is rangtech;
%let b = %sysfunc(tranwrd(&a,rangtech,ranginfo)); /* tranwrd is find and replace function */
%put &a;
%put &b;










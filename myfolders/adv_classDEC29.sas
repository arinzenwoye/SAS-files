/**MACROS**/

%let A = abc;

data _null_;
	set sashelp.class end=last;
	age_sum + age;
	if last = 1 then do; 
		age_mean = age_sum / _n_;
		%let avg = age_mean; /* creates a macro variable at the time of word scanner before compilation*/
	end;
run;
	
proc print data=sashelp.class;
	title "Average for age of people is &avg";
run;

/* call symputx */
%macro class_age;
	data _null_;
		set sashelp.class end=last;
		age_sum + age;
		if last = 1 then do; 
			age_mean = age_sum / _n_;
			call symputx('avg', age_mean); /* creates a macro variable at the time of data step execution*/
		end;
	run;		
	proc print data=sashelp.class;
		title "Average for age of people is &avg";
	run;
%mend;

%class_age;

/* indirect macro processsing, conditional processing in macro, interative processing, 
local/global **/

/**** indirect macro references ****/
%let a = b;
%let b = c;
%let c = d;
*want to use the value of a to get the value of d;
/* multiple &&, multiple scanning */
&&&&&&&a /* && = & and &a = b */
&&&b /* && = & and &b = c */
&c /* &c = d */
d

data order;
	set "/folders/myfolders/order_fact.sas7bdat";
run;
data customer;
	set "/folders/myfolders/customer.sas7bdat";
run;
/* name4 = sandrina */
%macro cust_report(id);
	proc print data = work.order;
		title "customer name is &&name&id"; /* resolves to &name4 = sandrina */ 
		/* &name&id will not work because &name does not exist */
		where customer_id = &id;
	run;
%mend;















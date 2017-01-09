data work.order;
	set "/folders/myfolders/order_fact.sas7bdat";
run;
proc print data="/folders/myfolders/order_fact.sas7bdat";
run;
proc freq data=order;
	where year(order_date)=2008;
	table order_type;
	title "order types for 2008";
run;
proc means data=order;
	where year(order_date)=2008;
	class order_type;
	var total_retail_price;
	title "Price statistics for 2008";
run;

%put _automatic_;

data work.customer;
	set "/folders/myfolders/customer.sas7bdat";
run;

proc freq data="/folders/myfolders/customer.sas7bdat";
	table Country / nocum;
	footnote "Created &systime &sysday, &sysdate9";
run;

%let units = 4;
	proc print data=order;
	where quantity > &units;
	var order_date product_ID quantity;
	title "orders exceeding &units units";
run; 


%let date1=25may2007;
%let date2=15jun2007;
proc print data=order;
	where order_date between "&date1"d and "&date2"d;
	var order_date product_ID quantity;
	title "orders between &date1 and &date2";
run;

%put &=sysdate9;
%put year = %substr(&sysdate9,6);

%put %upcase(angel); 

%let name = angel;
%put %upcase(%substr(&name,1,1));

%put &=sysdate9;






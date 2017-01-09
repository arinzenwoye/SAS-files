data work.discounts;
	infile "/folders/myfolders/offers.dat";
	input @1 cust_type 4.
		  @5 offer_dt mmddyy8.
		  @14 Item_gp $8.
		  @22 discount percent3.;
run;	

data work.address;
	infile "/folders/myfolders/address.dat";
	input name $30.;
	input Address1 $21.;
   	input Address2 $25.;
   	input Phone $8.;    
run;

data salesQ1;
   infile "/folders/myfolders/sales.dat";
   input SaleID 4. @6 Location $3. @;
   if Location='USA' then
      input @10 SaleDate mmddyy10. 
            @20 Amount 7.;
   else if Location='EUR' then
      input @10 SaleDate date9. 
            @20 Amount commax7.;
run;

proc print data=sashelp.class;
run;

data new;
	set sashelp.class;
	if weight < 140 then output new;
run;


data test_sales;
	set sashelp.class;
		if weight < 140 then w_class = "low";
		else if weight ge 141 and weight <= 170 then w_class = "medium";
		else w_class = "high";
run;

data order;
	set "/folders/myfolders/order_fact.sas7bdat";
run;

%macro calc(stats, vars);
	proc means data=work.order &stats;
		var &vars;
	run;
%mend calc;

%calc(min max, quantity total_retail_price)






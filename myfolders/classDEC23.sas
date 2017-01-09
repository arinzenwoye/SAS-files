/*SUM and Retain Statements*/

data class2;
	set sashelp.class;
	age2 + age; /* initializes the new variable age2 to 0 and retains value for age2 cummilatively*/
run; /* this shows how to cummulate values using the sum statement*/

/*please note that by default the variable age2 is created with a numeric 8 byte variable */

data class2;
	set sashelp.class;
	retain age2 0;
	age2 = sum(age2, age);
run; /* another way to achieve the result with retain statement and the sum function*/

data class2;
	set sashelp.class;
	retain age2 300;
	age2 + (-age); /*reduce the initial age = 300 value by age on each obs*/
run; 

/* LOOPS */

/* amount = 5000, rate = 0.045, 5 years */

data deposit;
	amount = 5000;
	rate = 0.045;
	interest + (amount*rate);
	interest + (amount*rate);
	interest + (amount*rate);
	interest + (amount*rate);
	interest + (amount*rate);
run;
	
data deposit;
	amount = 5000;
	rate = 0.045;
	do i = 1 to 5;
	interest + (amount*rate);
	end;
run;

/* please nate in output i is 6. it increments to 6 but does not execute 6*/

data deposit;
	amount = 5000;
	rate = 0.045;
	do i = 1 to 10 by 2; /*increment by 2*/
	interest + (amount*rate);
	end;
run;

data deposit;
	amount = 5000;
	rate = 0.045;
	do i = 1 to 20;
	interest + (amount*rate);
	output; /*gives the output or interest at the end of each loop*/
	end;
run;

/* CONDITIONAL DO-LOOPS */

/*do until*/
data deposit2;
	amount = 5000;
	rate = 0.045;
	do until (interest >= 5000);
	interest + (amount*rate);
	year + 1; /*year initializes to 0 because it is a sum statement*/
	output;
	end;
run;
/*do while*/
data deposit3;
	amount = 5000;
	rate = 0.045;
	do while (interest <= 5000);
	interest + (amount*rate);
	year + 1;
	output;
	end;
run;

/**ARRAYS**/

/*arrays are used to REFER ANY PARTICULAR VALUE OR VARIABLE, TO CREATE SERIES OF 
NEW VARIABLES WITH THE SAME ATTRIBUTES */

/* lets say we want to convert mesurements for several variables ...*/

data class3;
	set class2;
	age_month = age * 12;
	height_cms = height * 2.54;
	weight_kg = weight * 0.4535;
run;
	
data class4;
	set class2;
	array parameters{3} age height weight;
	array cal{3}(12, 2.54, 0.4535);
	do i = 1 to 3;
		parameters(i) = parameters(i) * cal(i);
	end;
run; /*the array replaces the exisiting age height and weight variables */














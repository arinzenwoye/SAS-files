/* ARRAYS */
/* Refer series of SAS Variables */
/* Create SAS Variables with same variables */
/* To use as Table look up technique */

libname rang " ";
/* what is the difference in contribution across qtrs */
/* if we want to compare the donations to benchmark values */


data donations1;
	set rang.donations;
	array qdonate{4} qtr:;
	array diff{3};
	do i = 1 to 3;
		diff(i) = qdonate(i+1) - qdonate(i);
	end;
run;

data donations3;
	set rang.donations;
	array qdonate{4} qtr:;
	array bench{4} _temporary_(10,15,20,25);/*temporary creates an array in the PDV but not in the output */
	array diff{4};
	do i = 1to 4;
		diff(i) = qdonate(i) - bench(i);
		/*diff(i) = sum(qdonate(i), - bench(i))*/ /*turns missing values to 0 to create some negative values */
	end;
run;


/*PROCEDURES*/
/* PROC PRINT
	PROC CONTENTS
	PROC SORT
	PROC MEANS
	PROC FREQ
	PROC UNIVARIATE
	PROC REPORT
	PROC TABULATE
	PROC TRANSPOSE
*/
/* SAS Dataset : descriptor portion, data portion */
 
proc contents data = sashelp.class;
run;

title "information about sashelp.class"; /*title is a global statement */
proc print data = sashelp.class noobs; /*remove the obs column (optional)*/
var name sex age; /*display only some variables*/
where age < 13; /*subsetting with proc statement */
sum age;
run;
title; /*this remove the title statement, so it does get used by other reports or proc statements */

proc sort data=sashelp.class out=class2; /* out creates a new dataset and does not disturb/change the original dataset*/
by sex descending age; /*ascending is the default - by age*/ /*can also sort on multiple variables*/
run;

proc means data=sashelp.class skewness; /*provides sumamry statistics*/
var age; /* summary statistics for just one variable*/
class sex;
run;

proc freq data=sashelp.class;
tables sex*age; /*twoway freq table of sex by age*/ /*tables sex age command provides two seperate freq tables for the variables*/
run;
/*tables cna be used in certain procedures*/








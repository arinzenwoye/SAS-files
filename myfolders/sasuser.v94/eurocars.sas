libname rang "/folders/myfolders";

data rang.europeancars;
	set sashelp.cars;
	where origin = "Europe";
run;

proc print data = rang.europeancars;
run;

proc print data = sashelp.cars;
run;

data uspresidents;
	input president $ party $ number;
	datalines;
	adams f 2
	lincoln r 16
	grant r 18
	;
run;

data work.sales2_dta;
	infile "/folders/myfolders/sales1.csv" DSD MISSOVER FIRSTOBS=2;
	INPUT Employee_ID First_Name $ Last_Name $ Gender :$1. Salary Job_Title :$25. Country :$2.
	Birth_Date :date. Hire_Date :mmddyy.;
RUN;



/** FOR CSV Files uploaded from Windows **/

FILENAME CSV "<Your CSV File>" TERMSTR=CRLF;

/** FOR CSV Files uploaded from Unix/MacOS **/

FILENAME CSV "<Your CSV File>" TERMSTR=LF;

/** Import the CSV file.  **/

PROC IMPORT DATAFILE=CSV
		    OUT=WORK.MYCSV
		    DBMS=CSV
		    REPLACE;
RUN;

/** Print the results. **/

PROC PRINT DATA=WORK.MYCSV; RUN;

/** Unassign the file reference.  **/

FILENAME CSV;



/*CREATING LIBRARY USING LIBNAME STATEMENT */

libname Rang "C:\Users\Admin\Desktop\Rang\Data";

/*******************************************/

/* READING SAS DATASET */

data work.subset1; /* OUTPUT DATA */
   set Rang.sales; /* INPUT DATA */
   where Country='AU' and Job_Title contains 'Rep'; /* WHERE CONDITION */
/* DIFFERENT WHERE CONDITIONS */
/*   where Gender eq ' ';*/  
/*   where Salary>=50000;*/
/*   where Country in ('AU' 'US');*/
/*   where Order_Type in (1,2,3);*/
/*   where City not in ('London','Rome','Paris');*/

   /* DROP AND KEEP STATEMENT */ 
   drop Employee_ID Gender Country Birth_Date;
   keep First_Name Last_Name Salary Job_Title Hire_Date Bonus;

   /* IF CONDITION IF WRITTEN ON NEW VARIABLE */
   Bonus=Salary*.10;
   if Bonus>=3000;

run;

/***********************************************/
/***********************************************/

/* READING DEMILITED RAW DATA FILE USING LIST INPUT STYLE  */
data work.subset;  /* NAME OF SAS DATASET TO BE CREATED */
   infile "sales.csv" dlm=','; /* RAW DATA FILE SPECIFICATION WITH DLM OPTION */
   input Employee_ID First_Name $    /* VARIABLES IN SAS DATASETS */
         Last_Name $ Gender $ Salary /* VARIABLES IN SAS DATASETS */
         Job_Title $ Country $;      /* VARIABLES IN SAS DATASETS */
if Country='AU'; /* IF CONDITION */
   keep First_Name Last_Name Salary /* KEEP STATEMENT */
        Job_Title Hire_Date;        /* KEEP STATEMENT */
   label Job_Title='Sales Title' /* LABEL STATEMENT */
         Hire_Date='Date Hired'; /* LABEL STATEMENT */ 
   format Salary dollar12. Hire_Date monyy7.; /* FORMAT STATEMENT */
run;

/*************************************************/

/* DSD OPTION */

data work.contacts;
   length Name $ 20 Phone Mobile $ 14;
   infile "phone2.csv" dsd;
   input Name $ Phone $ Mobile $;
run;

/**************/

/* MISSOVER OPTION */
data contacts;
   length Name $ 20 Phone Mobile $ 14;
   infile "phone.csv" dlm=',' missover;
   input Name $ Phone $ Mobile $;
run;
/*****************/

/* RAW DATA FILE WITH FORMATTED STYLE */

data work.discounts;
   infile "offers.dat";
   input @1 Cust_type 4. 
         @5 Offer_dt mmddyy8.
         @14 Item_gp $8. 
         @22 Discount percent3.;
run;
/****************************************/

/* MULTIPLE INPUT STATEMENTS */
data contacts;
   infile "address.dat";
   input FullName $30.;
   input;
   input Address2 $25.;
   input Phone $8.;    
run;

/*****************************************/

/** SINGLE TRAILLING  */

data salesQ1;
   infile "sales.dat";
   input SaleID $4. @6 Location $3. @;
   if Location='USA' then
      input @10 SaleDate mmddyy10. 
            @20 Amount 7.;
   else if Location='EUR' then
      input @10 SaleDate date9. 
            @20 Amount commax7.;
run;

/****************************************/

/*  FIRSTOBS AND OBS = OPTIONS */

data class;
	set sashelp.class;
run;

Data firstobs;
set sashelp.class (firstobs = 10);
run;
proc print data=firstobs;
run;

Data obs;
set sashelp.class (obs = 10);
run;
proc print data=obs;
run;

Data btwnobs;
	set sashelp.class (firstobs=10 obs = 15);
Run;
proc print data=btwnobs;
run;

/*****************************************/

/* EXPLICIT OUTPUT STATEMENT */


data high medium low;
	set sashelp.class;
		if weight < 140 then output low;
		else if weight ge 141 and weight <= 170 then output medium;
		else output high;
run;

/****************************************/

/* SUBSETTING IF-THEN ELSE STATEMENT */
data work.comp;
   set Rang.sales;
   if Job_Title='Sales Rep. IV'  then Bonus=1000;
   else if Job_Title='Sales Manager' then Bonus=1500;
   else if Job_Title='Senior Sales Manager' then Bonus=2000;
   else if Job_Title='Chief Sales Officer' then Bonus=2500;
run;
/********************************************/

/* CONCATENING AND MERGING DATA SETS */
data test_a;
	a=1; b=8; output;
	a=4; b=5; output;
	a=5; b=6; output;
/*	a=7; b=99; output;*/
run;

data test_b;
	a=1; d=10; output;
	a=2; d=7;  output;
	a=5; d=6;  output;
	a=7; d=99; output;
run;

data teststack;
	set test_a test_b; /* CONCATENATING DATA SETS*/
run;

data teststack;
	set test_a test_b(rename = (d = b)); /* CONCATENATING DATA SETS USING RENAME = OPTION*/
run;



data test_set;
	set test_a test_b; /* CONCATINATING DATA SETS WITH BY STATEMENT */
	by a;
run;



proc sort data = test_a out = test1;
	by a;
run;

proc sort data = test_b out = test2;
	by a;
run;

data testmerge;
	merge test1 test2;/* MERGING DATA SETS */
	by a;
run;

data testa;
	a=1; b=8; output;
	a=1; b=3; output;
	a=1; b=4; output;
	a=5; b=7; output;
	a=4; b=6; output;
	a=7; b=99; output;
run;

data testb;
	a=1; b=10; output;
	a=2; b=7; output;
	a=5; b=6; output;
	a=7; b=99; output;
run;

proc sort data = testa out = testa1;
	by a b;
run;

proc sort data = testb out = testb1;
	by a b;
run;

data testmerge;
	merge testa1 testb1;
	by a b;
run;

proc sort data = test_a out = testa1;
	by a b;
run;

proc sort data = test_b out = testb1;
	by a b;
run;

data testmerge;
	merge testa1 (in=x) testb1(in=y);
	by a;
	if x=1 and y=0;
run;

/***************************************************************/



/* FUNCTIONS */

data sample;
	dob="23OCT89"d;
	year=year(dob); /* YEAR FUNCTION */
	month=month(dob); /* MONTH FUNCTION */
	day=day(dob); /* DAY FUNCTION */
	weekday=weekday(dob); /* WEEKDAY FUNCTION */
	qtr=qtr(dob); /* QTR FUNCTION */
	format dob date9.;
run;



data sample3;
	d1=date(); /* DATE FUNCTION */
	d2=today(); /* TODAY FUNCTION */
	format d1 d2 date9.;
run;

data sample4;
	mdy_option=mdy(08,21,2005); /* MDY FUNCTION */
	format mdy_option date9.;
run;



DATA SAMPLE;
DOJ="23OCT67"D;
DOR="30NOV89"D;
FORMAT DOJ DOR DATE9.;
SERVICE=INTCK("YEAR",DOJ,DOR); /* INTCK FUNCTION */
RUN;

DATA NEW; 
TIME="04:30:01"; 
HOUR=SCAN(TIME,1,':'); /* SCAN FUNCTION */
MINUTE=SCAN(TIME,2,':'); /* SCAN FUNCTION */
SE=SCAN(TIME,3,':'); /* SCAN FUNCTION */
SASTIME=HMS(HOUR,MINUTE,SE); /* HMS FUNCTION */
RUN;


data charfunc;
	name='            Rang';
	left_function=left(name); /* LEFT FUNCTION */

	name2="Rang           ";
	trim_function=trim(name2); /* RIGHT FUNCTION */

	name3="     Rang     ";
	strip_func=strip(name3); /* STRIP FUNCTION */

	namepart1='Jhon';
	namepart2='son';
	cat_func=cat(namepart1, namepart2); /* CAT FUNCTION */
	second_method=namepart1||namepart2; /* CONCANETING OPERATOR */

run;

data length;
	set emplymnt.emp (keep = EMPNO ENAME);
	length_func=length(ENAME); /* LENGTH FUNCTION */
run;

data substr;
	set emplymnt.emp (keep = empno ename job);
	j_code=substr(job, 1, 3); /* SUBSTR FUNCTION */

	usubjid='MSB-RA001';
	use_substr=substr(usubjid, 5, 5); /* SUBSTR FUNCTION */
run;
/*The first argument is the job - variable from which we want to extract the substring, the second argument is the starting */
/*position of the substring, and the last argument is the length of the substring.*/

data scan;
	name='Thomas Jhon Devid';
	F_NAME=SCAN(NAME,1); /* SCAN FUNCTION */
	M_NAME=SCAN(NAME,2); /* SCAN FUNCTION */
	L_NAME=SCAN(NAME,3); /* SCAN FUNCTION */
run;
/*Returns the nth "word" from the name variable*/

data index;
	alpha='ABCDEFG';
	index_func=INDEX(alpha,'DEF'); /* INDEX FUNCTION */
run;
/*The first argument is the argument you want to search, the second argument is the string you are searching for.*/

data test1;
	name='ScoTT';
	prpcase_fun = propcase (name); /* PROPCASE FUNCTION */
run;

data num_func;
	do n=1 to 10;
		sqrt_n=sqrt(n); /*SQRT FUNCTION */
		int=int(sqrt_n); /* INT FUNCTION */
		ceil=ceil(sqrt_n); /* CEIL FUNCTION */
		floor=floor(sqrt_n); /* FLOOR FUNCTION */
		round=round(sqrt_n); /* ROUND FUNCTION */

		mean=mean(n,ceil); /* MEAN FUNCTION */
		sum=sum(n, round); /* SUM FUNCTION */
		min=min(n, ceil); /* MIN FUNCTION */
		max=max(n, ceil); /* MAX FUNCTION */
		output;
	end;
run;



 
/* Do Loops */
data compound(drop=i);
     Amount=50000;
     Rate=.045;
   do i=1 to 20;      /* Loop for 20 yrs compounding yearly */
      Yearly +(Yearly+Amount)*Rate;
   end;
   do i=1 to 80;
       Quarterly+((Quarterly+Amount)*Rate/4); /* Loop for 20 yrs compounding quarterly */
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
	var a b c;
	sum a b;
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
   by Salary;
run;

/**************************************/

/* PROC FREQ */

proc freq data=Rang.sales;
   tables Gender;
run;

/* TWO WAY FREQUENCY */

proc freq data=Rang.sales;
   tables Gender*Country;
   where Country='AU';
run;

/* PROC MEANS */

proc means data=Rang.sales;
var ;
class ;
run; 

/***************************************/











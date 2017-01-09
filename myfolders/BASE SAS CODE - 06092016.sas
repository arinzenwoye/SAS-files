libname rang "C:\Users\Admin\Desktop\Rang\Data2";


data high medium low;
	set sashelp.class;
		if weight < 140 then output low;
		else if weight ge 141 and weight <= 170 then output medium;
		else output high;
run;


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
	a=1; d=10; output;
	a=2; d=7; output;
	a=5; d=6; output;
	a=7; d=99; output;
run;

proc sort data = testa out = testa1;
	by a ;
run;

proc sort data = testb out = testb1;
	by a ;
run;

data testmerge;
	merge testa1 testb1;
	by a ;
run;

proc sort data = test_a out = testa1;
	by a b;
run;

proc sort data = test_b out = testb1;
	by a b;
run;

data testmerge3;
	merge testa1 (in=x) testb1(in=y);
	by a;
	if x=0 or y=0;
run;

data one;
A = 'AQI2';
B = substr(A,1,3);
C = substr(A,4,1);
run;

data two;
A = 'ABCD   ';
B = '   ABCD';
E = 'AB  CD';
C = length(A);
D = length (B);
F = length(E);
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


data charfunc1;
	name='            Rang';
	left_function=left(name); /* LEFT FUNCTION */

	name2="Rang           ";
*trim_function=trim(name2); /* RIGHT FUNCTION */

	*name3="     Rang     ";
	*strip_func=strip(name3);

	/*name4 = char("Rang",2);/* STRIP FUNCTION */*/

	namepart1='Jhon';
	*namepart2='son';
cat = cat(name,name2);
catx = catx('***',name,name2);
cats = cats(name,name2);
catt = catt(name,name2);

	*cat_func=cat(namepart1, namepart2); /* CAT FUNCTION */
	*second_method=namepart1||namepart2; /* CONCANETING OPERATOR */

run;

data three;
A = 'ABCD123EFGH';
B = tranwrd(A,'123','456');

run;
proc format;
  value bp 1 - 80 = 'low'
           81- 100 = 'medium'
		   101 - high = 'high';
run;

proc format;
value range low - 5 = 'low'
            6 - high = 'high';
run;

data testmerge22;
set testmerge2;
e = put(b,range.);
run; 

proc print data = testmerge2;
format b range.;
run;


proc format;
 invalue $bp 'low' = 60
              'high' = 100
              'medium' = 80;
run; 

 

data put_ex;
A = 90;
B = put(A,bp7.);
C = input(B,$bp6.);
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

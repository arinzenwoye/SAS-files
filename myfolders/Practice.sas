libname Rang "folders/myfolders/Rang";

/* Chapter 2 - Text */
data work.demographic;
	infile "/folders/myfolders/mydata.txt";
	input Gender $ Age Height Weight;
	*compute a body mass index;
	BMI = (Weight/2.2) / (Height*0.254)**2;
run;
title 'Gender Frequencies';
proc freq data=demographic;
	tables Gender;
run;
title "Summary Statistics";
proc means data=demographic;
	var Age Weight Height;
run;

/* Chapter 2 - Problems */

*1;
data work.portfolio;
	infile "/folders/myfolders/stocks.txt";
	input symbol $ price shares;
	value = price * shares;
run;
title "List of Portfolio";
proc print data=work.portfolio;
run;
proc means data=work.portfolio;
	var price shares;
run;

*2;
data prob2;
	input	ID $
			Height /* in inches */
			Weight /* in pounds */
			SBP /* systolic BP */
			DBP /* diastolic BP */;
	WtKg = Weight/2.2;
	HtCm = Height*2.54;
	AveBP = DBP + 1/3 * (SBP - DBP);
	HtPolynomial = 2 * Height**2 + 1.5 * Height**3;
datalines;
001 68 150 110 70
002 73 240 150 90
003 62 101 120 80
;
title "Listing of Prob2";
proc print data=prob2;
run;

*3;
/*
EMF = 1.45*V + (R/E)*V**3 - 125;
*/

*4;
			
			







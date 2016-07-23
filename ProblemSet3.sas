* Problem Set 3;
* Yizhe Ge;
* yg2kj;

filename pr1a "C:\LocalData\PS3Prob1A.txt";
filename pr1bout "C:\LocalData\PS3Prob1Bout.txt";
filename pr1cout "C:\LocalData\PS3Prob1Cout.txt";
filename pr2 "C:\LocalData\PS3Prob2.txt";
filename pr3 "C:\LocalData\PS3Prob3.txt";
filename pr3out "C:\LocalData\PS3Prob3out.txt";

libname PSthree 'C:\LocalData';

title1 "Problem Set 3";
title2 "Problem 1";
title3 "Part A";
options nocenter;

data survey;
infile pr1a;
input @1 subjID $7.
	  @9 gender $1.
	  @11 dob mmddyy10.
	  @22 (qA1-qA4) (1.)
	  @27 qB1 dollar7.2
	  @34 qB2 dollar7.2
	  @41 qB3 dollar7.2
	  @48 (qC1-qC5) (1.);
totB = sum(of qB1-qB3);
pctC = sum(of qC1-qC5)/5;
adultyrs = yrdif(dob + 18*365.25, '24aug10'd, 'ACT/ACT');
run;

proc print data=survey label;
var gender adultyrs totB pctC;
id subjID;
format adultyrs 8.0
	   totB dollar8.2
	   pctC percent8.0;
label gender = "Gender"
	  adultyrs = "Adult Years"
	  totB = "Total of Question B"
	  pctC = "Percent of Yes for Question C";
run;

********************************************************;

title3 "Part B";

data _null_;
infile pr1a;
file pr1bout;
input @1 subjID $7.
	  @9 gender $1.
	  @11 dob mmddyy10.
	  @22 (qA1-qA4) (1.)
	  @27 qB1 dollar7.2
	  @34 qB2 dollar7.2
	  @41 qB3 dollar7.2
	  @48 (qC1-qC5) (1.);
totB = sum(of qB1-qB3);
pctC = sum(of qC1-qC5)/5;
adultyrs = yrdif(dob + 18*365.25, '24aug10'd, 'ACT/ACT');
put @1 subjID $7. 
	@9 gender $1.
	@11 adultyrs 8.
	@20 totB dollar8.2
	@29 pctC percent8.0;
run;

********************************************************;

title3 "Part C";

data survey;
set PSthree.PS3Prob1C;
file pr1cout;
totB = sum(of qB1-qB3);
pctC = sum(of qC1-qC5)/5;
adultyrs = yrdif(dob + 18*365.25, '24aug10'd, 'ACT/ACT');
put @1 subjID $7. 
	@9 gender $1.
	@11 adultyrs 8.
	@20 totB dollar8.2
	@29 pctC percent8.0;
run;

********************************************************;

title2 "Problem 2";

data health;
infile pr2;
input ID : $3. gender : $1. dob : mmddyy10. height weight;
run;

proc print data=health;
format dob date9.;
run;

proc contents data=health;
run;

data health;
infile pr2;
input ID : $3. gender : $1. dob : mmddyy10. height weight;
format dob date9.;
run;

proc print data=health;
run;

proc contents data=health;
run;

* If we move the format statement from proc print to the data step, a new column called
"format" will be generated in the proc contents output. The "format" for dob will be set
to "DATE9.". Temporary format to permanent format.

********************************************************;

title2 'Problem 3';

* save data into a library;
data PSthree.survey;
infile pr3;
input @1 age 2.
	  @4 gender $1.
	  @6 (q1-q5) (1.);
run;

proc print data=PSthree.survey;
run;

* read data from the library;
data survey;
set PSthree.survey;
run;

proc means data=survey mean;
var age;
run;

proc freq data=survey;
tables q1-q5 / nocum nopercent;
run;

* write to an external file;
data survey;
set PSthree.survey;
file pr3out;
Responses = catx(" ",q1,q2,q3,q4,q5);
if q5=3 then put 'age=' age 'gender=' gender 'Responses = ' Responses;
run;

********************************************************;

title2 "Problem 4";
title3 "Part A";

data survey2;
set PSthree.PS3Prob4;
run;

proc format;
value age
	0-<30 = "0 to under 30"
	30-<50 = "30 to under 50"
	50-<70 = "50 to under 70"
	70-high = "70 or older"
	. = "Missing Value";
value $party
	"L" = "Left"
	"R" = "Right"
	"C" = "Center"
	"I" = "Independent"
	" " = "Missing Value"
	other = "Other";
value response
	1 = "Strongly Disagree"
	2 = "Disagree"
	3 = "No Opinion"
	4 = "Agree"
	5 = "Strongly Agree"
	. = "Missing Value";
run;

proc print data=survey2 label;
format age age. party $party. q1-q4 response.;
label q1 = "Congressperson X is doing a good job"
	  q2 = "Institution Y is doing a good job"
	  q3 = "Plan Z is the correct solution for Issue A"
	  q4 = "The country is on track regarding Issue B";
var age party q1-q4;
run;

********************************************************;

title3 "Part B";

proc format;
value Likert
	1-2 = "General Disagreement"
	3 = "No Opinion"
	4-5 = "General Agreement"
	. = "Missing Value";
value $partyAff
	"C", "I", other = "Other"
	"L" = "Left"
	"R" = "Right"
	" " = "Missing Value";
run;

proc freq;
format age age. party $partyAff. q1-q4 Likert.;
tables party q1-q4 / nocum nopercent;
run;

********************************************************;

title2 "Problem 5";
title3 "Part A";

data PSthree.Mountain_USA PSthree.Road_France;
set PSthree.bicycles;
if Country = "USA" and Model = "Mountain Bike" then output PSthree.Mountain_USA;
if Country = "France" and Model = "Road Bike" then output PSthree.Road_France;
run;

proc print data=PSthree.Mountain_USA;
run;

proc print data=PSthree.Road_France;
run;

********************************************************;

title3 "Part B";

data markup;
input manuf : $10. Markup;
datalines;
Cannondale 1.05
Trek 1.07
;
run;

proc sort data=markup;
by manuf;
run;

data bicycles;
set PSthree.bicycles;
run;

proc sort data=bicycles;
by Manuf;
run;

data markup_prices;
merge bicycles markup(rename=(manuf=Manuf));
by Manuf;
newtotal = TotalSales * Markup;
run;

proc print data=markup_prices;
run;

********************************************************;

title2 "Problem 6";

proc print data=PSthree.inventory;
run;

proc print data=PSthree.newproducts;
run;

proc print data=PSthree.purchase;
run;

********************************************************;

title3 "Part A";

data inventory;
set PSthree.inventory;
run;

proc sort data=inventory;
by Model;
run;

data newproducts;
set PSthree.newproducts;
run;

proc sort data=newproducts;
by Model;
run;

data updated;
set inventory newproducts;
by Model;
run;

proc print data=updated;
run;

********************************************************;

title3 "Part B";
data inventory;
set PSthree.inventory;
run;

proc sort data=inventory;
by Model;
run;

data purchase;
set PSthree.purchase;
run;

proc sort data=purchase;
by Model;
run;

********************************************************;

data pur_price unpurchased(drop=CustNumber Quantity totcost);
merge inventory(in=inI) purchase(in=inP);
by Model;
totcost=Quantity*Price;
if inI and inP then output pur_price;
if inI and not inP then output unpurchased;
run;

proc print data=pur_price;
run;

proc print data=unpurchased;
run;

********************************************************;

title3 "Part C";

data changes;
input Model : $8. price;
datalines;
M567 25.95
X999 35.99
;
run;

data inventory;
set PSthree.inventory;
run;

data newprices;
update inventory changes(rename=(price=Price));
by Model;
run;

proc print data=newprices;
run;

********************************************************;

title2 "Problem 7";

proc print data=PSthree.monthsales;
run;

data PSthree.newsales;
retain sumsales 0;
set PSthree.monthsales;
if not missing(sales) then sumsales = sumsales + sales;
run;

proc print data=PSthree.newsales;
var month sales sumsales;
run;

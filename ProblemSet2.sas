title1 'Problem Set 2';
title2 'Problem 1';
title3 'Part A';
options nocenter;

data expt;
keep ID Gender Pre5 Time;
infile 'C:\LocalData\PS2Prob1.txt';
input ID : $7. Gender : $1. Weight Age Pulse Pre1 Pre2 Pre3 Pre4 
Pre5 : $1. Expt $ Time Post1 Post2 Post3 Post4 Post5;
if _n_ >= 235 then delete;
if Pre5 in ('1', '2','3') then delete;
run;

proc print data=expt;
run;

********************************************************;

title3 'Part B';

data expt;
infile 'C:\LocalData\PS2Prob1.txt';
input ID : $7. Gender : $1. Weight Age Pulse Pre1 : $1. Pre2 : $1.
Pre3 : $1. Pre4 : $1. Pre5 : $1. Expt : $1. Time Post1 : $1. 
Post2 : $1. Post3 : $1. Post4 : $1. Post5 : $1.;
if _n_ >= 235 then delete;
if Pre5 in ('1', '2','3') then delete;
run;

proc print data=expt(keep=ID Gender Pre5 Time);
run;

********************************************************;

title2 'Problem2';

data preds;
input x1 x2;
y = 96.0240 - 1.8245*x1 + 0.5652*x2 + 0.0247*x1*x2 + 0.0140*x1**2 - 0.0118*x2**2;
datalines;
5 10
5 30
5 50
20 10
20 30
20 50
40 10
40 30
40 50
;
run;

proc print data=preds;
run;

********************************************************;

title2 'Problem 3';

data vote;
infile 'C:\LocalData\PS2Prob3.csv' dsd;
input state $ party $ age;
run;

proc print data=vote;
run;

********************************************************;

title2 'Problem 4';
title3 'Part A';

data bank;
infile 'C:\LocalData\PS2Prob4.txt';
input name $ 1-15
	  acct $ 16-20
	  balance  21-26
	  rate  27-30;
interest = (balance * rate)/100;
run;

proc print data=bank;
run;

********************************************************;

title3 'Part B';

data bank;
infile 'C:\LocalData\PS2Prob4.txt';
input @1 name $15.
	  @16 acct $5.
	  @21 balance 6.
	  @27 rate 4.;
interest = (balance * rate)/100;
run;

proc print data=bank;
run;

********************************************************;

title2 'Problem 5';

data expt;
infile 'C:\LocalData\PS2Prob1.txt';
input ID $ 1-7
	  Gender $ 9
	  Pre5 $ 29
	  Time  33-36;
if _n_ >= 235 then delete;
if Pre5 in ('1', '2', '3') then delete;
run;

proc print data=expt;
run;

********************************************************;

title2 'Problem 6';

data stocks;
infile 'C:\LocalData\PS2Prob6.txt';
input @1 stock $4.
	  @5 purdate mmddyy10.
	  @15 purprice dollar6.1
	  @21 number 4.
	  @25 selldate mmddyy10.
	  @35 sellprice dollar6.1;
totalpur = number * purprice;
totalsell = number * sellprice;
profit = totalsell - totalpur;
run;

proc print data=stocks;
run;

********************************************************;

title2 'Problem 7';
title3 'Part A';

data emp1A;
keep ID name dept datehire salary;
infile 'C:\LocalData\PS2Prob7A.csv' truncover dsd;
input ID $ name : $14. dept $ datehire : mmddyy10. sal1 : dollar8. sal2;
salary = sal1 * 1000 + sal2;
run;

proc print data=emp1A;
run;

********************************************************;

title3 'Part B';

data emp1B;
infile 'C:\LocalData\PS2Prob7B.txt' truncover dlm='"$';
input ID $ name : $14. dept $ datehire : mmddyy10. salary : dollar8.;
run;

proc print data=emp1B;
run;

********************************************************;

title3 'Part C';

data emp1C;
infile 'C:\LocalData\PS2Prob7C.txt' dsd dlm='*';
input ID $ name : $14. dept $ datehire : mmddyy10. salary : dollar8.;
run;

proc print data=emp1C;
run;

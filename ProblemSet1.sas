Title1 'Problem Set 1';
Title2 'Problem 1';
Options nocenter;

Data Prob1Data;
Infile 'C:\LocalData\PS1Prob1.txt';
* hgt - ads; * asd;
Input obj $ hgt wid;
Run;

Proc print;
Var obj wid hgt;
Run;

Title1 'Problem Set 1';
Title2 'Problem 5';
Options nocenter;

Data expt;
Infile 'C:\LocalData\PS1Prob5.txt';
Input sample $ temp_degF press_psi;
temp_degC = (5/9) * (temp_degF - 32);
press_Pa = press_psi * 6894.757;
quadT2 = temp_degC**2;
quadP2 = press_Pa**2;
quadTP = temp_degC * press_Pa;
Run;

Proc print;
Var sample temp_degF press_psi temp_degC press_Pa quadT2 quadP2 quadTP;
Run;

Title1 'Problem Set 1';
Title2 'Problem 7';
Options nocenter;

Data PS1Prob7;
Infile 'C:\LocalData\PS1Prob7.txt';
Input class $ x1 y1 y2;
Run;

proc means data=PS1Prob7 mean median;
var x1 y1 y2;
Run;

proc freq data=PS1Prob7;
tables class / nocum;
Run;

proc univariate data=PS1Prob7;
var x1;
qqplot x1;
Run;

proc corr data=PS1Prob7 noprob;
var x1 y1;
Run;

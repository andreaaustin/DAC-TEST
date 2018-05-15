
/*
proc import datafile="/projects/active/51356/programs/aaustin/all_provpairs_hrr13.csv" out=pairs
dbms=csv replace;
run;

data pairs2;
set pairs;
*keep prfnpi1 prfnpi2;
if hrr1=hrr2;
run;

/*proc sort data=pairs2; by prfnpi1 prfnpi2;run;

proc print data=pairs2(obs=10);

*/


libname idata '/projects/active/51356/idata/aaustin/hsa_nets';
options nofmterr;


data cohort;
set idata.hsacohort;
run;

proc freq data=cohort;
table assignedcliniciannpi*(hospicedod30)/out=temp;
run;

proc sort data=temp; by assignedcliniciannpi;
data temp2;
set temp;
by assignedcliniciannpi;
if first.assignedcliniciannpi then denom=0;
denom+count;
run;

data temp3;
set temp2;
hospicerate=count/denom;
if hospicedod30=1;
if assignedcliniciannpi ne .;
npi = assignedcliniciannpi;
keep npi hospicerate;
run;

proc export data=temp3 outfile="/projects/active/51356/programs/aaustin/spatial_hrr/doc_hospice.csv"
dbms=csv replace;
run;

data cohort;
set idata.hsacohort;
if white=1;
run;

proc freq data=cohort;
table assignedcliniciannpi*(hospicedod30)/out=temp;
run;

proc sort data=temp; by assignedcliniciannpi;
data temp2;
set temp;
by assignedcliniciannpi;
if first.assignedcliniciannpi then denom=0;
denom+count;
run;

data temp3;
set temp2;
hospicerate=count/denom;
if hospicedod30=1;
if assignedcliniciannpi ne .;
npi = assignedcliniciannpi;
keep npi hospicerate;
run;

proc export data=temp3 outfile="/projects/active/51356/programs/aaustin/spatial_hrr/doc_hospice_white.csv"
dbms=csv replace;
run;

data cohort;
set idata.hsacohort;
if white=0;
run;

proc freq data=cohort;
table assignedcliniciannpi*(hospicedod30)/out=temp;
run;

proc sort data=temp; by assignedcliniciannpi;
data temp2;
set temp;
by assignedcliniciannpi;
if first.assignedcliniciannpi then denom=0;
denom+count;
run;

data temp3;
set temp2;
hospicerate=count/denom;
if hospicedod30=1;
if assignedcliniciannpi ne .;
npi = assignedcliniciannpi;
keep npi hospicerate;
run;

proc export data=temp3 outfile="/projects/active/51356/programs/aaustin/spatial_hrr/doc_hospice_black.csv"
dbms=csv replace;
run;


*proc print data=temp3(obs=10);

--Table Creation
CREATE TABLE studies (PNAME varchar(20), INSTITUTE varchar(20), COURSE varchar(20), COURSE_FEE int )
-- Insertion
INSERT INTO studies
SELECT 'ANAND','SABHARI','PGDCA',4500 UNION ALL
SELECT 'ALTAF','COIT','DCA',7200 UNION ALL
SELECT 'JULIANA','BDPS','MCA',22000 UNION ALL
SELECT 'KAMALA','PRAGATHI','DCA',5000 UNION ALL
SELECT 'MARY','SABHARI','PGDCA ',4500 UNION ALL
SELECT 'NELSON','PRAGATHI','DAP',6200 UNION ALL
SELECT 'PATRICK','PRAGATHI','DCAP',5200 UNION ALL
SELECT 'QADIR','APPLE','HDCA',14000 UNION ALL
SELECT 'RAMESH','SABHARI','PGDCA',4500 UNION ALL
SELECT 'REBECCA','BRILLIANT','DCAP',11000 UNION ALL
SELECT 'REMITHA','BDPS','DCS',6000 UNION ALL
SELECT 'REVATHI','SABHARI','DAP',5000 UNION ALL
SELECT 'VIJAYA','BDPS','DCA',48000
-- To View
SELECT*FROM studies


--Table Creation

CREATE TABLE software (PNAME varchar(20), TITLE varchar(20), DEVELOPIN varchar(20), 
SCOST decimal(10,2),  DCOST int, SOLD int)

INSERT INTO software (PNAME, TITLE, DEVELOPIN, SCOST, DCOST, SOLD)
Values ( 'MARY','README','CPP',300, 1200, 84),
		( 'ANAND','PARACHUTES','BASIC',399.95, 6000, 43),
		('ANAND','VIDEO TITLING','PASCAL',7500, 16000, 9),
		( 'JULIANA','INVENTORY','COBOL',3000, 3500, 0 ),
		( 'KAMALA','PAYROLL PKG.','DBASE',9000, 20000, 7), 
	 ( 'MARY','FINANCIAL ACCT.','ORACLE',18000, 85000, 4 ),
	 ('MARY','CODE GENERATOR','C',4500, 20000, 23 ),
	('PATTRICK','README','CPP',300, 1200, 84 ),
	 ('QADIR','BOMBS AWAY','ASSEMBLY',750, 3000, 11 ),
	('QADIR','VACCINES','C',1900, 3100, 21 ),
	('RAMESH','HOTEL MGMT.','DBASE',13000, 35000, 4 ),
	 ('RAMESH','DEAD LEE','PASCAL',599.95, 4500, 73),
	('REMITHA','PC UTILITIES','C',725, 5000, 51 ),
	 ('REMITHA','TSR HELP PKG.','ASSEMBLY',2500, 6000, 7 ),
	 ('REVATHI','HOSPITAL MGMT.','PASCAL',1100, 75000, 2 ),
	('VIJAYA','TSR EDITOR','C',900, 700, 6);

-- Table View

select * from software


--create Table Creation
CREATE TABLE programmer (PNAME varchar(20), DOB date, DOJ date, GENDER varchar(2), PROF1 varchar(20), PROF2 varchar(20), SALARY int)
-- Insertion
INSERT INTO programmer
SELECT 'ANAND','12-Apr-66','21-Apr-92','M','PASCAL','BASIC',3200 UNION ALL
SELECT 'ALTAF','02-Jul-64','13-Nov-90','M','CLIPPER','COBOL',2800 UNION ALL
SELECT 'JULIANA','31-Jan-60','21-Apr-90','F','COBOL','DBASE',3000 UNION ALL
SELECT 'KAMALA','30-Oct-68','02-Jan-92','F','C','DBASE',2900 UNION ALL
SELECT 'MARY','24-Jun-70','01-Feb-91','F','CPP','ORACLE',4500 UNION ALL
SELECT 'NELSON','11-Sep-85','11-Oct-89','M','COBOL','DBASE',2500 UNION ALL
SELECT 'PATTRICK','10-Nov-65','21-Apr-90','M','PASCAL','CLIPPER',2800 UNION ALL
SELECT 'QADIR','31-Aug-65','21-Apr-91','M','ASSEMBLY','C',3000 UNION ALL
SELECT 'RAMESH','03-May-67','28-Feb-91','M','PASCAL','DBASE',3200 UNION ALL
SELECT 'REBECCA','01-Jan-67','01-Dec-90','F','BASIC','COBOL',2500 UNION ALL
SELECT 'REMITHA','19-Apr-70','20-Apr-93','F','C','ASSEMBLY',3600 UNION ALL
SELECT 'REVATHI','02-Dec-69','02-Jan-92','F','PASCAL','BASIC',3700 UNION ALL
SELECT 'VIJAYA','14-Dec-65','02-May-92','F','FOXPRO','C',3500
-- To View
SELECT * FROM programmer

--1. Find out the selling cost AVG for packages developed in Pascal.
select AVG(SCOST)as Average_SCOST from software where DEVELOPIN = 'PASCAL'

--2. Display Names, Ages of all Programmers. 
SELECT PNAME as Name, DATEDIFF(YY,DOB,GETDATE()) from programmer
--or
select PNAME, YEAR (GETDATE())-YEAR(DOB) AS age from programmer

--3. Display the Names of those who have done the DAP Course.
select pname,COURSE from studies where COURSE = 'dap'

--4. Display the Names and Date of Births of all Programmers Born in January. 
select PNAME, DOB FROM programmer WHERE month (DOB) = 1
--or
select PNAME, DOB FROM programmer WHERE DATENAME(month,DOB)='JANUARY'

--5. What is the Highest Number of copies sold by a Package? 
select max(sold) as maximum_sold from software

--6. Display lowest course Fee. 
select min(COURSE_FEE) as maximum_sold from studies

--7. How many programmers done the PGDCA Course?
select COUNT (PNAME) AS COURCE_DOING_PGDC FROM studies WHERE COURSE = 'PGDCA'

--8. How much revenue has been earned thru sales of Packages Developed in C.
SELECT SUM(SCOST*SOLD) FROM software WHERE DEVELOPIN ='C'

--9. Display the Details of the Software Developed by Ramesh.
SELECT * FROM software WHERE PNAME = 'RAMESH'

--10. How many Programmers Studied at Sabhari? 
SELECT COUNT(PNAME) AS STUDIES_AT_SABHARI FROM studies WHERE INSTITUTE ='SABHARI'

--11. Display details of Packages whose sales crossed the 2000 Mark. 
SELECT title, SUM(SCOST*SOLD) AS TOTAL_REVENUE FROM software group by title
having sum(SCOST*SOLD) >2000 

--12. Display the Details of Packages for which Development Cost have been recovered.
SELECT* FROM software WHERE (SCOST*SOLD) > DCOST
--OR
SELECT PNAME,title,dcost, SUM(SCOST*SOLD) AS TOTAL_REVENUE FROM software group by title,PNAME,DCOST
having sum(SCOST*SOLD) >dcost

--13. What is the cost of the costliest software development in Basic? 
SELECT title, max(DCOST) FROM software WHERE DEVELOPIN = 'BASIC'
GROUP BY title

--14. How many Packages Developed in DBASE? 
select COUNT(DEVELOPIN) from software where DEVELOPIN ='DBASE'
--or
select COUNT(1) from software where DEVELOPIN ='DBASE'
--or
select title, COUNT(1) from software where DEVELOPIN ='DBASE'
group by title

--15. How many programmers studied in Pragathi?
select count(PNAME) FROM STUDIES WHERE INSTITUTE = 'PRAGATHI'
--OR
select PNAME, count(PNAME) FROM STUDIES WHERE INSTITUTE = 'PRAGATHI'
GROUP BY PNAME

--16. How many Programmers Paid 5000 to 10000 for their course? 
SELECT COUNT(PNAME) FROM studies where COURSE_FEE between 5000 and 10000
--or
SELECT PNAME, COURSE_FEE, COUNT (PNAME) FROM studies where COURSE_FEE between 5000 and 10000
group by PNAME, COURSE_FEE

--17. What is AVG Course Fee 
SELECT AVG(COURSE_FEE) as course_fee from studies

--18. Display the details of the Programmers Knowing C.
select* from programmer where PROF1 = 'c' or PROF2 ='c'

--19. How many Programmers know either COBOL or PASCAL. 
select COUNT(PNAME) from programmer where 
PROF1 = 'COBOL' or PROF2 ='COBOL' 
OR
PROF1 = 'PASCAL' or PROF2 ='PASCAL'

--OR
select PNAME, COUNT(PNAME) from programmer where 
PROF1 IN( 'COBOL', 'PASCAL')
OR
PROF2 IN( 'COBOL', 'PASCAL')
GROUP BY PNAME

--20. How many Programmers Don’t know PASCAL and C 
SELECT  COUNT(PNAME)FROM programmer WHERE NOT
((PROF1 = 'PASCAL' OR PROF2 ='C')
OR
(PROF1 = 'C' OR PROF2 ='PASCAL'))

--OR
SELECT PNAME,  COUNT(PNAME)FROM programmer WHERE NOT
((PROF1 = 'PASCAL' OR PROF2 ='C')
OR
(PROF1 = 'C' OR PROF2 ='PASCAL'))
GROUP BY PNAME

--21. How old is the Oldest Male Programmer. 
SELECT MAX(DATEDIFF(YY,DOB,GETDATE())) AS Maximum_Age from programmer where GENDER = 'M'
--OR
select max (year(getdate())-year(dob))as maximum_age from programmer where GENDER ='m'

--22. What is the AVG age of Female Programmers? 
SELECT Avg(DATEDIFF(YY,DOB,GETDATE())) AS AVERAGE_Age from programmer where GENDER = 'F'


--23. Calculate the Experience in Years for each Programmer and Display with their 
--names in Descending order. 
SELECT PNAME, DATEDIFF (YY,DOJ,GETDATE()) AS EXPERIENCE FROM programmer ORDER BY PNAME DESC

--24. Who are the Programmers who celebrate their Birthday’s During the Current
--Month?
select pname, DOB from programmer where MONTH(DOB) = MONTH(GETDATE())

--25. How many Female Programmers are there? 
SELECT COUNT(PNAME) AS FEMALE from programmer where GENDER = 'F'
--OR
SELECT PNAME, COUNT(PNAME) AS FEMALE FROM programmer WHERE GENDER = 'F' group by PNAME

--26. What are the Languages studied by Male Programmers.
SELECT *FROM programmer WHERE GENDER = 'M'
--OR
SELECT PNAME, GENDER, PROF1,PROF2 FROM programmer WHERE GENDER = 'M'

--27. What is the AVG Salary? 
SELECT AVG(SALARY) AS AVG_SALARY FROM programmer

--28. How many people draw salary 2000 to 4000?
SELECT COUNT(PNAME) AS draw_salary_2000_to_4000  FROM programmer WHERE SALARY BETWEEN 2000 AND 4000
--OR
SELECT PNAME, COUNT(PNAME) AS draw_salary_2000_to_4000  FROM programmer WHERE SALARY BETWEEN 2000 AND 4000 GROUP BY PNAME

--29. Display the details of those who don’t know Clipper, COBOL or PASCAL. 
SELECT *FROM programmer WHERE NOT
(PROF1 IN ('CLIPPER', 'COBOL','PASCAL') 
OR
PROF2 IN ('CLIPPER', 'COBOL','PASCAL'))

--or
SELECT *FROM programmer WHERE
'CLIPPER' not in (PROF1,PROF2) AND
'COBOL' not in (PROF1,PROF2) AND
'PASCAL' not in (PROF1,PROF2)

--30. Display the Cost of Package Developed By each Programmer. 
SELECT PNAME,SUM(DCOST) AS TOTAL_DCOST FROM software group by PNAME

--31. Display the sales values of the Packages Developed by the each Programmer. 
SELECT PNAME, sum(scost*sold) from software group by pname 

--32. Display the Number of Packages sold by Each Programmer.
select pname, sum(sold) as total_sold from software group by PNAME

--33. Display the sales cost of the packages Developed by each Programmer Language wise. 
select developin, sum(scost) as SALES_COST from software group by DEVELOPIN

--34. Display each language name with AVG Development Cost, AVG Selling Cost and
--AVG Price per Copy. 
SELECT DEVELOPIN, AVG(DCOST) as average_development_cost, AVG(scost) as avg_selling_cost,
IIF (sum(sold)<>0,sum(scost)/sum(sold),0) as price_per_copy
from software group by DEVELOPIN

--35. Display each programmer’s name, costliest and cheapest Packages Developed by him or 
--her. 
SELECT PNAME, MAX(DCOST) AS costliest, MIN(DCOST) AS cheapest from software group by PNAME

--36. Display each institute name with number of Courses, Average Cost per Course.
select Institute, count(course) as no_of_course, Avg(course_fee) as avg_fee from studies group by INSTITUTE

--37. Display each institute Name with Number of Students.
select Institute, count(PNAME) as no_of_students from studies group by INSTITUTE

--38. Display Names of Male and Female Programmers. Gender also. 
select PNAME, GENDER from programmer group by GENDER, PNAME
--or

--39. Display the Name of Programmers and Their Packages. 
select PNAME,TITLE FROM software GROUP BY PNAME, TITLE

--40. Display the Number of Packages in Each Language Except C and C++.
SELECT DEVELOPIN, COUNT(TITLE) as no_of_package FROM software
where DEVELOPIN not in ('c','cpp')
group by Developin

--41. Display the Number of Packages in Each Language for which Development Cost is
--less than 1000.
select developin, COUNT(TITLE) AS PAKAGES, sum(DCOST) AS DEVELOPMENT_COST FROM software WHERE  DCOST <1000 GROUP BY DEVELOPIN

--42. Display AVG Difference between SCOST, DCOST for Each Package. 
SELECT TITLE, AVG (DCOST) as avg_dcost, avg(SCOST) as avg_scost, 
avg (dcost)-avg(scost) as avg_per_pakages from software 
group by title 

--OR
SELECT TITLE, avg (dcost)-avg(scost) as avg_per_pakages from software 
group by title 

-- 43. Display the total SCOST, DCOST and amount to Be Recovered for each 
--Programmer for Those Whose Cost has not yet been Recovered.
SELECT PNAME, SUM(DCOST) as Total_Dcost, Sum(scost*sold) as Total_Scost,
SUM(SCOST*SOLD)-SUM(DCOST) AS Difference_in_Cost
from software group by PNAME
having sum(DCOST)>SUM(SCOST*SOLD)

--44. Display Highest, Lowest and Average Salaries for those earning more than 2000. 
SELECT MAX(SALARY) AS Highest_sal, MIN(SALARY) as Lowest_sal,AVG(SALARY) as AVG_sal FROM programmer
WHERE SALARY > 2000

--45. Who is the Highest Paid C Programmers? 
select TOP 1 * FROM programmer WHERE 'C' IN (PROF1,PROF2)
Order by salary desc
--or
select max(salary) from programmer where prof1 ='c' or prof2 ='c' 

--46. Who is the Highest Paid Female COBOL Programmer? 
/*select pname, max(salary) from programmer where 'cobol' in (prof1, prof2) and gender ='f' 
group by pname*/ --it shows two persons
--or
select TOP 1 * FROM programmer WHERE 'cobol' IN (PROF1,PROF2) and gender = 'f'

--47. Display the names of the highest paid programmers for each Language. 
create table #pls(PROF VARCHAR(20),SAL INT)

INSERT INTO #PLS
SELECT PROF1, MAX(SALARY) AS HEIGH_SAL FROM programmer GROUP BY PROF1

INSERT INTO #PLS
SELECT PROF2, MAX(SALARY) AS HEIGH_SAL FROM programmer GROUP BY PROF2

CREATE TABLE #PLSMAX (PROF VARCHAR(20), SAL INT)

INSERT INTO #PLSMAX
SELECT PROF,MAX(SAL) FROM #PLS GROUP BY PROF

SELECT PNAME, PROF, SAL FROM programmer
INNER JOIN #PLSMAX
ON
PROF=PROF1 OR PROF =PROF2
WHERE SAL = SALARY
ORDER BY PROF

--48. Who is the least experienced Programmer. 
SELECT PNAME , DATEDIFF(YY,DOJ,GETDATE()) AS EXPERIENCE FROM programmer
WHERE DATEDIFF(YY,DOJ,GETDATE()) = (SELECT MIN(DATEDIFF(YY,DOJ,GETDATE())) FROM PROGRAMMER)

--OR
SELECT MIN(DATEDIFF(YY,DOJ,GETDATE()))AS EXPERIENCE FROM PROGRAMMER

--49. Who is the most experienced male programmer knowing PASCAL.
SELECT PNAME, MAX(DATEDIFF(YY,DOJ,GETDATE()))AS EXPERIENCE FROM PROGRAMMER WHERE
'PASCAL' in (PROF1,PROF2) and gender = 'M'
group by pname

--50. Which Language is known by only one Programmer? 
SELECT PROF1 FROM PROGRAMMER GROUP BY PROF1 
HAVING PROF1 NOT IN (SELECT PROF2 FROM PROGRAMMER) AND COUNT(PROF1)=1 
UNION 
SELECT  PROF2 FROM PROGRAMMER GROUP BY PROF2 
HAVING PROF2 NOT IN (SELECT PROF1 FROM PROGRAMMER) AND COUNT(PROF2)=1;

--51. Who is the Above Programmer Referred in 50? 
select pname,datediff(yy,DOB,getdate()) as age from programmer 
where datediff(yy,DOB,getdate()) > 50

--52. Who is the Youngest Programmer knowing DBASE?
select pname, MIN(datediff(yy,DOB,getdate())) as Youngest_Programmer_knowing_DBASE 
from programmer WHERE (datediff(yy,DOB,getdate()) = (select min(datediff(yy,DOB,getdate())) 
from programmer)) AND 'DBASE' in (PROF1,PROF2) 
group by pname

/*53. Which Female Programmer earning more than 3000 does not know C, C++, 
ORACLE or DBASE? */
select pname,salary from programmer WHERE (
PROF1 not in ('DBASE','ORACLE','C','CPP') AND
PROF2 not in ('DBASE','ORACLE','C','CPP')) AND GENDER ='F'
group by pname,SALARY
HAVING SALARY > 3000

--54. Which Institute has most number of Students?
SELECT TOP 1 institute, COUNT(INSTITUTE) AS most_number_of_Students FROM studies
GROUP BY institute
order by most_number_of_Students desc
--OR
SELECT top 1 institute,COUNT(INSTITUTE) AS most_number_of_Students FROM studies  
GROUP BY institute order by 2 desc

-- 55. What is the Costliest course?
SELECT TOP 1 institute,course,pname, max(course_fee) AS Costliest_course FROM studies
GROUP BY course_fee,institute,course,pname
order by Costliest_course desc

--56. Which course has been done by the most of the Students? 

SELECT top 2 course,count(course) AS course_done_by_most_of_the_Students FROM studies
GROUP BY course
order by course_done_by_most_of_the_Students desc
--or
SELECT  course,count(course) AS course_done_by_most_of_the_Students FROM studies
GROUP BY course
order by course_done_by_most_of_the_Students desc

select* from studies

--57. Which Institute conducts costliest course.

SELECT top 1 institute, max(course_fee) AS costliest_course FROM studies
GROUP BY institute
order by costliest_course desc
--or
SELECT  institute, max(course_fee) AS costliest_course FROM studies
GROUP BY institute
order by costliest_course desc

--58. Display the name of the Institute and Course, which has below AVG course fee.

SELECT  institute,course, avg (course_fee) AS below_AVG_course_fee FROM studies
where course_fee < (select avg(course_fee)from studies)
GROUP BY institute,course
order by below_AVG_course_fee desc;
--refer avg course fee
SELECT avg (course_fee) AS below_AVG_course_fee FROM studies

--59. Display the names of the courses whose fees are within 1000 (+ or -) of the Average Fee,
SELECT  pname,institute,course, avg (course_fee) AS plus1000_and_minus1000_of_Average_Fee FROM studies
where course_fee < (1000 + (select avg(course_fee)from studies)) and 
 course_fee > ((select avg(course_fee)from studies)-1000)
GROUP BY pname, institute,course

--60. Which package has the Highest Development cost? 
SELECT top 1 PNAME,DEVELOPIN, max(dcost) AS Highest_Development_cost FROM software
GROUP BY PNAME,DEVELOPIN
order by Highest_Development_cost desc;

select * from software

--61. Which course has below AVG number of Students? 

select  *  from studies 
where COURSE in (select s.COURSE from studies s group by s.COURSE having count(s.PNAME) < 
(select Avg(2) from 
(select COURSE,count(PNAME) as counts from studies
group by COURSE) as s ))

--or

create table #temp2
( Course_name varchar(20), student_name_count float);


insert into #temp2
select Course, count(PNAME) from studies group by course

select* from #temp2

select Course_name,Student_name_count from #TEMP2 
WHERE Student_name_count < (SELECT AVG(Student_name_count) FROM #TEMP2)





--62. Which Package has the lowest selling cost? 
select * from SOFTWARE WHERE SCOST= (SELECT min(SCOST ) as lowest_selling_cost FROM SOFTWARE)

--63. Who Developed the Package that has sold the least number of copies? 
select * from SOFTWARE WHERE SOLD = (SELECT min(SOLD ) as sold_least_number_of_copies FROM SOFTWARE)

--64. Which language has used to develop the package, which has the highest sales amount? 

SELECT TOP 1 Title,DEVELOPIN,MAX((scost+DCOST)*sold) AS highest_sales_amount, COUNT(DEVELOPIN) AS NUMBER_OF_PERSON_DEVELOPED_LANGAUGE FROM software
GROUP BY title, DEVELOPIN
ORDER BY highest_sales_amount DESC

 /*65. How many copies of package that has the least difference between 
development and selling cost where sold.*/ 

SELECT top 5 Title, pname,developin,sold, sum(dcost*sold)-sum(scost*sold)
as least_diff_between_dcost_and_scost_where_sold from software 
GROUP BY title, pname, DEVELOPIN, sold
ORDER BY least_diff_between_dcost_and_scost_where_sold asc


--66. Which is the costliest package developed in PASCAL. 

select top 1 Title, Developin, max(dcost) as Costliest_package_developed_in_Pascal  from software 
where  DEVELOPIN = 'PASCAL'
group by title, DEVELOPIN
order by costliest_package_developed_in_PASCAL desc


--67. Which language was used to develop the most number of Packages. 
select top 1 developin, count(Developin) as most_number_of_Packages from software
group by  DEVELOPIN
order by most_number_of_Packages desc

--68. Which programmer has developed the highest number of Packages?
select TOP 3 pname, count(pname) as highest_number_of_Packages from software
group by  pname
order by highest_number_of_Packages desc

--69. Who is the Author of the Costliest Package? 

SELECT TOP 1 PNAME, MAX(DCOST) AS Costliest_Package FROM SOFTWARE
group by  pname
ORDER BY Costliest_Package DESC

/*70. Display the names of the packages, which have sold less than the AVG 
number of copies.*/

SELECT AVG(SOLD) FROM SOFTWARE

select Title,sold as less_then_avg_no_of_copy_sold from software 
where sold < (select avg(sold) from software) 
order by less_then_avg_no_of_copy_sold desc

/*71. Who are the authors of the Packages, which have recovered more than double the 
Development cost?*/
SELECT Title, pname,developin,sum(2*dcost) as diuble_the_development_cost,
sum(sold*scost) AS package_more_then_double_the_Development_cost from software 
where SOLD*SCOST > 2*DCOST
GROUP BY title, pname, DEVELOPIN

--72. Display the programmer Name and the cheapest packages developed by them in each language. 
select PNAME,TITLE,DEVELOPIN, DCOST from software
where dcost IN (select min(dcost) from software
group by developin)
order by DEVELOPIN desc;

/*73. Display the language used by each programmer to develop the Highest 
Selling and Lowest-selling package.*/

SELECT PNAME,DEVELOPIN, SOLD,DCOST FROM SOFTWARE 
WHERE SOLD IN (SELECT MAX(SOLD) FROM SOFTWARE GROUP BY DEVELOPIN)
UNION 
SELECT PNAME, DEVELOPIN,SOLD,DCOST FROM SOFTWARE 
WHERE SOLD IN (SELECT MIN(SOLD) FROM SOFTWARE GROUP BY DEVELOPIN);

--74. Who is the youngest male Programmer born in 1965?
select PNAME, DOB as youngest_male_programmer_in_1965 from programmer
WHERE DOB= (SELECT MAX(DOB) FROM programmer WHERE YEAR(DOB) LIKE '1965' and gender ='m')
group by PNAME,DOB

--75. Who is the oldest Female Programmer who joined in 1992?
select PNAME, DOJ as oldest_Female_programmer_in_1992 from programmer
WHERE DOJ= (SELECT MIN(DOJ) FROM programmer WHERE YEAR(DOJ) LIKE '1992' and gender ='F')
group by PNAME,DOJ

--76. In which year was the most number of Programmers born. 
Select TOP 1 Year(DOB) AS Year, count(Year(DOB)) AS most_number_of_Programmers_born
from programmer group by Year(DOB)
ORDER BY most_number_of_Programmers_born DESC

--77. In which month did most number of programmers join? 
Select TOP 1 MONTH(DOJ) AS month, count(MONTH(DOJ)) AS most_number_of_Programmers_Join
from programmer group by month(DOJ)
ORDER BY most_number_of_Programmers_join DESC

--78. In which language are most of the programmer’s proficient
select *  from programmer
create table #temp
(Lnagauge varchar(20),Programmer_count int);

insert into #temp
select prof1,count (prof1) from programmer group by prof1
union all
select prof2,count (prof2) from programmer group by prof2

select * from #temp

create table #temp1
(Lnagauge varchar(20),Programmer_count int);

insert into #temp1
select Lnagauge, SUM(Programmer_count) FROM #TEMP group by Lnagauge

select * from #temp1

select Lnagauge, Programmer_count from #TEMP1 
WHERE Programmer_count =(SELECT MAX(Programmer_count) FROM #TEMP1)


/*79. Who are the male programmers earning below the AVG salary of
Female Programmers? */
SELECT PNAME, SALARY FROM programmer 
WHERE GENDER = 'M' AND SALARY <
(SELECT AVG(SALARY) FROM programmer WHERE GENDER ='F')
ORDER BY SALARY DESC

--80. Who are the Female Programmers earning more than the Highest Paid?
SELECT PNAME , SALARY FROM programmer 
WHERE SALARY > ( SELECT MAX(SALARY) FROM programmer WHERE GENDER = 'm')
GROUP BY PNAME, SALARY

--81. Which language has been stated as the proficiency by most of the Programmers? 
select*from programmer

create table #temp
(Lnagauge varchar(20),Programmer_count int);

insert into #temp
select prof1,count (prof1) from programmer group by prof1
union all
select prof2,count (prof2) from programmer group by prof2

select * from #temp

create table #temp1
(Lnagauge varchar(20),Programmer_count int);

insert into #temp1
select Lnagauge, SUM(Programmer_count) FROM #TEMP group by Lnagauge

select * from #temp1

select Lnagauge, Programmer_count from #TEMP1 
WHERE Programmer_count =(SELECT MAX(Programmer_count) FROM #TEMP1)


--82. Display the details of those who are drawing the same salary. 

select pname, salary from programmer where salary = any(select salary from programmer p 
group by salary having salary=p.salary and count(*)>1)
order by salary desc

--83. Display the details of the Software Developed by the Male Programmers Earning More than 3000/-. 
select * from programmer where salary > 3000 and gender = 'M'

--84. Display the details of the packages developed in Pascal by the Female Programmers. 
select * from programmer where prof1 ='pascal' and gender = 'f'
union all
select * from programmer where prof2 ='pascal' and gender = 'f'

--85. Display the details of the Programmers who joined before 1990. 
select* from programmer WHERE DOJ < '1990'

--86. Display the details of the Software Developed in C By female programmers of Pragathi. 
select * from programmer where prof1 ='C' and gender = 'f' and pname = 'Pragathi'
union all
select * from programmer where prof2 ='C' and gender = 'f' and pname = 'Pragathi'

--[Software Developed in C By female programmers]
select * from programmer where prof1 ='C' and gender = 'f' 
union all
select * from programmer where prof2 ='C' and gender = 'f' 

/*87. Display the number of packages, No. of Copies Sold and sales value of
each programmer institute wise.*/

Select st.institute,count(so.developin) as Developin, count(so.sold) AS sold, 
sum(so.sold*so.scost) as SUM_SOLD from software so inner join studies st  on st.pname = so.pname
where so.PNAME=st.PNAME group by st.INSTITUTE;

--or
Select studies.institute, count(software.developin), count(software.sold), 
sum(software.sold*software.scost) from software,studies 
where software.pname=studies.pname group by studies.institute;

/*88. Display the details of the software developed in DBASE by Male Programmers, who 
belong to the institute in which most number of Programmers studied.*/

select software.* from programmer,software,studies 
where programmer.pname=software.pname and software.pname=studies.pname 
and programmer.pname=studies.pname and gender='m' and developin='dbase' 
and INSTITUTE= (select INSTITUTE from studies group by INSTITUTE 
having count(INSTITUTE) =(select max(institute_count) as Max_institute_count from #temp5));

/*89. Display the details of the software Developed by the male programmers Born 
before 1965 and female programmers born after 1975. */	 
select * from programmer where YEAR(DOB) < '1965' AND Gender = 'm' 
union all
select * from programmer where YEAR(DOB) > '1975' AND Gender = 'f' 

/*90. Display the details of the software that has developed in the language which is
neither the first nor the second proficiency of the programmers.*/ 

select s.* from programmer p,software s 
where s.pname=p.pname and (developin <> prof1 and developin <> prof2);

--91. Display the details of the software developed by the male students of Sabhari. 
select st.pname,st.institute, so.developin, p.gender from studies st 
inner join software so ON st.pname = so.pname 
inner join programmer p on so.pname =p.pname where st.institute = 'SABHARI' and p.gender ='m'

--92. Display the names of the programmers who have not developed any packages.
select st.pname,so.pname,so.title from studies st 
left join software so on st.pname = so.pname where so. title is null

--93. What is the total cost of the Software developed by the programmers of Apple? 
select st.pname,st.institute,so.dcost from studies st 
inner join software so on st.pname = so.pname where st.institute = 'Apple'

--94. Who are the programmers who joined on the same day?
select pname, DOJ from programmer where DOJ = 
any(select DOJ from programmer p group by DOJ 
having DOJ=p.DOJ and count(*)>1);

-- 95. Who are the programmers who have the same Prof2? 
select pname, PROF2 from programmer where PROF2 = 
any(select PROF2 from programmer p group by PROF2 
having PROF2=p.PROF2 and count(*)>1) order by prof2 asc;

--96. Display the total sales value of the software, institute wise. 
select st.institute,sum(so.sold*so.scost) as Total_Sales_value from software so,studies st
where st.pname=so.pname group by st.institute;

--97. In which institute does the person who developed the costliest package studied. 
select top 1 st.institute,max(so.dcost) as costliest_package from software so,studies st
where st.pname=so.pname group by st.institute 
order by costliest_package desc;

--98. Which language listed in prof1, prof2 has not been used to develop any package.
select prof1 from programmer where prof1 not in(select developin from software) 
union 
select prof2 from programmer where prof2 not in(select developin from software);

/*99. How much does the person who developed the highest selling package earn and
what course did HE/SHE undergo.*/
select p.salary,st.course from programmer p,software so,studies st 
where p.pname=so.pname and so.pname=st.pname and 
scost=(select max(scost) from software);

--100. What is the AVG salary for those whose software sales is more than 50,000/-. 
select avg(salary) as AVG_Salary from programmer p,software s 
where p .pname=s.pname and sold*scost>50000;

/*101. How many packages were developed by students, who studied in institute that 
charge the lowest course fee? */
select s.pname,count(s.pname) as No_of_Packages from software s,studies st 
where s.pname=st.pname group by s.pname
having min(COURSE_FEE)=(select min(COURSE_FEE) from studies);

/*102. How many packages were developed by the person who developed the 
cheapest package, where did HE/SHE study?*/
select s.developin,count(*) as No_of_Pakage_Developed from programmer p,software s
where s .pname=p.pname group by developin
having min(dcost)=(select min(dcost) from software)

select st.pname,st.institute,so.dcost from studies st 
inner join software so on st.pname = so.pname
where dcost = (select min(dcost) from software)

/*103. How many packages were developed by the female programmers earning more 
than the highest paid male programmer?*/
select count(developin) as No_of_Pakage_Developed from programmer p,software s 
where s.pname=p.pname and gender='f' and 
salary>(select max(salary) from programmer p,software s 
where s.pname=p.pname and gender='m');
--or
select s.developin,count(developin) as No_of_Pakage_Developed from programmer p,software s 
where s.pname=p.pname and gender='f' and 
salary>(select max(salary) from programmer p,software s 
where s.pname=p.pname and gender='m')group by s.developin;

--104. How many packages are developed by the most experienced programmer form BDPS.

select min(doj) from programmer
select pname, count(developin) as No_of_pakage from software 
where pname ='JULIANA' or pname= 'REMITHA' or pname = 'VIJAYA'
group by pname
select pname, institute from studies where institute = 'BDPS'

select st.pname, count(developin) from software so, studies st 
where st.pname = (select pname from studies where institute = 'BDPS'  = (select min(doj)from programmer)
group by st.pname


--105. List the programmers (form the software table) and the institutes they studied.
select s.pname, st.institute, count(developin) as No_of_software_Developied 
from software s, studies st where st.pname=s.pname group by s.pname,st.institute;

/*106. List each PROF with the number of Programmers having that PROF and the 
number of the packages in that PROF.*/

select developin,count(*) as count_developin ,sum(scost*sold-dcost) "PROFIT" from software 
where developin in (select prof1 from programmer) group by developin;

/*107. List the programmer names (from the programmer table) and No. Of Packages 
each has developed. */
select s.Pname,count(Developin) as No_of_Packages_Developied  from programmer p1,software s 
where p1.Pname=s.Pname group by s.Pname;


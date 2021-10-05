CREATE TABLE EMPLOYEE
(
SSN INT,
ENAME VARCHAR(40) NOT NULL,
DESIGN VARCHAR(20),
DNO INT,
DOJ DATE,
SALARY INT,PRIMARY KEY (SSN)
);
CREATE TABLE DEPARTMENT
(DNUMBER INT,
DNAME VARCHAR(20),
LOC VARCHAR(40),
MGRSSN INT REFERENCES EMPLOYEE(SSN),
PRIMARY KEY(DNUMBER)
);
 CREATE TABLE PROJECT
(
PNUMBER INT,
PNAME VARCHAR(15),
DNUM INT,
FOREIGN KEY(DNUM) REFERENCES DEPARTMENT(DNUMBER),
PRIMARY KEY(PNUMBER)
);
 CREATE TABLE WORK_IN
(
ESSN INT,
PNO INT,
HOURS INT,
FOREIGN KEY (ESSN)
REFERENCES EMPLOYEE(SSN),
FOREIGN KEY (PNO) REFERENCES PROJECT(PNUMBER),
FOREIGN KEY (HOURS) REFERENCES DEPARTMENT(DNUMBER)
);
DESCRIBE EMPLOYEE;
DESCRIBE DEPARTMENT;
DESCRIBE PROJECT;
DESCRIBE WORK_IN;
INSERT INTO EMPLOYEE(SSN,ENAME,DESIGN,DNO,DOJ,SALARY)VALUES(1,'Abhi','HR',2,'2009-04-12',70000 ),
(2,'bhama','admin',1,'2008-03-10',75000 ),(3,'chriz','sales',3,'2015-06-23',35000 ),
(4,'diya','production',5,'2015-07-21',32000 ),(5,'govind','production',5,'2015-09-12',35000 ),
(6,'hima','finance',4,'2013-01-19',51000 ),(7,'ira','hr',2,'2010-03-15',45000 ),
(8,'sandeep','finance',4,'2010-07-26',49000 );
SELECT * FROM EMPLOYEE;
INSERT INTO DEPARTMENT(DNUMBER,DNAME,LOC)VALUES(1,'Admin','Chennai'),(2,'HR','Banglore'),
(3,'Sales','Kochi'),(4,'Finance','Delhi'),(5,'Production','Trivandrum');
SELECT * FROM DEPARTMENT;
INSERT INTO PROJECT(PNUMBER,PNAME,DNUM)VALUES(11,'Bancs',3),(12,'Nielesan',5),
(13,'WorldBank',1),(14,'Airlines',2),(15,'Amex',4);
SELECT * FROM PROJECT;
INSERT INTO WORK_IN(ESSN,PNO,HOURS)VALUES(1,14,NULL),(4,13,NULL),(8,12,NULL),
(6,15,NULL),(2,11,NULL),(3,13,NULL);
SELECT * FROM WORK_IN;
SELECT e.ENAME FROM EMPLOYEE e LEFT OUTER JOIN DEPARTMENT d on d.DNUMBER=e.DNO
WHERE e.SALARY BETWEEN 30000 AND 40000 AND d.DNUMBER=5;
SELECT e.ENAME,d.DNAME FROM EMPLOYEE e LEFT OUTER JOIN DEPARTMENT d on e.DNO=d.DNUMBER
ORDER BY d.DNAME ASC,e.ENAME ASC;
SELECT p.PNUMBER,p.PNAME,count(e.SSN) FROM WORK_IN w LEFT OUTER JOIN PROJECT p on
w.PNO=p.PNUMBER LEFT OUTER JOIN EMPLOYEE e on w.ESSN=e.SSN GROUP BY
p.PNAME,p.PNUMBER;
SELECT p.PNUMBER,p.PNAME,count(e.SSN) FROM WORK_IN w LEFT OUTER JOIN PROJECT p on
w.PNO=p.PNUMBER LEFT OUTER JOIN EMPLOYEE e on w.ESSN=e.SSN GROUP BY
p.PNAME,p.PNUMBER HAVING count(e.SSN) > 2;
SELECT p.PNUMBER,p.PNAME,d.DNUMBER,count(e.ssn) FROM PROJECT p LEFT OUTER JOIN
DEPARTMENT d on d.DNUMBER=p.DNUM LEFT OUTER JOIN EMPLOYEE e on e.DNO=p.DNUM
GROUP BY p.PNAME,p.PNUMBER,d.DNUMBER HAVING d.DNUMBER=5;
SELECT d.DNAME,d.DNUMBER,e.SSN,e.ENAME,e.DESIGN,e.DOJ,e.SALARY FROM DEPARTMENT d,EMPLOYEE e WHERE  (SELECT COUNT(*) FROM EMPLOYEE e WHERE e.DNO = d.DNUMBER 
AND e.SALARY> 40000) > 4 AND 
e.DNO=d.DNUMBER GROUP BY d.DNAME,d.DNUMBER,e.SSN,e.ENAME,e.DESIGN,e.DOJ,e.SALARY; 
Select * From EMPLOYEE e,DEPARTMENT d WHERE e.dno=d.dnumber;
SELECT * FROM EMPLOYEE e,DEPARTMENT d WHERE NOT(e.dno=d.dnumber);
SELECT * FROM EMPLOYEE e LEFT OUTER JOIN DEPARTMENT d ON e.dno=d.dnumber; 
SELECT * FROM EMPLOYEE e RIGHT OUTER JOIN DEPARTMENT d ON e.dno=d.dnumber;
SELECT * FROM EMPLOYEE e INNER JOIN DEPARTMENT d ON e.dno=d.dnumber;
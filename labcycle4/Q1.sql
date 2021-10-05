CREATE TABLE BRANCH
(
BID INT,
BRANCH_NAME VARCHAR(25),
BRANCH_CITY VARCHAR(25),
ASSETS INT
);
CREATE TABLE ACCOUNTS
(
ACCNO INT,
BID INT,
BALANCE INT
);
CREATE TABLE DEPOSITOR
(
CID INT,
ACCNO INT
);
CREATE TABLE CUSTOMER
(
CID INT,
CUSTOMER_NAME VARCHAR(25),
CUSTOMER_STREET VARCHAR(25),
CUSTOMER_CITY VARCHAR(25)
);
ALTER TABLE BRANCH ADD PRIMARY KEY (BID);
ALTER TABLE ACCOUNTS ADD PRIMARY KEY (ACCNO);
ALTER TABLE CUSTOMER ADD PRIMARY KEY (CID);

ALTER TABLE ACCOUNTS ADD FOREIGN KEY (BID) REFERENCES BRANCH(BID);
ALTER TABLE DEPOSITOR ADD FOREIGN KEY (CID) REFERENCES CUSTOMER(CID);
ALTER TABLE DEPOSITOR ADD FOREIGN KEY (ACCNO) REFERENCES ACCOUNTS(ACCNO);

INSERT INTO BRANCH(BID,BRANCH_NAME,BRANCH_CITY,ASSETS) VALUES
(1,'MAIN','C1',10000),
(2,'B2','C2',20000),
(3,'B3','C3',30000),
(4,'B4','C4',40000),
(5,'B5','C5',50000);
SELECT * FROM BRANCH;

INSERT INTO ACCOUNTS(ACCNO,BID,BALANCE) VALUES
(101,'1',1000),
(102,'1',2000),
(103,'1',3000),
(104,'2',4000),
(105,'2',5000),
(106,'3',4000),
(107,'3',3000),
(108,'4',2000),
(109,'4',3000),
(110,'5',2000),
(111,'5',10000);
SELECT * FROM ACCOUNTS;


INSERT INTO CUSTOMER(CID,CUSTOMER_NAME,CUSTOMER_STREET,CUSTOMER_CITY) VALUES
(11,'CUST1','S1','CITY1'),
(22,'CUST2','S2','CITY2'),
(33,'CUST3','S3','CITY3'),
(44,'CUST4','S4','CITY4'),
(55,'CUST5','S4','CITY5');
SELECT * FROM CUSTOMER;

INSERT INTO DEPOSITOR(CID,ACCNO) VALUES
(11,101),
(22,102),
(11,103),
(33,104),
(11,105),
(44,106),
(11,107),
(55,108),
(11,109),
(44,110),
(55,111);
SELECT * FROM DEPOSITOR;

SELECT CUSTOMER.CID,CUSTOMER_NAME,BRANCH_NAME FROM BRANCH,CUSTOMER,DEPOSITOR,ACCOUNTS WHERE CUSTOMER.CID=DEPOSITOR.CID AND DEPOSITOR.ACCNO=ACCOUNTS.ACCNO AND ACCOUNTS.BID=1 
GROUP BY ACCOUNTS.BID HAVING COUNT(ACCOUNTS.BID)>=2;

SELECT CUSTOMER.CID,CUSTOMER_NAME,ACCOUNTS.ACCNO,BRANCH_CITY FROM ACCOUNTS,BRANCH,DEPOSITOR,CUSTOMER WHERE BRANCH.BID=ACCOUNTS.BID AND ACCOUNTS.ACCNO=DEPOSITOR.ACCNO AND DEPOSITOR.CID=CUSTOMER.CID
AND BRANCH.BRANCH_CITY='C3'
GROUP BY DEPOSITOR.CID HAVING COUNT(DISTINCT BRANCH.BID)=(SELECT COUNT(BID) FROM BRANCH WHERE BRANCH_CITY='C3');

SELECT * FROM BRANCH WHERE ASSETS=(SELECT MAX(ASSETS) FROM BRANCH);

SELECT CUSTOMER.CID,CUSTOMER_NAME,ACCOUNTS.ACCNO,BALANCE FROM CUSTOMER,DEPOSITOR,ACCOUNTS 
WHERE CUSTOMER.CID=DEPOSITOR.CID AND DEPOSITOR.ACCNO=ACCOUNTS.ACCNO AND BALANCE=(SELECT MAX(BALANCE) FROM ACCOUNTS);
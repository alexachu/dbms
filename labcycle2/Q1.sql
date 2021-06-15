CREATE TABLE SAILORS
(
sid NUMERIC(2),
sname VARCHAR(10),
rating NUMERIC(2),
age NUMERIC(2)
);
INSERT INTO SAILORS VALUES(22, 'Dustin', 7, 45),(29, 'Brutas', 1, 33),(31, 'Lubber', 8, 55),(32, 'Andy', 8, 25),
(58, 'Rusty', 10, 35),(64, 'Horatio', 7, 35),(71, 'Zorba', 10, 16),(74, 'Horatio', 9, 35),(85, 'Art', 3, 26),
(95, 'Bob', 3, 64);
SELECT * FROM SAILORS;
CREATE TABLE BOATS
( 
Bid NUMERIC(3),
bname VARCHAR(10), 
color VARCHAR(7)
);
INSERT INTO BOATS VALUES(101, 'Interlake', 'Blue'),(102, 'Interlake', 'Red'),(103, 'Clipper', 'Green'),
(104, 'Marine', 'Red');
SELECT * FROM BOATS;
CREATE TABLE RESERVES
(
sid NUMERIC(2), 
bid NUMERIC(3), 
day DATE
);
INSERT INTO RESERVES VALUES
   (22, 101, '98-10-10'),
   (22, 102, '98-10-10'),
   (22, 103, '98-08-10'),
   (22, 104, '98-07-10'),
   (31, 102, '98-10-11'),
   (31, 103, '98-06-11'),
   (31, 104, '98-12-11'),
   (64, 101, '98-05-09'),
   (64, 102, '98-08-09'),
   (74, 103, '98-08-09');
SELECT * from RESERVES;
SELECT sname, age FROM sailors;
SELECT * FROM SAILORS,RESERVES WHERE sailors.sid = reserves.sid AND bid = 101;
SELECT sname FROM SAILORS WHERE rating > 7;
SELECT sname FROM SAILORS,RESERVES WHERE bid = 103 AND sailors.sid = reserves.sid;
SELECT DISTINCT sname FROM SAILORS,RESERVES,BOATS WHERE color = 'Red'AND 
boats.bid = reserves.bid AND sailors.sid = reserves.sid order by age;
SELECT DISTINCT sname FROM SAILORS,RESERVES,BOATS WHERE ( color = 'Red'OR color = 'Green') 
AND boats.bid = reserves.bid AND sailors.sid = reserves.sid;
SELECT DISTINCT color FROM SAILORS,RESERVES,BOATS 
WHERE sname = 'Lubber'AND boats.bid = reserves.bid AND sailors.sid = reserves.sid;
SELECT DISTINCT sname FROM SAILORS,RESERVES,BOATS WHERE color = 'Red'AND
boats.bid = reserves.bid AND sailors.sid = reserves.sid UNION
SELECT DISTINCT sname FROM SAILORS,RESERVES,BOATS WHERE color = 'Green' AND
boats.bid = reserves.bid AND sailors.sid = reserves.sid;
SELECT DISTINCT sname FROM SAILORS,RESERVES WHERE reserves.sid = sailors.sid;
SELECT sname,reserves.sid FROM RESERVES,SAILORS WHERE sailors.sid = reserves.sid 
GROUP BY DAY,reserves.sid,sname HAVING COUNT(DAY)>1 ;
SELECT sname,age FROM SAILORS WHERE age =(SELECT MIN(age) FROM sailors) ;
SELECT sname,rating FROM SAILORS WHERE rating >(SELECT MAX(rating) FROM SAILORS WHERE sname = 'Horatio');
SELECT sname FROM(SELECT sname,reserves.sid,COUNT(bid) AS id FROM RESERVES,SAILORS
WHERE reserves.sid = sailors.sid GROUP BY reserves.SID,sname) a WHERE id =( SELECT COUNT(bid) FROM BOATS);
SELECT COUNT(c.sname)FROM(SELECT DISTINCT sname FROM Sailors) c;
SELECT AVG(age) FROM SAILORS;
SELECT rating,AVG(age) FROM SAILORS GROUP BY rating;
SELECT a.rating,b.mean FROM(SELECT COUNT(sname) AS num,rating FROM SAILORS GROUP BY rating HAVING COUNT(sname)>1)a,
(SELECT rating,AVG(age) AS mean FROM SAILORS GROUP BY rating ) b WHERE a.rating = b.rating;
SHOW tables;

SELECT * FROM sales;

SELECT SaleDate, Amount, Customers FROM sales;

SELECT Customers, Amount, GeoID FROM sales;

SELECT Customers, Amount, Boxes, Amount/Boxes FROM sales;

SELECT Customers, Amount, Boxes, Amount/Boxes AS 'Amount per Box' FROM sales;

SELECT * FROM sales 
WHERE amount > 10000
ORDER BY amount DESC;

SELECT * FROM sales
WHERE GeoID='G1'
ORDER BY PID, Amount DESC;

SELECT * FROM sales
WHERE amount > 10000 and SaleDate >= '2022-01-01';

SELECT * FROM sales
WHERE amount > 10000 AND YEAR(SaleDate) = 2022
ORDER BY amount DESC;

SELECT * FROM sales
WHERE Boxes>0 AND Boxes < 50;

SELECT * FROM sales
WHERE Boxes BETWEEN 1 and 65;

SELECT SaleDate, Amount, Boxes, weekday(SaleDate) as 'Day of Week'
FROM sales
WHERE weekday(SaleDate)= 4
ORDER BY Amount DESC;

SELECT * FROM people
WHERE team = 'Delish' OR team = 'Juices';

SELECT * FROM people
WHERE team IN ('Delish', 'Juices');

SELECT * FROM people
WHERE Salesperson LIKE 'B%';

SELECT * FROM people
WHERE Salesperson LIKE '%C%';

SELECT SaleDate, Amount,
		CASE	WHEN Amount < 1000 THEN 'Under 1K'
				WHEN Amount < 5000 THEN 'Under 5K'
                WHEN Amount < 10000 THEN 'Under 10K'
			ELSE '10K or More'
		END AS 'Amount Category'
FROM sales;

SELECT s.saledate, s.amount, p.salesperson, s.SPID, p.SPID
FROM sales s
JOIN people p ON p.SPID = s.SPID;

SELECT s.saledate, s.amount, pr.product
FROM sales s
LEFT JOIN products pr ON pr.pid = s.pid;

SELECT s.saledate, s.amount, p.salesperson, pr.product, p.team
FROM sales s
JOIN people p ON p.SPID = s.SPID
JOIN geo g ON g.geoid = s.geoid
JOIN products pr ON pr.pid = s.pid
WHERE s.amount <1000
AND p.team = 'Delish'
AND g.Geo IN ('New Zealand', 'India')
ORDER BY saledate;

SELECT geoID, sum(Amount), avg(amount), sum(boxes)
FROM sales
GROUP BY geoID;

SELECT g.geo, sum(Amount), avg(amount), sum(boxes)
FROM sales s
JOIN geo g ON s.geoID = g.geoID
GROUP BY g.geo;

SELECT pr.category, p.team, sum(boxes), sum(amount)
FROM sales s
JOIN people p ON p.spid = s.spid
JOIN products pr ON pr.pid = s.pid
GROUP BY pr.category, p.team
ORDER BY pr.category, p.team;

SELECT pr.Product, sum(s.amount) AS 'Total Amount'
FROM sales s
JOIN products pr ON pr.pid = s.pid
GROUP BY pr.Product
ORDER BY 'Total Amount' DESC
LIMIT 10;
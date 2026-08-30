#insert data
CREATE TABLE online_retail_2009_2010 (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate VARCHAR(30),
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100)
);

LOAD DATA LOCAL INFILE 'D:\2010_2011.csv'
INTO TABLE online_retail_2010_2011
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE online_retail_2010_2011 (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate VARCHAR(30),
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100)
);
CREATE TABLE online_retail_full AS
SELECT * FROM online_retail_2009_2010
UNION ALL
SELECT * FROM online_retail_2010_2011;

#------------------------------------------------------------------------
#remove duplicates

WITH RankedTransactions AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY InvoiceNo, StockCode, Quantity, InvoiceDate, UnitPrice, CustomerID,country
               ORDER BY InvoiceDate
           ) AS row_num
    FROM online_retail_full
)
-- Delete or filter out row_num > 1 (the extra duplicate copies) (34337 duplicates row)
SELECT InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID,country,row_num
FROM RankedTransactions
WHERE row_num > 1;
 
CREATE TABLE online_retail_clean (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate VARCHAR(30),
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100),
    row_num int
);


insert into online_retail_clean
select *,  ROW_NUMBER() OVER(
               PARTITION BY InvoiceNo, StockCode, Description ,Quantity, InvoiceDate, UnitPrice, CustomerID,country
               ORDER BY InvoiceDate
           ) AS row_num
from online_retail_full; 

select count(*)from online_retail_clean
where row_num>1;

SELECT *
FROM online_retail_clean
WHERE row_num > 1
LIMIT 20;

DELETE FROM online_retail_clean
WHERE row_num > 1;

ALTER TABLE online_retail_clean DROP COLUMN row_num;
###########################################################
#cheking for nulls and blanks
SELECT
    COUNT(*) AS total_rows,
    SUM(InvoiceNo IS NULL) AS InvoiceNo_nulls,

    SUM(StockCode IS NULL) AS StockCode_nulls,

    SUM(Description IS NULL) AS Description_nulls,

    SUM(Quantity IS NULL) AS Quantity_nulls,

    SUM(InvoiceDate IS NULL) AS InvoiceDate_nulls,
    ROUND(SUM(InvoiceDate IS NULL) / COUNT(*) * 100, 2) AS InvoiceDate_null_pct,

    SUM(UnitPrice IS NULL) AS UnitPrice_nulls,
    ROUND(SUM(UnitPrice IS NULL) / COUNT(*) * 100, 2) AS UnitPrice_null_pct,

    SUM(CustomerID IS NULL) AS CustomerID_nulls,

    SUM(Country IS NULL) AS Country_nulls

 FROM online_retail_clean;
################################################
SELECT
    SUM(InvoiceNo = '') AS InvoiceNo_blanks,
    SUM(StockCode = '') AS StockCode_blanks,
    SUM(`Description` = '') AS Description_blanks,
    SUM(Quantity = 0) AS Quantity_blanks,
    SUM(InvoiceDate = '') AS InvoiceDate_blanks,
    SUM(UnitPrice = '') AS UnitPrice_blanks,
    SUM(CustomerID = '') AS CustomerID_blanks,
    SUM(Country = '') AS Country_blanks
FROM online_retail_clean;

select count(distinct StockCode) from online_retail_clean; #before it was 5132 unique code after cleaning it becomes 4186 unuseful once

SELECT
    InvoiceNo,
    StockCode,
    `Description`,
    Quantity,
    UnitPrice,
    CustomerID,
    InvoiceDate
FROM online_retail_clean
WHERE Quantity < 0
AND UnitPrice = 0
AND CustomerID = 0
AND `Description` = ''
 ;
 
 
 SELECT COUNT(*)
FROM online_retail_clean
WHERE Quantity < 0
  AND UnitPrice = 0
  AND CustomerID = 0
  AND `Description` = '';
  
  DELETE FROM online_retail_clean
WHERE Quantity < 0
  AND UnitPrice = 0
  AND (CustomerID = 0 OR CustomerID IS NULL)
  AND (Description = '' OR Description IS NULL);
  
  SELECT COUNT(*)
FROM online_retail_clean
WHERE Quantity < 0
  AND UnitPrice = 0
  AND (CustomerID = 0 OR CustomerID IS NULL)
  AND ( Description = '' OR Description IS NULL);
-- Expected output: 0


select* from online_retail_clean
where UnitPrice=0
and Description='';


DELETE FROM online_retail_clean
WHERE Description =''
AND UnitPrice = 0;
  
select* from online_retail_clean
where UnitPrice=0
and Quantity<0

; 

DELETE FROM online_retail_clean
WHERE Quantity <0
AND UnitPrice = 0;

select * from online_retail_clean
where UnitPrice=0
order by Description;

DELETE FROM online_retail_clean
where UnitPrice=0
and CustomerID=0;

select * from online_retail_clean
where StockCode='22167'
;

DELETE FROM online_retail_clean
where StockCode like 'ADJUST';


SELECT 
    target.InvoiceNo,
    target.StockCode,
    target.UnitPrice AS old_price,
    source.calculated_price AS new_price
    
FROM online_retail_clean target
JOIN (
    SELECT 
        StockCode,
        ROUND(AVG(UnitPrice), 2) AS calculated_price
    FROM online_retail_clean
    WHERE UnitPrice > 0
    GROUP BY StockCode
) source
    ON target.StockCode = source.StockCode
WHERE target.UnitPrice = 0;


UPDATE online_retail_clean target
JOIN (
    SELECT 
        StockCode,
        ROUND(AVG(UnitPrice), 2) AS calculated_price
    FROM online_retail_clean
    WHERE UnitPrice > 0
    GROUP BY StockCode
) source 
    ON target.StockCode = source.StockCode
SET target.UnitPrice = source.calculated_price
WHERE target.UnitPrice = 0;
###############################################
#trim
UPDATE online_retail_clean
SET
    StockCode = TRIM(StockCode),
    Description = TRIM(Description),
    Country = TRIM(Country),
    InvoiceNo= trim(InvoiceNo);
####################################
#standrize text
SELECT
    StockCode,
    GROUP_CONCAT(
        DISTINCT Description
        ORDER BY Description
        SEPARATOR ' || '
    ) AS different_descriptions
FROM online_retail_clean
WHERE Description IS NOT NULL
GROUP BY StockCode
HAVING COUNT(DISTINCT Description) > 1
ORDER BY StockCode;

select count(*)from online_retail_clean;

SELECT COUNT(*) AS cancelled_rows
FROM online_retail_clean
WHERE InvoiceNo LIKE 'C%';

SELECT
    StockCode,
    Description,
    COUNT(*) AS rows_count
FROM online_retail_clean
WHERE StockCode IN ('POST', 'D', 'M', 'BANK CHARGES')
GROUP BY StockCode, Description
ORDER BY rows_count DESC;

delete from online_retail_clean
where StockCode='D';


#########################################
#date fix

ALTER TABLE online_retail_clean
ADD COLUMN InvoiceDate_New DATETIME;

UPDATE online_retail_clean
SET InvoiceDate_New =
    STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i');
SELECT
    MIN(InvoiceDate_New) AS earliest_date,
    MAX(InvoiceDate_New) AS latest_date
FROM online_retail_clean;

SELECT
    InvoiceDate,
    InvoiceDate_New
FROM online_retail_clean
LIMIT 20;

ALTER TABLE online_retail_clean
DROP COLUMN InvoiceDate;

ALTER TABLE online_retail_clean
RENAME COLUMN InvoiceDate_New TO InvoiceDate;

select * from online_retail_clean;

delete  FROM online_retail_clean
WHERE 
 StockCode NOT REGEXP '^[0-9]{5}';
 
 select * from online_retail_clean
 where Quantity <0;
 

select * from online_retail_clean
where CustomerID= 16446;

SELECT DISTINCT StockCode
FROM online_retail_clean r
WHERE YEAR(InvoiceDate) = 2011
  AND NOT EXISTS (
      SELECT 1
      FROM online_retail_clean r2
      WHERE r2.StockCode = r.StockCode
        AND YEAR(r2.InvoiceDate) = 2010
  );
  
  
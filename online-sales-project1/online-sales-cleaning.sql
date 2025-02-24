-- DATA CLEANING

-- Retrieve all records from the transactions table
SELECT *
FROM transactions;

-- Show the duplicate rows
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY `Transaction ID`, `Date`, `Product Category`, `Product Name`, `Units Sold`,
                 `Unit Price`, `Total Revenue`, `Region`, `Payment Method`
) AS rownumber
FROM transactions;

-- Show the duplicate rows with a CTE
WITH duplicate_cte AS (
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY `Transaction ID`, `Date`, `Product Category`, `Product Name`, `Units Sold`,
                     `Unit Price`, `Total Revenue`, `Region`, `Payment Method`
    ) AS rownumber
    FROM transactions
)
SELECT *
FROM duplicate_cte
WHERE rownumber > 1;

-- Create a new table with the rownumber column so we can work with it
CREATE TABLE `transactions_2` (
  `Transaction ID` DOUBLE DEFAULT NULL,
  `Date` TEXT,
  `Product Category` TEXT,
  `Product Name` TEXT,
  `Units Sold` INT DEFAULT NULL,
  `Unit Price` DOUBLE DEFAULT NULL,
  `Total Revenue` TEXT,
  `Region` TEXT,
  `Payment Method` TEXT,
  `rownumber` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert the values into the new table
INSERT INTO transactions_2
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY `Transaction ID`, `Date`, `Product Category`, `Product Name`, `Units Sold`,
                 `Unit Price`, `Total Revenue`, `Region`, `Payment Method`
) AS rownumber
FROM transactions;

-- Delete the duplicate rows
DELETE 
FROM transactions_2
WHERE rownumber > 1;

-- Verify the new table without duplicates
SELECT * 
FROM transactions_2;

-- Convert negative values in units sold into positive values
UPDATE transactions_2
SET `Units Sold` = ABS(`Units Sold`)
WHERE `Units Sold` < 0;

-- Remove white spaces from the product category column 
UPDATE transactions_2
SET `Product Category` = TRIM(`Product Category`);

-- Modify the Transaction ID column
ALTER TABLE transactions_2
MODIFY COLUMN `Transaction ID` INT;

-- Clean the Date column
UPDATE transactions_2 
SET `Date` = NULL
WHERE `Date` = '';

ALTER TABLE transactions_2
MODIFY COLUMN `Date` DATE;

UPDATE transactions_2
SET `Date` = STR_TO_DATE(`Date`, '%Y-%m-%d')
WHERE `Date` IS NOT NULL;

UPDATE transactions_2 
SET `Date` = '2024-01-05'
WHERE `Date` IS NULL;

-- Clean the Total Revenue column
UPDATE transactions_2 
SET `Total Revenue` = NULL
WHERE `Total Revenue` = '';

ALTER TABLE transactions_2
MODIFY COLUMN `Total Revenue` DECIMAL (10, 2);

UPDATE transactions_2
SET `Total Revenue` = ROUND(`Unit Price` * `Units Sold`, 2);

-- Drop the rownumber column as it is no longer needed
ALTER TABLE transactions_2
DROP COLUMN `rownumber`;

-- Final adjustments
-- This could have been done earlier when creating the new table transactions_2
ALTER TABLE transactions_2
CHANGE COLUMN `Transaction ID` `transaction_id` INT,
CHANGE COLUMN `Date` `date` DATE,
CHANGE COLUMN `Product Category` `product_category` VARCHAR(100),
CHANGE COLUMN `Product Name` `product_name` VARCHAR(100),
CHANGE COLUMN `Units Sold` `units_sold` INT,
CHANGE COLUMN `Unit Price` `unit_price` DECIMAL (10, 2),
CHANGE COLUMN `Total Revenue` `total_revenue` DECIMAL (10, 2),
CHANGE COLUMN `Region` `region` VARCHAR(50),
CHANGE COLUMN `Payment Method` `payment_method` VARCHAR(50);







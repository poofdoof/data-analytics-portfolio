-- Data Cleaning

Select *
from layoffs
order by 1;

-- Always create a staging data to act on and have the raw data safe with you. 

# Data cleaning Steps as an DA
-- 1. Remove Duplicates
-- 2. Standardize data
-- 3. remove NULL or blank values
-- 4. remove unecessary columns rows where needed 

CREATE Table layoffs_staging
LIKE layoffs;

Insert into layoffs_staging
Select *
from layoffs;

Select *
from layoffs_staging
where company = 'Airbnb'
Order by 1;

Select *
from layoffs_staging2
Order by 1;

-- Using row_num partition by here to find the row which has value more than one to sort it out. 

Select *, row_number () OVER 
(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

-- Using CTE (Common table expression) for easy data cleaning, can also use Temp table or subquery but CTE is better

WITH Duplicate_CTE AS
(
Select *, row_number () OVER 
(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
Select *
from Duplicate_CTE
where row_num > 1;

Select *
from layoffs_staging
where company = 'Cazoo';

-- to remove the duplicate data from table we can use Update-DELETE statement or create a new table and do it in that

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select *
from layoffs_staging2;

Insert Into layoffs_staging2
Select *, row_number () OVER 
(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

Delete from layoffs_staging2
where row_num > 1;
 
-- Now that data is cleaned and there is no duplicate value we will standardize the data 

Select Distinct Company, Trim(Company) as company
from layoffs_staging2;

Update layoffs_staging2
SET Company = company;

Select *
from layoffs_staging2
Where industry like 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
Where industry like 'Crypto%';

Select Distinct industry
from layoffs_staging2
Order by 1;

Select distinct Location
from layoffs_staging2
Order by 1;

Select *
from layoffs_staging2
Where country like 'United States%';

Select distinct Country
from layoffs_staging2
Order by 1;

Select Distinct country, TRIM(Trailing '.' from country)
from layoffs_staging2
order by 1;	

Update layoffs_staging2
SET country = TRIM(Trailing '.' from country)
Where country LIKE 'United States%';

-- now updating date and time

Select `date`
from layoffs_staging2;

Select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

Update layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

Alter table layoffs_staging2
MODIFY COLUMN `date` Date;

-- Removing NULL and Black spaces

Select distinct *
from layoffs_staging2
where industry is NULL OR industry = '';

Select *
from layoffs_staging2
where industry is NULL OR industry = ''
Order by 1;

Select * from layoffs_staging2
where company = 'Airbnb';

Update layoffs_staging2
SET industry = null
where industry = '';

Select t1.industry, t2.industry
from layoffs_staging2 as t1
JOIN layoffs_staging2 as t2
	ON t1.company = t2.company
	Where t1.industry is NULL
    and t2.industry is not NULL;
    
Update layoffs_staging2 as t1
JOIN layoffs_staging2 as t2
	ON t1.company = t2.company
    SET t1.industry = t2.industry
	Where t1.industry is NULL
    and t2.industry is not NULL;

Select *
from layoffs_staging2
where company LIKE 'Bally%';

-- Dropping Columns and rows now

Select *
from layoffs_staging2
where total_laid_off is NULL 
and percentage_laid_off is NULL;

Delete 
from layoffs_staging2
where total_laid_off is NULL 
and percentage_laid_off is NULL;

Alter table layoffs_staging2
DROP column row_num;

Select *
from layoffs_staging2;
 

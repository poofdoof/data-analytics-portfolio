-- Exploratory Data Analysis

Select *
from layoffs_staging2;

Select MAX(total_laid_off), MAX(percentage_laid_off)
from layoffs_staging2;

Select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off DESC;

Select company, SUM(total_laid_off)
from layoffs_staging2
group by company
order by 2 DESC;

Select industry, SUM(total_laid_off)
from layoffs_staging2
group by industry;

Select country, SUM(total_laid_off)
from layoffs_staging2
group by country
Order by 2 DESC;

Select Min(`date`), Max(`date`)
from layoffs_staging2;

Select `date`, SUM(total_laid_off)
from layoffs_staging2
group by `date`
order by 1 DESC;

Select Year(`date`), SUM(total_laid_off)
from layoffs_staging2
group by Year(`date`)
order by 1 DESC;

Select stage, SUM(total_laid_off)
from layoffs_staging2
group by stage
order by 2 DESC;

Select Substring(`date`, 1,7), Sum(total_laid_off) as laid_off
from layoffs_staging2
where Substring(`date`, 1,7) is not null
Group by Substring(`date`, 1,7)
Order by 1 ASC;


Select Substring(`date`, 1,7), Sum(total_laid_off) as laid_off
from layoffs_staging2
where Substring(`date`, 1,7) is not null
Group by Substring(`date`, 1,7)
Order by 1 ASC;

-- USED CTE here for rolling sum

WITH roll_sum_total
AS (
Select Substring(`date`, 1,7) as `MONTH`, Sum(total_laid_off) as laid_off
from layoffs_staging2
where Substring(`date`, 1,7) is not null
Group by Substring(`date`, 1,7)
Order by 1 ASC
)
Select `MONTH`, laid_off, SUM(laid_off) OVER (Order by `MONTH`) as roll_total
from roll_sum_total;

Select company, Year (`date`) as year_date, sum(total_laid_off) as lay_off
from layoffs_staging2
group by company, year_date
order by 3 DESC;

-- Creating a CTE to filter out the year with the company name where top 5 are ranked as per layoffs

WITH company_year (Company, year_laid_off, layoffs) 
as 
(
Select company, Year (`date`), sum(total_laid_off)
from layoffs_staging2
where Year (`date`) is not null
group by company, Year (`date`)
Order by 3 DESC
), company_year_rank as
(Select *, dense_rank () over (partition by year_laid_off order by layoffs DESC) as Rankings
from company_year
)
Select *
from company_year_rank
where Rankings <= 5;
  
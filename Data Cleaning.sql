-- Data Cleaning 

Select * 
FROM Layoffs;


-- 1 Remove Duplicates
-- 2 Standardize the data
-- 3 Null value or Blank Value
-- 4 Remove any Columns or rows

Create Table Layoff_staging
Like layoffs;

Select * from Layoff_staging;

Insert into layoff_staging
Select * From Layoffs;

Select *,
Row_number()
over (partition by Company, industry, total_laid_off, percentage_laid_off, `date`) As Row_num
From layoff_staging;

With duplicate_cte AS
(Select *,
Row_number()
over (partition by Company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) As Row_num
From layoff_staging
)
Select * From duplicate_cte
Where Row_num > 1;

Select * from layoff_staging
Where company = "Casper";

CREATE TABLE `layoff_staging2` (
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

Select * from layoff_staging2;

Insert into layoff_staging2
Select *,
Row_number()
over (
partition by Company, location, industry,
total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) As Row_num
From layoff_staging;

Select * from layoff_staging2
Where row_num > 1;

Delete from layoff_staging2
Where row_num > 1;

-- Standardizing Data 

Select * from layoff_staging2;

Select company, Trim(company) AS cleaned_names
From layoff_staging2;

update layoff_staging2
Set company = Trim(company);

Select Distinct Industry 
From layoff_staging2
Order by 1;

Select * from layoff_staging2
Where Industry Like 'crypto%';

Update layoff_staging2
Set Industry = 'Crypto'
Where Industry Like 'Crypto%';

Select Distinct Country 
From layoff_staging2
Order by 1;

Select * from layoff_staging2
Where country like "united states%";


Select * from layoff_staging2
Where country = "united states.";

Update layoff_staging2
Set country = "united states"
Where country like "united states.";

Select `date`
 From layoff_staging2;

Update layoff_staging2
Set `date` = str_to_date(`date`,'%m/%d/%Y');

Select * from layoff_staging2;

Alter Table layoff_staging2
modify Column `date` Date;

Select * from layoff_staging2
Where total_laid_off is null
And percentage_laid_off is null;

Update layoff_staging2
Set industry = Null
Where industry = '';

Select distinct industry
From layoff_staging2;

Select * from layoff_staging2
Where industry is null
Or industry = '';

Select * from layoff_staging2
Where company = "Airbnb";

Select *
from layoff_staging2 tb1
Join layoff_staging2 tb2
	on tb1.company = tb2.company
where tb1.industry is null; 


Update layoff_staging2 tb1
Join layoff_staging2 tb2
	On tb1.company = tb2.company
Set tb1.industry = tb2.industry 
where tb1.industry is null
and tb2.industry is not null;



SELECT country, total_laid_off, 
ROW_NUMBER() OVER(ORDER BY country) AS row_num
FROM layoff_staging2
WHERE total_laid_off IS NULL;

Select * from layoff_staging2
Where total_laid_off is null
And percentage_laid_off is null;


Delete  
from layoff_staging2
Where total_laid_off is null
And percentage_laid_off is null;

-- Select *, rank() over(order by location) from layoff_staging2;

Alter table layoff_staging2
Drop column row_num;

Select * from layoff_staging2;

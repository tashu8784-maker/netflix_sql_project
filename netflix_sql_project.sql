use mar25;
select* from netflix_csv;
# -- DATA EXPLORATION --

#count total records- 
SELECT COUNT(*) AS total_titles FROM netflix_csv;

#Count movies vs TV shows-
SELECT type, COUNT(*) AS total_count
FROM netflix_csv
GROUP BY type;

#Check number of unique countries-
SELECT COUNT(DISTINCT country) AS unique_countries FROM netflix_csv;

#--Data Cleaning Queries-- 

#replace blank columns with unknown- 
SET SQL_SAFE_UPDATES = 0;

UPDATE netflix_csv
SET director = 'Unknown'
WHERE director IS NULL OR director = '';

UPDATE netflix_csv
SET country = 'Unknown'
WHERE country IS NULL OR country = '';

# -- Analytical Queries -- 

# a) Top 10 countries producing most titles
SELECT country, COUNT(*) AS total_titles
FROM netflix_csv
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

# b) Most common ratings on Netflix
SELECT rating, COUNT(*) AS count
FROM netflix_titles
GROUP BY rating
ORDER BY count DESC;

# c) Total releases by year
SELECT release_year, COUNT(*) AS total_releases
FROM netflix_csv
GROUP BY release_year
ORDER BY release_year DESC;

# --  Content Insights --
# a) Find most frequent directors
SELECT director, COUNT(*) AS total_titles
FROM netflix_csv
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

#b) Genres with most titles 
SELECT listed_in, COUNT(*) AS total_titles
FROM netflix_csv
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 10;

# -- Advanced Queries --
#a) Find countries with most TV Shows (not movies)
SELECT country, COUNT(*) AS tv_shows
FROM netflix_csv
WHERE type = 'TV Show'
GROUP BY country
ORDER BY tv_shows DESC
LIMIT 10;

#b) Longest-duration movies or series
SELECT title, duration, type
FROM netflix_csv
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 10;

# Find Average Release Year by Content Type
SELECT 
    type,
    ROUND(AVG(release_year), 1) AS avg_release_year
FROM netflix_csv
GROUP BY type;

# Most Common Duration (Movies) or Seasons (TV Shows)
SELECT 
    type,
    SUBSTRING_INDEX(duration, ' ', 1) AS duration_value,
    COUNT(*) AS total
FROM netflix_csv
GROUP BY type, duration_value
ORDER BY total DESC
LIMIT 10;

# Most Active Directors by Country
SELECT 
    country,
    director,
    COUNT(*) AS total_titles
FROM netflix_csv
WHERE director IS NOT NULL
GROUP BY country, director
ORDER BY total_titles DESC
LIMIT 15;

# Content Growth Trend (Cumulative Yearly)
SELECT 
    release_year,
    COUNT(*) AS yearly_titles,
    SUM(COUNT(*)) OVER (ORDER BY release_year) AS cumulative_titles
FROM netflix_csv
GROUP BY release_year
ORDER BY release_year;

#Average Content Age on Netflix
SELECT 
    ROUND(AVG(YEAR(CURDATE()) - release_year), 1) AS avg_content_age
FROM netflix_csv;

# Longest Duration Movies
SELECT 
    title, duration, release_year
FROM netflix_csv
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 10;

# Find Titles Added After a Specific Date
SELECT title, type, date_added
FROM netflix_csv
WHERE date_added >= '2022-01-01'
ORDER BY date_added DESC;
























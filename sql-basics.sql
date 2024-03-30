
---sql_basics.sql: This SQL script contains the queries used to perform various tasks on the "hero_battles" dataset.

 
--Retrieve All Rows and Columns: I started by fetching all rows and columns from the "hero_battles" table to gain a comprehensive understanding of the dataset.

 use heroes;
 select * from hero_battles;

--Retrieve First 5 Rows: Next, I fetched only the first 5 rows from the "hero_battles" table to provide a concise overview of the initial dataset.

select * from hero_battles limit 5;

--Select Date Column with Alias: I selectively retrieved the date column from the "hero_battles" table, utilizing an alias to rename it to "timestamp" for clarity and consistency.

select date as timestamp from hero_battles;

-- Select Specific Columns with Aliases: To enhance readability and relevance, I chose to alias the "hero_battles" table as "hb". Additionally, I selected only the "name" and "num_enemies" columns, renaming them to "hero_name" and "number_of_enemies", respectively.

 select name as hero_name, num_enemies as number_of_enemies 
 from hero_battles as hb 
 limit 4;


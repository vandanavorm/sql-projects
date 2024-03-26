# SQL Project: Hero Battles Analysis

Welcome to my SQL Project repository! In this project, I've demonstrated proficiency in crafting SQL queries by working with the "hero_battles" dataset.

## Project Overview

This repository contains SQL scripts and documentation for my SQL Project on Hero Battles Analysis. The dataset used in this project pertains to hero battles, and the SQL queries provided below demonstrate various querying tasks performed on this dataset.

## Project Structure

The repository is organized as follows:

- **sql_basics.sql**: This SQL script contains the queries used to perform various tasks on the "hero_battles" dataset.
- **README.md**: You're currently reading it! This file provides an overview of the project, including instructions and descriptions of the SQL queries.

## Tasks Accomplished

1. **Retrieve All Rows and Columns**: I started by fetching all rows and columns from the "hero_battles" table to gain a comprehensive understanding of the dataset.
   
    use heroes;
    select * from hero_battles;
    ```

2. **Retrieve First 5 Rows**: Next, I fetched only the first 5 rows from the "hero_battles" table to provide a concise overview of the initial dataset.
    
    select * from hero_battles limit 5;
   

3. **Select Date Column with Alias**: I selectively retrieved the date column from the "hero_battles" table, utilizing an alias to rename it to "timestamp" for clarity and consistency.
    
    select date as timestamp from hero_battles;
   

4. **Select Specific Columns with Aliases**: To enhance readability and relevance, I chose to alias the "hero_battles" table as "hb". Additionally, I selected only the "name" and "num_enemies" columns, renaming them to "hero_name" and "number_of_enemies", respectively.
   
    select name as hero_name, num_enemies as number_of_enemies 
    from hero_battles as hb 
    limit 4;
   

## Future Enhancements

While this project focused on the fundamentals of SQL querying, I'm eager to expand my skills and tackle more complex data manipulation tasks in future projects. Stay tuned for updates!


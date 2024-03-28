--Cryptopunks NFT Sales Analysis: Unveiling Insights into the Digital Collectibles Market

use capstone;
select*from pricedata;

-- Total Sales: Count the total number of sales during the specified time period    
select sum(usd_price) from pricedata;

--Top 5 Expensive Transactions: Identify the top 5 most expensive transactions by USD price, including NFT name, ETH price, USD price, and data    
select name,eth_price,usd_price,event_date from pricedata
order by usd_price desc limit 5;

--Moving Average: Calculate the moving average of the USD price for each transaction, considering the last 50 transactions    
select event_date,
usd_price,
avg(usd_price) over(order by event_date rows between 49 preceding and current row) as moving_avg
from pricedata;

--Average Sale Price: Compute the average sale price in USD for each NFT, sorted in descending order 
select*from pricedata;
select name, avg(usd_price) as average_price from pricedata
group by name 
order by average_price desc;

--Sales Analysis by Day of the Week: Analyze sales occurrences and average price in ETH for each day of the week
SELECT 
    DAY(event_date) AS day_of_week,
    COUNT(*) AS num_sales,
    AVG(eth_price) AS avg_price_in_eth
FROM 
    pricedata
GROUP BY 
    DAY(event_date)
ORDER BY 
    num_sales ASC;

--Sales Summary: Create concise summaries for each sale, including NFT details, buyer, seller, date, and sale price in USD
select concat(`name`,' ','was sold for $',`usd_price`,' ','to',' ',`buyer_address`,' ','from',' ',`seller_address`,' ', 'on',' ',`event_date`)
from pricedata;

--Create a view called "1919_purchases" containing any sales where the buyer was "0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685"
create view 1919_publisher as
select*from pricedata where buyer_address ='0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685';
select*from 1919_publisher;

--Histogram of ETH Price Ranges: Generate a histogram illustrating the distribution of ETH price ranges, rounded to the nearest hundred
SELECT ROUND(eth_price, -2)     AS bucket, 
COUNT(*) AS count,
RPAD('', COUNT(*), '*') AS bar 
FROM pricedata GROUP BY bucket ORDER BY bucket;

--Provide a unioned query containing the highest and lowest purchase prices for each NFT, along with a status indicating whether the price is the highest or lowest
SELECT name, MAX(eth_price) AS price, 'highest' AS status
FROM pricedata
GROUP BY name
UNION ALL
SELECT name, MIN(eth_price) AS price, 'lowest' AS status
FROM pricedata
GROUP BY `name`
ORDER BY `name`, status;

--Monthly/Yearly Best Sellers: Identify the NFT that sold the most each month/year combination, along with the name and price in USD
SELECT year_event, month_event, max_usd_price, name
FROM (
    SELECT YEAR(event_date) AS year_event,
           MONTH(event_date) AS month_event,
           MAX(usd_price) AS max_usd_price
    FROM pricedata
    GROUP BY year_event, month_event
) AS max_prices
JOIN pricedata ON YEAR(pricedata.event_date) = max_prices.year_event
             AND MONTH(pricedata.event_date) = max_prices.month_event
             AND pricedata.usd_price = max_prices.max_usd_price
ORDER BY max_usd_price DESC;

--Total Monthly Volume: Calculate the total sales volume rounded to the nearest hundred on a monthly basis
select round(max(usd_price),-2),
year(event_date) as event_year,
month(event_date) as event_month 
from pricedata
group by event_month,event_year;

--Wallet Activity: Count the number of transactions involving a specific wallet over the specified time period
select*from pricedata;
select count(transaction_hash) from pricedata 
where seller_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685' 
or  
buyer_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685';

--Estimated Average Value Calculator: Calculate the estimated average value of the collection based on specific criteria
CREATE TEMPORARY TABLE temp_daily_avg_price AS
SELECT event_date,usd_price,
AVG(usd_price) OVER (PARTITION BY event_date) AS daily_avg_price
FROM pricedata;
SELECT event_date,
AVG(usd_price) AS estimated_average_value
FROM temp_daily_avg_price
WHERE usd_price >= 0.1 * daily_avg_price
GROUP BY event_date;


use capstone;
select*from pricedata;
#1
select sum(usd_price) from pricedata;
#2
select name,eth_price,usd_price,event_date from pricedata
order by usd_price desc limit 5;
#3
select event_date,
usd_price,
avg(usd_price) over(order by event_date rows between 49 preceding and current row) as moving_avg
from pricedata;
#4
select*from pricedata;
select name, avg(usd_price) as average_price from pricedata
group by name 
order by average_price desc;
#5
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
#6
select concat(`name`,' ','was sold for $',`usd_price`,' ','to',' ',`buyer_address`,' ','from',' ',`seller_address`,' ', 'on',' ',`event_date`)
from pricedata;
#7
create view 1919_publisher as
select*from pricedata where buyer_address ='0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685';
select*from 1919_publisher;
#8
SELECT ROUND(eth_price, -2)     AS bucket, 
COUNT(*) AS count,
RPAD('', COUNT(*), '*') AS bar 
FROM pricedata GROUP BY bucket ORDER BY bucket;
#9
SELECT name, MAX(eth_price) AS price, 'highest' AS status
FROM pricedata
GROUP BY name
UNION ALL
SELECT name, MIN(eth_price) AS price, 'lowest' AS status
FROM pricedata
GROUP BY `name`
ORDER BY `name`, status;
#10
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
#11
select round(max(usd_price),-2),
year(event_date) as event_year,
month(event_date) as event_month 
from pricedata
group by event_month,event_year;
#12
select*from pricedata;
select count(transaction_hash) from pricedata 
where seller_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685' 
or  
buyer_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685';
#13
CREATE TEMPORARY TABLE temp_daily_avg_price AS
SELECT event_date,usd_price,
AVG(usd_price) OVER (PARTITION BY event_date) AS daily_avg_price
FROM pricedata;
SELECT event_date,
AVG(usd_price) AS estimated_average_value
FROM temp_daily_avg_price
WHERE usd_price >= 0.1 * daily_avg_price
GROUP BY event_date;



    
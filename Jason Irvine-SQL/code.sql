WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp;


My Code:

Question 1. 

SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;


SELECT COUNT (DISTINCT utm_source)
FROM page_visits;

COUNT(DISTINCT utm_campaign)
8
COUNT (DISTINCT utm_source)
6




SELECT DISTINCT utm_campaign, COUNT (*)
FROM page_visits
GROUP BY 1
ORDER BY 2;


SELECT DISTINCT utm_source, COUNT (*)
FROM page_visits
GROUP BY 1
ORDER BY 2;


utm_campaign	COUNT (*)
paid-search	231
retargetting-campaign	300
cool-tshirts-search	313
retargetting-ad	558
weekly-newsletter	565
interview-with-cool-tshirts-founder	1178
ten-crazy-cool-tshirts-facts	1198
getting-to-know-cool-tshirts	1349
utm_source	COUNT (*)
google	544
facebook	558
email	865
medium	1178
buzzfeed	1198
nytimes	1349


SELECT DISTINCT utm_campaign AS Campaign, COUNT(utm_campaign) AS Total, utm_source AS Source, COUNT(utm_source) AS Total
FROM page_visits
GROUP BY 1
ORDER BY 2;

Campaign	Total	Source	Total
paid-search	231	google	231
retargetting-campaign	300	email	300
cool-tshirts-search	313	google	313
retargetting-ad	558	facebook	558
weekly-newsletter	565	email	565
interview-with-cool-tshirts-founder	1178	medium	1178
ten-crazy-cool-tshirts-facts	1198	buzzfeed	1198
getting-to-know-cool-tshirts	1349	nytimes	1349

2. 
What pages are on the CoolTShirts website?

SELECT DISTINCT page_name
FROM page_visits
LIMIT 10;

page_name
1 - landing_page
2 - shopping_cart
3 - checkout
4 - purchase


3. 
How many first touches is each campaign responsible for?

WITH first_touch AS (WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp),
ft_attr AS (
  SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source,
       ft_attr.utm_campaign,
       COUNT(*)
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

ft_attr.utm_source	ft_attr.utm_campaign	COUNT(*)
medium	interview-with-cool-tshirts-founder	622
nytimes	getting-to-know-cool-tshirts	612
buzzfeed	ten-crazy-cool-tshirts-facts	576
google	cool-tshirts-search	169




4.How many last touches is each campaign responsible for?



WITH last_touch AS (WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source,
       lt_attr.utm_campaign,
       COUNT(*)
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;


lt_attr.utm_source	lt_attr.utm_campaign	COUNT(*)
email	weekly-newsletter	447
facebook	retargetting-ad	443
email	retargetting-campaign	245
nytimes	getting-to-know-cool-tshirts	232
buzzfeed	ten-crazy-cool-tshirts-facts	190
medium	interview-with-cool-tshirts-founder	184
google	paid-search	178
google	cool-tshirts-search	60


5. How many visitors make a purchase?

SELECT DISTINCT COUNT(user_id), page_name
FROM page_visits
WHERE page_name = '4 - purchase';

COUNT(user_id)	page_name
361	4 - purchase

6. How many last touches on the purchase page is each campaign responsible for?

WITH last_touch AS (WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
  WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source,
       lt_attr.utm_campaign,
       COUNT(*)
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

lt_attr.utm_source	lt_attr.utm_campaign	COUNT(*)
email	weekly-newsletter	115
facebook	retargetting-ad	113
email	retargetting-campaign	54
google	paid-search	52
buzzfeed	ten-crazy-cool-tshirts-facts	9
nytimes	getting-to-know-cool-tshirts	9
medium	interview-with-cool-tshirts-founder	7
google	cool-tshirts-search	2












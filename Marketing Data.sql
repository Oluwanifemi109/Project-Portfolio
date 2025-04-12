Use marketingdata;

select * from marketing_data;



-- campaign that generated the highest number of impressions, clicks, and conversions
Select campaign, 
sum(impressions) as Total_impressions,
sum(Clicks) as Total_clicks,
sum(conversions) as Total_conversions
from marketing_data
group by campaign
order by Total_impressions Desc, Total_clicks Desc, Total_conversions Desc
limit 1;



-- What is the average cost-per-click (CPC)  and click-through rate (CTR) for each campaign?
Select campaign, 
avg(Daily_Avg_CPC) as AVG_CPC,
avg(CTR) as AVG_CTR 
from marketing_data
group by campaign;



-- Which channel has the highest ROI?
Select channel,
sum(Total_conversion_value_GBP - Spend_GBP)  as ROI
from marketing_data
Group by channel
order by ROI DESC
Limit 1;



-- How do impressions, clicks, and conversions vary across different  channels?
Select channel,
sum(impressions) as Total_impressions,
sum(clicks) as Total_clicks,
sum(conversions) as Total_conversions
from marketing_data
group by channel
order by total_conversions Desc;



-- which cities have the highest engagement rate (likes, shares, comments)?
Select City_location,
sum(likes_reactions) + sum(shares) + sum(comments) as Engagement_rate
from marketing_data
group by city_location
order by Engagement_rate Desc;



-- What is the conversion rate by city?
Select city_location, 
       (SUM(Conversions) * 100.0) / NULLIF(SUM(Impressions), 0) AS conversion_rate
from marketing_data
group by city_location
order by conversion_rate DESC;




-- How do ad performances compare across different devices (mobile, desktop, tablet)?
Select Device,
sum(clicks) as Total_clicks,
sum(conversions) as Total_conversions
from marketing_data
group by Device;



-- Which device type generates the highest conversion rate ?
Select Device,
(SUM(Conversions) * 100.0) / NULLIF(SUM(Clicks), 0) as conversion_rate
from marketing_data
group by device
order by conversion_rate Desc
Limit 1;



-- Which specific ads are performing best in terms of engagement and conversions?
Select Ad,
sum(conversions) as Total_conversions, 
sum(likes_reactions) + 
sum(Shares) + 
sum(Comments) as Engagement
from marketing_data
group by ad
order by Engagement Desc;



-- What are the common characteristics of high-performing ads?
Select Ad,
avg(ctr) as Avg_CTR,
avg(conversions) as Avg_conversions
from marketing_data
group by ad
order by Avg_conversions;



-- What is the ROI for each campaign, and how does it compare across different channels and devices?
SELECT 
    Campaign,
    Channel,
    Device,
    SUM(Total_conversion_value_GBP) AS Total_Conversion_Value,
    SUM(Spend_GBP) AS Total_Spend,
    CASE 
        WHEN SUM(Spend_GBP) = 0 THEN 0
        ELSE (SUM(Total_conversion_value_GBP) - SUM(Spend_GBP)) / SUM(Spend_GBP)
    END AS ROI
FROM Marketing_data
GROUP BY Campaign, Channel, Device
ORDER BY ROI DESC;



-- How does spend correlate with conversion value across different campaigns?
Select Campaign,
sum(spend_GBP) as Total_Spend,
sum(Total_conversion_Value_GBP) as Total_conversion_value,
sum(Total_conversion_Value_GBP) - sum(spend_GBP) as Profit_Margin
from marketing_data
group by campaign
order by Profit_margin Desc;



-- Are there any noticeable trends or seasonal effects in ad performance over time? 
Select date,
sum(impressions) as Total_impressions,
sum(clicks) as Total_clicks,
sum(conversions) as Total_conversions
from marketing_data
group by date
order by date asc;


Select * from marketing_data;









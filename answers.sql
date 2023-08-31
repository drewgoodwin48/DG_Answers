--Q1
select date, SUM(impressions) total_impressions from marketing_performance 
group by 1
order by 1;

--Q2
select state, SUM(revenue) total_revenue from website_revenue
group by 1
order by 2 DESC
LIMIT 3;
--3rd best state: OH (37577)

--Q3
with revenue_aggregated as (
	select campaign_id, sum(revenue) revenue
	from website_revenue
	group by 1
), marketing_aggregated as (
	select campaign_id, sum(cost) as cost, sum(impressions) as impressions, sum(clicks) as clicks
	from marketing_performance
	group by 1
)
select id, name, revenue, cost, impressions, clicks
from campaign_info c 
join revenue_aggregated r on c.id = r.campaign_id
join marketing_aggregated m on c.id = m.campaign_id;

--Q4
select c5.geo, sum(c5.conversions) from
(select * from campaign_info c
join marketing_performance m on c.id = m.campaign_id
where c.name = 'Campaign5') c5
group by 1
order by 2 DESC;
--Georgia generated the most conversions from for campaign 5.

--Q5
-- For this problem, we will calculate ratios of cost to impressions, clicks, and conversions.
select x.name, sum(x.impressions)/sum(x.cost) as impressions_to_cost, sum(x.clicks)/sum(x.cost) as clicks_to_cost, sum(x.conversions)/sum(x.cost) as conversions_to_cost from
(select * from campaign_info c
join marketing_performance m on c.id = m.campaign_id) x
group by 1;
-- we determine that Campaign4 was the most efficient. That being said, Campaign1 was also quite efficient.

--Q6
--For this problem, we will examine which day of the week returns the maximum value of impressions/cost, clicks/cost, and conversions/cost.
select EXTRACT('DOW' FROM x.date) As DOW, sum(x.impressions)/sum(x.cost) as impressions_to_cost, sum(x.clicks)/sum(x.cost) as clicks_to_cost, sum(x.conversions)/sum(x.cost) as conversions_to_cost from
(select * from campaign_info c
join marketing_performance m on c.id = m.campaign_id) x
group by 1
order by 2 DESC;

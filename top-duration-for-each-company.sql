with RouteDuration as (
select
	ac.company_name,
	t.town_from AS departure_city,
	t.town_to AS arrival_city,
    	avg(timestampdiff(minute, t.time_out, t.time_in)) as avg_flight_duration
from Airline_company ac
join Trip t
using(ID_comp)
group by company_name, departure_city, arrival_city
),
RouteAvgDuration as (
select *,
    row_number() over(partition by company_name order by avg_flight_duration desc) as row_num
from RouteDuration
)
select company_name, 
	departure_city, 
	arrival_city, 
	avg_flight_duration
from RouteAvgDuration
where row_num < 3;

use air_transportation;

with 
trips as (
	select trip_no, 
	   ID_comp, 
       concat(town_from, ' ', town_to) as route,
       timestampdiff(MINUTE, time_out, time_in) as flight_duration,
       ID_psg
from Trip
join Pass_in_trip pt
using(trip_no)
),
routes as (
select  route,
		count(ID_psg) as trip_passengers,
		flight_duration, 
		round(count(ID_psg) * flight_duration * 60 * 0.01) as flight_income
from trips
group by trip_no)
select route,
       round(avg(flight_duration)) as avg_flight_duration,
	     sum(trip_passengers) as total_passengers,
       sum(flight_income) as total_income
from routes
group by route
order by total_income desc;

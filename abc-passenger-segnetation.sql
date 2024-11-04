with
Passenger_income as
(
select ID_psg,
	   passenger_name,
       sum(timestampdiff(second, time_out, time_in) * 0.01) as passenger_income_dollars
from Passenger
join Pass_in_trip
using(ID_psg)
join Trip
using (trip_no)
group by ID_psg,
	     passenger_name
),
PassengerWithCammulative as
(
select ID_psg,
	   passenger_name,
       passenger_income_dollars,
       sum(passenger_income_dollars) over(order by passenger_income_dollars desc) as cammulative_income
from Passenger_income
order by passenger_income_dollars desc
),
PassengerWithCammulativePercentage as
(
select ID_psg,
	   passenger_name,
       passenger_income_dollars,
       round(cammulative_income * 100 / (
       select max(cammulative_income) from PassengerWithCammulative), 2) as cumulative_share_percent
from PassengerWithCammulative
order by cammulative_income
)
select ID_psg,
	   passenger_name,
       passenger_income_dollars,
       cumulative_share_percent,
       case
		when cumulative_share_percent < 80.01 then 'A' 
        when cumulative_share_percent < 95.01 then 'B'
        else 'C'
		end as category
from PassengerWithCammulativePercentage
order by passenger_income_dollars desc
;

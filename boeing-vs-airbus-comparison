SELECT 
    CASE 
        WHEN plane_type LIKE 'Boeing%' THEN 'Boeing'
        WHEN plane_type LIKE 'Airbus%' THEN 'Airbus'
    END AS aircraft_type,
    AVG(TIMESTAMPDIFF(MINUTE, time_out, time_in)) AS avg_flight_duration,
    COUNT(trip_no) AS num_flights
FROM 
    Trip
WHERE 
    plane_type LIKE 'Boeing%' OR plane_type LIKE 'Airbus%'
GROUP BY 
    aircraft_type
ORDER BY 
    aircraft_type;

-- В какие города можно улететь из Парижа (Paris) и сколько времени это займёт?

SELECT town_to,
    TIMEDIFF(time_in, time_out) AS flight_time
FROM Trip
WHERE town_from = 'Paris';
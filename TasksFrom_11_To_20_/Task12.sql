-- Вывести id и количество пассажиров для всех прошедших полётов

SELECT trip, COUNT(passenger) AS count FROM Pass_in_trip
GROUP BY trip;
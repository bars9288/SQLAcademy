-- В какие города летал Bruce Willis

SELECT town_to FROM Trip
INNER JOIN Pass_in_trip ON Trip.id = Pass_in_trip.trip
INNER JOIN Passenger ON Passenger.id = Pass_in_trip.passenger
WHERE Passenger.name = 'Bruce Willis';
-- Выведите дату и время прилёта пассажира Стив Мартин (Steve Martin) в Лондон (London)

SELECT time_in FROM Trip
INNER JOIN Pass_in_trip ON Pass_in_trip.trip = Trip.id
INNER JOIN Passenger ON  Pass_in_trip.passenger = Passenger.id
WHERE Passenger.name = 'Steve Martin' AND
    Trip.town_to = 'London';
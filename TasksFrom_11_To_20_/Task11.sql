-- Выведите пассажиров с самым длинным ФИО. Пробелы, дефисы и точки считаются частью имени.

SELECT name FROM Passenger
WHERE LENGTH(name) =
    (SELECT  MAX(LENGTH(name)) FROM Passenger);
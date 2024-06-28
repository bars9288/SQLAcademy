-- Вывести имена людей, у которых есть полный тёзка среди пассажиров

SELECT name FROM Passenger
GROUP BY name
HAVING COUNT(name) != 1;
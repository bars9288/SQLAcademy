-- Какие компании совершали перелеты на Boeing

SELECT DISTINCT name FROM Company
INNER JOIN Trip ON Trip.company = Company.id
WHERE Trip.plane = 'Boeing';
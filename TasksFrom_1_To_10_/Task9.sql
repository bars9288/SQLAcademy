-- Какие компании организуют перелеты из Владивостока (Vladivostok)?

SELECT name FROM Company
INNER JOIN Trip ON Trip.company = Company.id
WHERE town_to = 'Vladivostok';
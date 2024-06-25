-- Вывести количество рейсов, совершенных на TU-134

SELECT COUNT(*) AS count FROM Trip
WHERE plane = 'TU-134';
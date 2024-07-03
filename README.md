
### Решение всех задач из каталога https://sql-academy.org/ru/trainer
1 - Вывести имена всех людей, которые есть в базе данных авиакомпаний
```sql
SELECT name FROM  Passenger;
```

2 - Вывести названия всеx авиакомпаний
```sql
SELECT name FROM  Company;
```
3 - Вывести все рейсы, совершенные из Москвы
```sql
SELECT * FROM Trip
WHERE town_from = 'Moscow';
```
4 - Вывести имена людей, которые заканчиваются на "man"
```sql
SELECT name FROM Passenger
WHERE name LIKE '%man';
```
5 - Вывести количество рейсов, совершенных на TU-134
```sql
SELECT COUNT(*) AS count FROM Trip
WHERE plane = 'TU-134';
```
6 - Какие компании совершали перелеты на Boeing
```sql
SELECT DISTINCT name FROM Company
INNER JOIN Trip ON Trip.company = Company.id
WHERE Trip.plane = 'Boeing';
```
7 - Вывести все названия самолётов, на которых можно улететь в Москву (Moscow)
```sql
SELECT DISTINCT plane FROM Trip
WHERE  town_to = 'Moscow';
```
8 - В какие города можно улететь из Парижа (Paris) и сколько времени это займёт?
```sql
SELECT town_to,
    TIMEDIFF(time_in, time_out) AS flight_time
FROM Trip
WHERE town_from = 'Paris';
```
9 - Какие компании организуют перелеты из Владивостока (Vladivostok)?
```sql
SELECT name FROM Company
INNER JOIN Trip ON Trip.company = Company.id
WHERE town_to = 'Vladivostok';
```
10 - Вывести вылеты, совершенные с 10 ч. по 14 ч. 1 января 1900 г.
```sql
SELECT * FROM Trip
WHERE time_out >= '1900-01-01 10:00:00'
  AND time_out <= '1900-01-01 14:00:00';
```
11 - Выведите пассажиров с самым длинным ФИО. Пробелы, дефисы и точки считаются частью имени.
```sql
SELECT name FROM Passenger
WHERE LENGTH(name) =
    (SELECT MAX(LENGTH(name)) FROM Passenger);
```
12 - Вывести id и количество пассажиров для всех прошедших полётов
```sql
SELECT trip, COUNT(passenger) AS count FROM Pass_in_trip
GROUP BY trip;
```
13 - Вывести имена людей, у которых есть полный тёзка среди пассажиров
```sql
SELECT name FROM Passenger
GROUP BY name
HAVING COUNT(name) != 1;
```
14 - В какие города летал Bruce Willis
```sql
SELECT town_to FROM Trip
INNER JOIN Pass_in_trip ON Trip.id = Pass_in_trip.trip
INNER JOIN Passenger ON Passenger.id = Pass_in_trip.passenger
WHERE Passenger.name = 'Bruce Willis';
```
15 - Выведите дату и время прилёта пассажира Стив Мартин (Steve Martin) в Лондон (London)
```sql
SELECT time_in FROM Trip
INNER JOIN Pass_in_trip ON Pass_in_trip.trip = Trip.id
INNER JOIN Passenger ON  Pass_in_trip.passenger = Passenger.id
WHERE Passenger.name = 'Steve Martin' AND
    Trip.town_to = 'London';
```
16 - Вывести отсортированный по количеству перелетов (по убыванию) и имени (по возрастанию) список пассажиров, совершивших хотя бы 1 полет.
```sql
SELECT name, COUNT(name) AS count FROM Passenger
INNER JOIN Pass_in_trip ON Passenger.id = Pass_in_trip.passenger
GROUP BY name
ORDER BY COUNT(name) DESC, name ASC;
```
17 - Определить, сколько потратил в 2005 году каждый из членов семьи. В результирующей выборке не выводите тех членов семьи, которые ничего не потратили.

```sql
SELECT member_name, status,
SUM(Payments.amount * Payments.unit_price) AS costs
FROM  FamilyMembers
INNER JOIN Payments ON FamilyMembers.member_id = Payments.family_member
WHERE YEAR(Payments.date) = '2005'
GROUP BY  Payments.family_member
```
18 - Выведите имя самого старшего человека. Если таких несколько, то выведите их всех.
```sql
SELECT member_name FROM FamilyMembers
WHERE birthday = (SELECT MIN(birthday) FROM  FamilyMembers)
```
19 - Определить, кто из членов семьи покупал картошку (potato)
```sql
SELECT DISTINCT status FROM  FamilyMembers
INNER JOIN Payments ON Payments.family_member = FamilyMembers.member_id
INNER JOIN Goods ON Goods.good_id = Payments.good
WHERE Goods.good_name = 'potato'
```
20 - Сколько и кто из семьи потратил на развлечения (entertainment). Вывести статус в семье, имя, сумму
```sql
SELECT status, member_name,
    SUM(Payments.amount * Payments.unit_price) AS costs FROM FamilyMembers
INNER JOIN Payments ON FamilyMembers.member_id = Payments.family_member
INNER JOIN Goods ON Goods.good_id = Payments.good
INNER JOIN GoodTypes ON GoodTypes.good_type_id = Goods.type
WHERE GoodTypes.good_type_name = 'entertainment'
GROUP BY status, member_name
```
21 - Определить товары, которые покупали более 1 раза
```sql
SELECT good_name FROM Goods
INNER JOIN Payments ON Goods.good_id = Payments.good
GROUP BY good_name
HAVING COUNT(*) > 1
```
22 - Найти имена всех матерей (mother)
```sql
SELECT member_name AS member_name
FROM FamilyMembers
WHERE status = "mother"
```
23 - Найдите самый дорогой деликатес (delicacies) и выведите его цену
```sql
SELECT good_name, Payments.unit_price FROM  Goods
INNER JOIN Payments ON Payments.good = Goods.good_id
INNER JOIN GoodTypes ON GoodTypes.good_type_id = Goods.type
WHERE good_type_name = 'delicacies'
ORDER BY unit_price DESC
LIMIT 1
```
24 - Определить кто и сколько потратил в июне 2005
```sql
SELECT member_name, SUM(Payments.unit_price * Payments.amount) AS costs FROM FamilyMembers
INNER JOIN Payments ON Payments.family_member = FamilyMembers.member_id
WHERE Payments.date BETWEEN '2005-06-01T00:00:00.000Z' AND '2005-06-30T00:00:00.000Z'
GROUP BY Payments.family_member
```
25 - Определить, какие товары не покупались в 2005 году
```sql
SELECT good_name FROM Goods
WHERE good_name NOT IN
(SELECT good_name FROM Goods
INNER JOIN Payments ON Payments.good = Goods.good_id
WHERE YEAR(Payments.date) = '2005')
```
26 - Определить группы товаров, которые не приобретались в 2005 году
```sql
SELECT good_type_name FROM  GoodTypes
WHERE good_type_name NOT IN
(SELECT good_type_name FROM  GoodTypes
INNER JOIN Goods ON Goods.type = GoodTypes.good_type_id
INNER JOIN Payments ON Goods.good_id = Payments.good
WHERE YEAR(Payments.date) = '2005')
```
27 - Узнайте, сколько было потрачено на каждую из групп товаров в 2005 году. Выведите название группы и потраченную на неё сумму. Если потраченная сумма равна нулю, т.е. товары из этой группы не покупались в 2005 году, то не выводите её.

```sql
SELECT good_type_name, SUM(Payments.amount * Payments.unit_price) AS costs FROM GoodTypes
INNER JOIN Goods ON GoodTypes.good_type_id = Goods.type
INNER JOIN  Payments ON Goods.good_id = Payments.good
WHERE YEAR(Payments.date) = '2005'
GROUP BY GoodTypes.good_type_id
HAVING costs > 0
```
28 - Сколько рейсов совершили авиакомпании из Ростова (Rostov) в Москву (Moscow) ?
```sql
SELECT COUNT(*) AS count
FROM Trip
WHERE town_from = 'Rostov'
AND town_to = 'Moscow'
```
29 - Выведите имена пассажиров улетевших в Москву (Moscow) на самолете TU-134
```sql
SELECT DISTINCT  name FROM Passenger
INNER JOIN Pass_in_trip ON Passenger.id = Pass_in_trip.passenger
INNER JOIN Trip ON Trip.id = Pass_in_trip.trip
WHERE town_to = 'Moscow'
```
30 - Выведите нагруженность (число пассажиров) каждого рейса (trip). Результат вывести в отсортированном виде по убыванию нагруженности.

```sql
SELECT trip, COUNT(passenger) AS count FROM Pass_in_trip
GROUP BY trip
ORDER BY count DESC
```
31 - Вывести всех членов семьи с фамилией Quincey.
```sql
SELECT * FROM FamilyMembers
WHERE member_name LIKE '%Quincey%'
```
32 - Вывести средний возраст людей (в годах), хранящихся в базе данных. Результат округлите до целого в меньшую сторону.
```sql
SELECT FLOOR(AVG(TIMESTAMPDIFF(YEAR,birthday,NOW())))
AS age FROM FamilyMembers
```
33 - Найдите среднюю цену икры на основе данных, хранящихся в таблице Payments. В базе данных хранятся данные о покупках красной (red caviar) и черной икры (black caviar). В ответе должна быть одна строка со средней ценой всей купленной когда-либо икры.
```sql
SELECT AVG(unit_price) AS cost FROM Payments
INNER JOIN Goods ON Goods.good_id = Payments.good
WHERE good_name IN ('red caviar','black caviar')
```
34 - Сколько всего 10-ых классов
```sql
SELECT COUNT(name) AS count FROM Class
WHERE name LIKE '%10%'
```
35 - Сколько различных кабинетов школы использовались 2 сентября 2019 года для проведения занятий?
```sql
SELECT DISTINCT COUNT(classroom) AS count FROM Schedule
WHERE date IN (SELECT date FROM Schedule
WHERE date LIKE '%2019-09-02%')
```
36 - Выведите информацию об обучающихся живущих на улице Пушкина (ul. Pushkina)?
```sql
SELECT * FROM Student
WHERE address LIKE '%Pushkina%'
```
37 - Сколько лет самому молодому обучающемуся ?
```sql
SELECT MIN(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS year
 FROM Student
```
38 - Сколько Анн (Anna) учится в школе ?
```sql
SELECT COUNT(*) AS count FROM Student
WHERE first_name = 'Anna'
```
39 - Сколько обучающихся в 10 B классе ?
```sql
SELECT COUNT(*) AS count FROM Student_in_class
INNER JOIN Class ON Class.id = Student_in_class.class
WHERE Class.name = '10 B'
```
40 - Выведите название предметов, которые преподает Ромашкин П.П. (Romashkin P.P.). Обратите внимание, что в базе данных есть несколько учителей с такими фамилией и инициалами.
```sql
SELECT name AS subjects FROM Subject
INNER JOIN Schedule ON Schedule.subject = Subject.id
INNER JOIN Teacher ON Teacher.id = Schedule.teacher
WHERE Teacher.last_name LIKE '%Romashkin%'
AND Teacher.middle_name LIKE 'P%'
```
41 - Выясните, во сколько по расписанию начинается четвёртое занятие.
```sql
SELECT DISTINCT start_pair FROM  Timepair
INNER JOIN Schedule ON Schedule.number_pair = Timepair.id
WHERE number_pair = 4
```
42 - Сколько времени обучающийся будет находиться в школе, учась со 2-го по 4-ый уч. предмет?
```sql
SELECT DISTINCT TIMEDIFF(
    (SELECT DISTINCT end_pair FROM Timepair
    INNER JOIN Schedule ON Schedule.number_pair = Timepair.id
    WHERE number_pair = 4),
    (SELECT DISTINCT start_pair FROM Timepair
    INNER JOIN Schedule ON Schedule.number_pair = Timepair.id
    WHERE number_pair = 2)
) AS time FROM Timepair
```
43 - Выведите фамилии преподавателей, которые ведут физическую культуру (Physical Culture). Отсортируйте преподавателей по фамилии в алфавитном порядке.
```sql
SELECT last_name FROM Teacher
INNER JOIN Schedule ON Schedule.teacher = Teacher.id
INNER JOIN Subject ON Subject.id = Schedule.subject
WHERE Subject.name = 'Physical Culture'
ORDER BY last_name ASC  
```
44 - Найдите максимальный возраст (количество лет) среди обучающихся 10 классов на сегодняшний день. Для получения текущих даты и времени используйте функцию NOW().
```sql
SELECT MAX(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS max_year FROM Student
INNER JOIN Student_in_class ON Student_in_class.student = Student.id
INNER JOIN Class ON Class.id = Student_in_class.class
WHERE Class.name LIKE '10%'
```
45 - Какие кабинеты чаще всего использовались для проведения занятий? Выведите те, которые использовались максимальное количество раз.
```sql
SELECT classroom FROM Schedule
GROUP BY classroom
HAVING COUNT(classroom) =
    (SELECT COUNT(classroom) FROM Schedule
    GROUP BY classroom
    ORDER BY COUNT(classroom) DESC
    LIMIT 1)
```
46 - В каких классах введет занятия преподаватель "Krauze" ?
```sql
SELECT DISTINCT  name FROM Class
INNER JOIN Schedule ON Schedule.class = Class.id
INNER JOIN Teacher ON Teacher.id = Schedule.teacher
WHERE Teacher.last_name = 'Krauze'
```
47 - Сколько занятий провел Krauze 30 августа 2019 г.?
```sql
SELECT COUNT(*) AS count FROM Schedule
INNER JOIN Teacher ON Teacher.id = Schedule.teacher
WHERE Teacher.last_name = 'Krauze'
AND Schedule.date LIKE '2019-08-30%'
```
48 -
```sql

```
49 -
```sql

```
50 -
```sql

```




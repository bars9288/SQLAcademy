 -- Определить, сколько потратил в 2005 году каждый из членов семьи. В результирующей выборке не выводите тех членов семьи, которые ничего не потратили.

SELECT member_name, status,
SUM(Payments.amount * Payments.unit_price) AS costs
FROM  FamilyMembers
INNER JOIN Payments ON FamilyMembers.member_id = Payments.family_member
WHERE YEAR(Payments.date) = '2005'
GROUP BY  Payments.family_member
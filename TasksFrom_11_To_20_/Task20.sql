-- Сколько и кто из семьи потратил на развлечения (entertainment). Вывести статус в семье, имя, сумму

SELECT status, member_name,
    SUM(Payments.amount * Payments.unit_price) AS costs FROM FamilyMembers
INNER JOIN Payments ON FamilyMembers.member_id = Payments.family_member
INNER JOIN Goods ON Goods.good_id = Payments.good
INNER JOIN GoodTypes ON GoodTypes.good_type_id = Goods.type
WHERE GoodTypes.good_type_name = 'entertainment'
GROUP BY status, member_name
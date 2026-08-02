SELECT r.Name_ru AS Region, CONCAT(p.first_name, " ", p.Second_name, " ", p.Last_name) AS Full_name, IF(p.gender, "Женщина", "Мужчина") AS Gender, COUNT(s.id) AS "Кол-во услуг"
FROM patients p
JOIN service s 
ON p.code_service=s.code
JOIN region r
ON p.id_region=r.id
WHERE dt_reg between "2024-01-01" AND "2024-05-31"
GROUP BY Region, Full_name, Gender;

SELECT COUNT(*)
FROM table1 t1
JOIN table2 t2
ON t1.IIN=t2.IIN;

SELECT IIN, COUNT(*)
FROM table1
GROUP BY IIN
HAVING COUNT(*) > 1;

SELECT IIN, COUNT(*)
FROM table2
GROUP BY IIN
HAVING COUNT(*) > 1;

SELECT birth_date, timestampdiff(YEAR, birth_date, CURDATE()) AS Age
FROM table2
HAVING Age between 30 AND 70;
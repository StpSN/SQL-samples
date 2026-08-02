#1. Создать процедуру, в которой мы получаем на вход два параметра p_salary, p_dept и на выходе получим:
#- Список сотрудников (emp_no, first_name, gender), у которых средняя зарплата больше p_salary и которые когда-то работали в департаменте p_dept.

DROP PROCEDURE IF EXISTS emp_salary_dept;
DELIMITER $$ 
CREATE PROCEDURE emp_salary_dept (IN p_salary INT, IN p_dept VARCHAR(10))
BEGIN
	SELECT e.emp_no, e.first_name, e.gender 
	FROM employees e
    JOIN salaries s
    ON e.emp_no=s.emp_no
    JOIN dept_emp d
    ON e.emp_no=d.emp_no
    WHERE d.dept_no = p_dept
    group by e.emp_no
    HAVING AVG(salary) > p_salary
    ORDER BY e.emp_no;
END $$
DELIMITER ;
CALL emp_salary_dept(80000, 'd001');

#2. Создать функцию, которая получает на вход f_name и выдает максимальную зарплату среди сотрудников с именем f_name.

DROP FUNCTION IF EXISTS name_max_salary;
DELIMITER $$ 
CREATE FUNCTION name_max_salary (f_name VARCHAR(14)) RETURNS DECIMAL(10,2)
deterministic reads sql data
BEGIN
	DECLARE max_salary DECIMAL(10,2);
	SELECT MAX(salary) INTO max_salary
	FROM employees e
	JOIN salaries s
	ON e.emp_no=s.emp_no
	WHERE first_name = f_name
	group by first_name;
    RETURN max_salary;
END $$
DELIMITER ;
SELECT * FROM employees;
SET @name='Georgi';
SELECT name_max_salary(@name);

#Следующие запросы относятся к базе данных World (скачайте ее ниже, и запустите все запросы, как мы делали с employees):
#1. Посчитайте количество городов в каждой стране, где IndepYear = 1991 (Independence Year).

SELECT country.name, COUNT(city.ID) AS cities_number
FROM city
JOIN country
ON city.countrycode=country.code
WHERE country.IndepYear = 1991
GROUP BY country.name;
 

#2. Узнайте, какая численность населения и средняя продолжительность жизни людей в Аргентине (ARG).

SELECT population, LifeExpectancy
FROM country
WHERE code='ARG';

#3. В какой стране самая высокая продолжительность жизни?

SELECT name, LifeExpectancy
FROM country
WHERE LifeExpectancy = (SELECT max(LifeExpectancy) FROM country);

SELECT name, LifeExpectancy
FROM country
ORDER BY LifeExpectancy DESC
LIMIT 1;

#4. Перечислите все языки, на которых говорят в регионе «Southeast Asia».

SELECT DISTINCT Language
FROM country c
JOIN countrylanguage l
ON c.code=l.CountryCode
WHERE Region = 'Southeast Asia';

#5. Посчитайте сумму SurfaceArea для каждого континента.

SELECT continent, SUM(SurfaceArea) AS Area
FROM country
GROUP BY continent;
#1. Объединение сотрудников и менеджеров: Напишите запрос, который использует UNION для объединения списка всех сотрудников (мужчин) и всех менеджеров (только идентификаторы сотрудников emp_no).

SELECT emp_no FROM employees
WHERE gender = "M"
UNION
SELECT emp_no FROM titles
WHERE title = "Manager";

#2. Список уникальных должностей и отделов: Создайте запрос, который объединяет уникальные названия должностей из таблицы titles и названия отделов из departments.

SELECT DISTINCT title FROM titles
UNION
SELECT dept_name FROM departments;

#3. Сотрудники с зарплатами выше и ниже среднего: Напишите запрос, который использует UNION для объединения двух списков: сотрудников с зарплатой выше 60.000 долларов и сотрудников с зарплатой ниже 40.000 долларов (используйте имя и зарплату).

SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no=s.emp_no
WHERE salary > 60000
UNION 
SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no=s.emp_no
WHERE salary < 40000;

#4. Объединение текущих и бывших сотрудников: Используйте UNION для создания списка сотрудников, которые в настоящее время работают в компании, и тех, кто уже ушел (используйте имя, фамилию и статус 'Текущий' или 'Бывший' , то есть first_name, last_name, 'Текущий' AS status, 'Бывший' AS status ).

SELECT first_name, last_name, 'Текущий' AS status
FROM employees 
WHERE emp_no IN(
	SELECT e.emp_no
	FROM employees e
	JOIN dept_emp d
	ON e.emp_no=d.emp_no
	group by e.emp_no
	HAVING MAX(to_date) > curdate())
UNION
SELECT first_name, last_name, 'Бывший' AS status
FROM employees 
WHERE emp_no IN(
	SELECT e.emp_no
	FROM employees e
	JOIN dept_emp d
	ON e.emp_no=d.emp_no
	group by e.emp_no
	HAVING MAX(to_date) <= curdate());

#5. Сравнение зарплат менеджеров и обычных сотрудников: Создайте запрос с использованием UNION, чтобы сравнить средние зарплаты менеджеров и обычных сотрудников
# выведите тип сотрудника, либо Менеджер, либо Обычный сотрудник их среднюю зарплату, то есть 'Менеджер' AS type, 'Обычный сотрудник' AS type, AVG(salary) AS avg_salary ).

SELECT 'Менеджер' AS type, AVG(salary) AS avg_salary
FROM titles t
JOIN salaries s
ON t.emp_no=s.emp_no
WHERE t.title = "Manager" AND t.to_date>curdate()
GROUP BY type
UNION 
SELECT 'Обычный сотрудник' AS type, AVG(salary) AS avg_salary
FROM titles t
JOIN salaries s
ON t.emp_no=s.emp_no
WHERE t.title != "Manager" AND t.to_date>curdate()
GROUP BY type;
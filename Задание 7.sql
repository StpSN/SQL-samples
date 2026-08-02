#1. Выведите список всех менеджеров, а именно их emp_no, имена/фамилии, номер департамента, который они курируют, и дату найма в компанию. (именно менеджером, то есть подсказка dept_manager)
SELECT  e.emp_no AS ID, e.first_name AS "Имя", e.last_name AS "Фамилия", d.dept_no AS "Номер департамента", e.hire_date AS "Дата найма"
FROM dept_manager d
JOIN employees e 
ON d.emp_no=e.emp_no
WHERE d.to_date > curdate();

#2. Существует ли сотрудник по фамилии Markovitch, который когда-то был менеджером департамента. Может быть таких сотрудников несколько? (именно менеджером, то есть подсказка dept_manager)

SELECT  e.emp_no AS ID, e.first_name AS "Имя", e.last_name AS "Фамилия", d.dept_no AS "Номер департамента", e.hire_date AS "Дата найма"
FROM dept_manager d
JOIN employees e 
ON d.emp_no=e.emp_no
WHERE e.last_name = "Markovitch";


#3. Вывести список сотрудников, имена/фамилии, дату найма, должность в компании, у которых имя начинается на М, а фамилия заканчивается на H.

SELECT e.first_name AS "Имя", e.last_name AS "Фамилия", e.hire_date AS "Дата найма", t.title AS "Должность"
FROM titles t
JOIN employees e 
ON t.emp_no=e.emp_no
WHERE e.first_name LIKE "M%" AND e.last_name LIKE "%h";


#4. Создайте временную таблицу на основе salaries, где у вас будет emp_no и его/ее максимальная и минимальная зарплата за весь период работы в компании.

CREATE TEMPORARY TABLE salaries_tmp (
	emp_no INT,
    min_salary DOUBLE,
    max_salary DOUBLE
	);

INSERT INTO salaries_tmp 
SELECT emp_no, MIN(salary), MAX(salary) FROM salaries
GROUP BY emp_no;

#Проверяем, сколько значений должно было вставиться    
SELECT COUNT(distinct emp_no) FROM salaries;

#Сколько всего сотрудников 
SELECT COUNT(distinct emp_no) FROM employees;

#Далее сделайте JOIN используя эту временную таблицу и таблицу employees чтобы получить список сотрудников, их имена/фамилии, и их мин/макс зарплат.
SELECT e.first_name AS "Имя", e.last_name AS "Фамилия", IFNULL(s.min_salary, "З/П не указана") AS "Минимальная з/п", IFNULL(s.max_salary, "З/П не указана") AS "Максимальная з/п"
FROM employees e 
LEFT JOIN salaries_tmp s
ON e.emp_no=s.emp_no
ORDER BY s.max_salary DESC
LIMIT 500000;

SELECT COUNT(*) AS "Всего сотрудников" ,COUNT(s.min_salary) AS "Кол-во сотрудников с указанной з/п", SUM(CASE WHEN ISNULL(s.min_salary) THEN 1 ELSE 0 END) "Кол-во сотрудников у кого з/п не указана"
FROM employees e 
LEFT JOIN salaries_tmp s
ON e.emp_no=s.emp_no;
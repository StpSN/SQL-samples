#1. Найдите количество сотрудников мужского пола (M) и женского пола (F) и выведите записи в порядке убывания по количеству сотрудников.

SELECT gender AS "Пол", COUNT(emp_no) AS "Кол-во сотрудников"
FROM employees
GROUP BY gender
ORDER BY COUNT(emp_no) DESC;

#2. Найдите среднюю зарплату в разрезе должностей сотрудников (title), округлите эти средние зарплаты до 2 знаков после запятой и выведите записи в порядке убывания.

SELECT t.title AS "Должность", ROUND(AVG(s.salary), 2) AS "Зарплата"
FROM salaries s
JOIN titles t
ON s.emp_no = t.emp_no
GROUP BY t.title
ORDER BY AVG(s.salary) DESC;


#3. Вывести месяцы (от 1 до 12), и количество нанятых сотрудников в эти месяцы.

SELECT month(hire_date) AS "Месяц найма", COUNT(emp_no) AS "Кол-во сотрудников"
FROM employees
GROUP BY month(hire_date)
ORDER BY month(hire_date);


#4.  Сформируйте запрос, который соединяет employees, dept_emp, departments и titles, чтобы показать имена и фамилии сотрудников, названия их отделов и их текущие должности (именно текущие должности, то есть фильтр по таблице titles, столбец to_date).

SELECT e.first_name AS "Имя", e.last_name AS "Фамилия", dp.dept_name AS "Отдел", t.title AS "Должность"
FROM employees e 
JOIN dept_emp d
ON e.emp_no=d.emp_no AND d.to_date>curdate()
JOIN departments dp
ON d.dept_no=dp.dept_no
JOIN titles t
ON t.emp_no=e.emp_no AND t.to_date>curdate();

#5. Используйте Self JOIN в таблице employees, чтобы найти пары сотрудников с одинаковыми фамилиями. Отобразите их имена и фамилии.

SELECT e1.first_name AS "Имя 1", e2.first_name AS "Имя 2", e1.last_name AS "Фамилия"
FROM employees e1
JOIN employees e2
ON e1.last_name=e2.last_name AND e1.first_name > e2.first_name;
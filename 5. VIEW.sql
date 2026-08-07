#1. Создание простого View: Напишите SQL-запрос для создания представления (View), которое отображает имена и фамилии всех сотрудников.

CREATE VIEW emp_names AS
SELECT first_name, last_name FROM employees;

#2. View с JOIN: Создайте представление, которое объединяет таблицы employees и salaries, показывая идентификатор сотрудника, его имя, фамилию и текущую зарплату.

CREATE VIEW emp_names_cur_salaries AS
SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no=s.emp_no
WHERE to_date > curdate();

#3. View для агрегированных данных: Создайте представление, которое показывает среднюю зарплату по каждому отделу.

CREATE VIEW cur_avg_salary_by_dept AS
SELECT d.dept_name, AVG(s.salary) AS avg_salary
FROM salaries s
JOIN dept_emp de
ON s.emp_no=de.emp_no
JOIN departments d
ON de.dept_no=d.dept_no
WHERE s.to_date > curdate() AND de.to_date > curdate()
GROUP BY d.dept_name
ORDER BY avg_salary desc;


#4. Комбинированный View с JOIN и WHERE: Создайте представление, которое отображает информацию о сотрудниках, работающих в отделе 'Sales'

CREATE VIEW employees_cur_in_sales AS
SELECT e.*
FROM employees e
JOIN dept_emp de
ON e.emp_no=de.emp_no
JOIN departments d
ON de.dept_no=d.dept_no
WHERE d.dept_name = 'Sales' and de.to_date > curdate()
ORDER BY e.emp_no;

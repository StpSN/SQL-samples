#1. Найдите всех сотрудников, которые работали как минимум в 2 департаментах. Вывести их имя и фамилию. Показать записи в порядке возрастания.

SELECT * FROM employees
WHERE emp_no IN(
	SELECT emp_no FROM dept_emp
    GROUP BY emp_no
    HAVING COUNT(dept_no) > 1
);

#2. Вывести имя, фамилию и зарплату самого высокооплачиваемого сотрудника.

SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no=s.emp_no
WHERE s.salary IN(
	SELECT MAX(salary) FROM salaries);

#3. Создайте запрос, который выбирает названия всех отделов, в которых работает более 100 сотрудников.

SELECT dept_name FROM departments
WHERE dept_no IN(
	SELECT dept_no 
    FROM dept_emp
    WHERE to_date > curdate()
    GROUP BY dept_no
    HAVING COUNT(emp_no)>100);
    
#4. Напишите запрос, который находит имена и фамилии всех сотрудников, которые никогда не были менеджерами.

SELECT first_name, last_name
FROM employees
WHERE emp_no NOT IN(
	SELECT emp_no
    FROM dept_manager
);

#5. Создайте запрос, который для каждого отдела выводит сотрудников, получающих наибольшую зарплату в этом отделе.

SELECT de.dept_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN dept_emp de
ON e.emp_no=de.emp_no
JOIN salaries s
ON s.emp_no=de.emp_no
WHERE (de.dept_no, salary) IN(
	SELECT dept_no, MAX(s.salary)
    FROM salaries s
    JOIN dept_emp de
    ON s.emp_no=de.emp_no
    WHERE de.to_date > curdate()
    group by de.dept_no)
ORDER BY de.dept_no;

    
#6. Напишите запрос, который выбирает названия отделов, где средняя зарплата выше общей средней зарплаты по компании.

SELECT AVG(salary)
FROM salaries;

SELECT d.dept_name, AVG(s.salary) 
FROM dept_emp de
JOIN salaries s
ON s.emp_no=de.emp_no
JOIN departments d
ON de.dept_no=d.dept_no
WHERE de.to_date > curdate()
group by de.dept_no
HAVING AVG(s.salary) > (SELECT AVG(salary) FROM salaries WHERE to_date > curdate());

#Проверка
SELECT d.dept_name, AVG(s.salary) AS avg_salary_dept, (SELECT AVG(salary) FROM salaries WHERE to_date > curdate()) AS avg_salary, IF(AVG(s.salary) > (SELECT AVG(salary) FROM salaries WHERE to_date > curdate()) , "ЗП выше средней", "ЗП ниже средней") AS "Уровень ЗП"
FROM dept_emp de
JOIN salaries s
ON s.emp_no=de.emp_no
JOIN departments d
ON de.dept_no=d.dept_no
WHERE de.to_date > curdate()
group by de.dept_no
ORDER BY avg_salary_dept DESC; 
#1. Условный оператор IF
#Необходимо выбрать всех сотрудников из таблицы employees и вывести их номер сотрудника , имя и статус сотрудника. Если сотрудник работает более 30 лет, его статус будет "Veteran Employee", в противном случае - "New Employee".

SELECT emp_no AS ID, CONCAT(first_name, ' ', last_name) AS "Имя", timestampdiff(year, hire_date, curdate()) AS "Стаж" , IF(timestampdiff(year, hire_date, curdate())>30, "Veteran Employee", "New Employee") AS "Статус"
FROM employees;

#2. Условный оператор IF
#Необходимо выбрать всех сотрудников из таблицы employees и вывести их возраст. Если возраст сотрудника превышает 63 года, вместо числового значения возраста выводится статус "Пенсионер", в противном случае - "Активный сотрудник".

SELECT *, IF(timestampdiff(year, birth_date, curdate())>63, "Пенсионер","Активный сотрудник") AS "Статус"
FROM employees;

#3. CASE WHEN
#Создайте запрос, который классифицирует сотрудников по возрасту, используя таблицу employees. Предполагается, что "молодой" - младше 30 лет, "средний" - от 30 до 50 лет, "старший" - старше 50 лет.
SELECT *, 
CASE
	WHEN timestampdiff(year, birth_date, curdate())<30 THEN "молодой"
    WHEN timestampdiff(year, birth_date, curdate())<50 THEN "средний"
    ELSE "старший"
END AS "Возраст"
FROM employees;


#4. REGEXP
#Найдите всех сотрудников, чьи имена начинаются на букву 'A' или 'B' в таблице employees.
SELECT * FROM employees
WHERE first_name REGEXP '^[AB]';


#5. Условный оператор IFNULL

CREATE DATABASE IF NOT EXISTS TrainingDB;
USE TrainingDB;

CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    department_id INT,
    performance_rating INT,
    years_of_service INT,
    salary DECIMAL(10, 2)
);


INSERT INTO Employees (first_name, last_name, department_id, performance_rating, years_of_service, salary)
VALUES
('John', 'Doe', 1, NULL, 5, 50000),
('Jane', 'Smith', NULL, 4, 2, NULL),
('Alice', 'Johnson', 2, 3, 8, 75000),
('Bob', 'Brown', NULL, NULL, NULL, 60000),
('Charlie', 'Davis', 3, 2, 10, 40000);

ALTER TABLE Employees ADD COLUMN default_salary DECIMAL(10, 2);
UPDATE Employees SET default_salary = NULL; 
UPDATE Employees SET default_salary = 28000 WHERE employee_id = 1;

#Отобразите список всех сотрудников с именами, отделами и зарплатами. Для сотрудников, у которых не указана зарплата (salary равно NULL), нужно отобразить значение зарплаты как 'Unknown'. 

SELECT 
	employee_id AS ID, 
	CONCAT(first_name, ' ', last_name) AS "Имя", 
    IFNULL(department_id, "Unknown") AS "Отдел", 
    IFNULL(salary, "Unknown") AS "ЗП" 
FROM Employees;

#6. COALESCE (используете БД TrainingDB )
#В таблице Employees могут быть сотрудники, у которых зарплата (salary) не указана. В таком случае необходимо проверить другой столбец, default_salary, который добавили в таблицу для новых сотрудников или стажеров (этот столбец также может содержать NULL). В случае, если и salary, и default_salary равны NULL, тогда присвоить зарплату 25000.
SELECT 
	employee_id AS ID, 
	CONCAT(first_name, ' ', last_name) AS "Имя", 
    IFNULL(department_id, "Unknown") AS "Отдел", 
    coalesce(salary, default_salary, 25000) AS "ЗП" 
FROM Employees;
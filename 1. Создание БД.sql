CREATE DATABASE university;
USE university;
CREATE TABLE Address (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Country VARCHAR(50) NOT NULL,
    County VARCHAR(50) DEFAULT '',
    City VARCHAR(50) NOT NULL,
    Street VARCHAR(50),
    Number INT
);
CREATE TABLE Person (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    PhoneNumber VARCHAR(50),
    BirthDate DATE,
    AdressId INT,
    FOREIGN KEY (AdressId)
        REFERENCES Address (id)
);

CREATE TABLE Student (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Person_id INT NOT NULL,
    Decription VARCHAR(300),
    FOREIGN KEY (Person_id)
        REFERENCES Person (id)
);

CREATE TABLE Teacher (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Position VARCHAR(50),
    Person_id INT NOT NULL,
    FOREIGN KEY (Person_id)
        REFERENCES Person (id)
);

CREATE TABLE Course (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Credits VARCHAR(50),
    Description VARCHAR(300) DEFAULT '',
    Teacher_id INT,
    FOREIGN KEY (Teacher_id)
        REFERENCES Teacher (id)
);

ALTER TABLE Course
MODIFY Name VARCHAR(50) UNIQUE;

INSERT INTO Address (Country, County, City, Street, Number) VALUES
('Россия', 'Московская область', 'Москва', 'Ленинские горы (ГЗ МГУ)', 1),
('Россия', 'Московская область', 'Москва', 'Ломоносовский проспект', 27),
('Россия', 'Московская область', 'Москва', 'проспект Вернадского', 37),
('Россия', 'Московская область', 'Москва', 'Мичуринский проспект', 1),
('Россия', 'Московская область', 'Москва', 'улица Кравченко', 8);

INSERT INTO Person (FirstName, LastName, PhoneNumber, BirthDate, AdressId) VALUES
#Преподаватели
('Виктор', 'Садовничий', '+7(495)939-11-11', '1939-04-03', 1),
('Анатолий', 'Фоменко', '+7(495)939-22-22', '1945-03-13', 2),
('Владимир', 'Арнольд', '+7(495)939-33-33', '1937-06-12', 1),
('Борис', 'Демидович', '+7(495)939-44-44', '1906-03-02', 3),
('Андрей', 'Колмогоров', '+7(495)939-55-55', '1903-04-25', 1),

#Студенты
('Александр', 'Смирнов', '+7(916)123-45-67', '2004-09-01', 4),
('Мария', 'Иванова', '+7(916)234-56-78', '2003-05-15', 5),
('Екатерина', 'Соколова', '+7(916)345-67-89', '2004-11-20', 4),
('Дмитрий', 'Кузнецов', '+7(916)456-78-90', '2002-02-28', 1),
('Михаил', 'Попов', '+7(916)567-89-01', '2005-08-10', 5);

INSERT INTO Student (Person_id, Decription) VALUES
(6, 'Кафедра математического анализа, 2 курс'),
(7, 'Кафедра высшей алгебры, 3 курс'),
(8, 'Кафедра дифференциальных уравнений, 2 курс'),
(9, 'Кафедра теории вероятностей, 4 курс'),
(10, 'Кафедра теоретической механики, 1 курс');

INSERT INTO Teacher (Position, Person_id) VALUES
('Академик РАН, Зав. кафедрой', 1),
('Академик РАН, Профессор', 2),
('Профессор', 3),
('Доцент', 4),
('Академик АН СССР, Профессор', 5);

INSERT INTO Course (Name, Credits, Description, Teacher_id) VALUES
('Математический анализ', '8 ECTS', 'Базовый курс дифференциального и интегрального исчисления', 1),
('Дифференциальная геометрия', '6 ECTS', 'Курс дифференциальной геометрии и топологии', 2),
('Обыкновенные диф. уравнения', '7 ECTS', 'Классическая теория дифференциальных уравнений', 3),
('Уравнения матфизики', '6 ECTS', 'Введение в уравнения в частных производных', 4),
('Теория вероятностей', '5 ECTS', 'Аксиоматика Колмогорова и основы теории вероятностей', 5);

DROP DATABASE university;
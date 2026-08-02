CREATE DATABASE final_project;
USE final_project;

CREATE TABLE uk_bank(
	Customer_ID INT,
    Name VARCHAR(30),
    Surname VARCHAR(30),
    Gender VARCHAR(10),
    Age INT,
    Region VARCHAR(30),
    Job_Classification VARCHAR(50),
    Date_Joined DATE,
    Balance DECIMAL(10,2)
);
SET AUTOCOMMIT=1;
DELETE FROM uk_bank;
SELECT * FROM uk_bank;
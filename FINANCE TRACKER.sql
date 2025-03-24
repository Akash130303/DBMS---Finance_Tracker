create database Finance_Tracker1;
use Finance_Tracker1;

CREATE TABLE user_details (
    User_id INT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    phone_no VARCHAR(255) NOT NULL,
    email_id VARCHAR(255) NOT NULL,
    DOB DATE NOT NULL,
    Street_name VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    pin_code VARCHAR(255)
);

CREATE TABLE expense_details (
    User_id INT,
    expense_no INT,
    PRIMARY KEY (User_id, expense_no),
    FOREIGN KEY (User_id) REFERENCES user_details(User_id),
    Spend_Amount DECIMAL(10, 2),
    Expense_Description VARCHAR(255),
    Expend_Date DATE
);

CREATE TABLE loan (
    loan_id INT PRIMARY KEY,
    User_id INT,
    FOREIGN KEY (User_id) REFERENCES user_details(User_id),
    loan_Amount DECIMAL(10, 2),
    loan_date DATE,
    loan_description VARCHAR(255)
);

CREATE TABLE EMI (
    EMI_ID INT,
    EMI_no INT,
    User_id INT,
    PRIMARY KEY (EMI_ID, EMI_no),
    FOREIGN KEY (User_id) REFERENCES user_details(User_id),
    EMI_amount DECIMAL(10, 2),
    Start_date DATE,
    EMI_description VARCHAR(255)
);


CREATE TABLE account_details (
    Account_No INT PRIMARY KEY,
    User_id INT,
    FOREIGN KEY (User_id) REFERENCES user_details(User_id),
    Balance DECIMAL(10, 2),
    loan_id INT,
    FOREIGN KEY (loan_id) REFERENCES loan(loan_id),
    EMI_ID INT,
    FOREIGN KEY (EMI_ID) REFERENCES EMI(EMI_ID)
);

INSERT INTO user_details (User_id, user_name, phone_no, email_id, DOB, Street_name, city, state, pin_code)  
VALUES 
(101, 'Rajesh Kumar', '9876543210', 'rajesh@example.com', '1985-03-15', '123 Krishna Nagar', 'Delhi', 'Delhi', '110001'),
(102, 'Priya Sharma', '8765432109', 'priya@example.com', '1990-07-20', '456 Gandhi Road', 'Mumbai', 'Maharashtra', '400001'),
(103, 'Amit Patel', '7654321098', 'amit@example.com', '1982-11-10', '789 Nehru Street', 'Ahmedabad', 'Gujarat', '380001'),
(104, 'Deepika Singh', '6543210987', 'deepika@example.com', '1995-05-25', '1010 Tagore Avenue', 'Kolkata', 'West Bengal', '700001'),
(105, 'Suresh Gupta', '5432109876', 'suresh@example.com', '1988-09-12', '111 Jai Nagar', 'Bangalore', 'Karnataka', '560001'),
(106, 'Anjali Mishra', '4321098765', 'anjali@example.com', '1992-12-30', '222 Subhash Road', 'Chennai', 'Tamil Nadu', '600001'),
(107, 'Rahul Verma', '3210987654', 'rahul@example.com', '1980-04-05', '333 Patel Lane', 'Hyderabad', 'Telangana', '500001'),
(108, 'Pooja Reddy', '2109876543', 'pooja@example.com', '1987-08-18', '444 Gandhi Nagar', 'Pune', 'Maharashtra', '411001'),
(109, 'Ravi Kumar', '1098765432', 'ravi@example.com', '1983-06-22', '555 Nehru Street', 'Jaipur', 'Rajasthan', '302001'),
(110, 'Neha Singh', '0987654321', 'neha@example.com', '1991-01-10', '666 Vivekananda Road', 'Lucknow', 'Uttar Pradesh', '226001');

select * from user_details;


CREATE TABLE income (
    User_id INT PRIMARY KEY,
    FOREIGN KEY (User_id) REFERENCES user_details(User_id),
    salary DECIMAL(10, 2),
    freelancing DECIMAL(10, 2),
    interest DECIMAL(10, 2),
    Stock_market DECIMAL(10, 2)
);

ALTER TABLE income ADD Side_Business DECIMAL(10, 2);

ALTER TABLE user_details
ADD COLUMN age varchar(20);

ALTER TABLE user_details MODIFY age int;

UPDATE USER_details
SET age = EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR FROM dob)
where user_id>0;

CREATE VIEW user_address AS
SELECT User_id, user_name, CONCAT_WS(', ', Street_name, city, state, pin_code) AS Address
FROM user_details;

SELECT * FROM user_address;

CREATE TABLE alternate_contact (
    User_id INT PRIMARY KEY,
    alternate_phone_no VARCHAR(255),
    alternate_email_id VARCHAR(255),
    FOREIGN KEY (User_id) REFERENCES user_details(User_id)
);

INSERT INTO alternate_contact (User_id, alternate_phone_no, alternate_email_id)
VALUES 
(101, '9876543210', 'rajesh.alternate@example.com'),
(102, '8765432109', 'priya.alternate@example.com'),
(103, '7654321098', 'amit.alternate@example.com'),
(104, '6543210987', 'deepika.alternate@example.com'),
(105, '5432109876', 'suresh.alternate@example.com'),
(106, '4321098765', 'anjali.alternate@example.com'),
(107, '3210987654', 'rahul.alternate@example.com'),
(108, '2109876543', 'pooja.alternate@example.com'),
(109, '1098765432', 'ravi.alternate@example.com'),
(110, '0987654321', 'neha.alternate@example.com');

CREATE VIEW user_contact_details AS
SELECT u.User_id, u.user_name, u.phone_no AS primary_phone_no, u.email_id AS primary_email_id,
       ac.alternate_phone_no, ac.alternate_email_id
FROM user_details u
LEFT JOIN alternate_contact ac ON u.User_id = ac.User_id;

SELECT * FROM user_contact_details;

INSERT INTO income (User_id, salary, freelancing, interest, Stock_market, Side_Business)
VALUES
(101, 50000.00, 10000.00, 500.00, 2000.00, 3000.00),
(102, 60000.00, 8000.00, 700.00, 2500.00, 1500.00),
(103, 45000.00, 12000.00, 600.00, 1800.00, 2000.00),
(104, 55000.00, 9000.00, 800.00, 2200.00, 2500.00),
(105, 65000.00, 7000.00, 900.00, 2700.00, 3500.00),
(106, 70000.00, 6000.00, 1000.00, 3000.00, 4000.00),
(107, 75000.00, 5000.00, 1100.00, 3500.00, 4500.00),
(108, 80000.00, 4000.00, 1200.00, 4000.00, 5000.00),
(109, 85000.00, 3000.00, 1300.00, 4500.00, 5500.00),
(110, 90000.00, 2000.00, 1400.00, 5000.00, 6000.00);

select * from income;


SELECT User_id, SUM(salary + freelancing + interest + Stock_market + Side_Business) AS Total_Income
FROM income
GROUP BY User_id;

UPDATE income
SET salary = salary + 60000
WHERE User_id IN (101, 102, 103, 104, 105, 106, 107, 108, 109, 110);

UPDATE income
SET Side_Business = Side_Business + 10000
WHERE User_id IN (101, 102, 103, 104, 105, 106, 107, 108, 109, 110);
Select * from income;

INSERT INTO expense_details (User_id, expense_no, Spend_Amount, Expense_Description, Expend_Date)
VALUES
(101, 1, 1500, 'Healthcare', '2024-01-13'),
(101, 2, 15000, 'Rent', '2024-01-01'),
(101, 3, 5000, 'Food & Dining', '2024-01-15'),
(101, 4, 6000, 'Shopping', '2024-01-22'),
(101, 5, 4000, 'Bills', '2024-01-05'),
(101, 6, 1000, 'Healthcare', '2024-02-11'),
(101, 7, 15000, 'Rent', '2024-02-01'),
(101, 8, 6000, 'Food & Dining', '2024-02-17'),
(101, 9, 8000, 'Shopping', '2024-02-24'),
(101, 10, 4300, 'Bills', '2024-02-05'),
(101, 11, 2000, 'Healthcare', '2024-03-12'),
(101, 12, 15000, 'Rent', '2024-03-01'),
(101, 13, 5500, 'Food & Dining', '2024-03-19'),
(101, 14, 3500, 'Shopping', '2024-03-26'),
(101, 15, 4700, 'Bills', '2024-03-05'),
(102, 1, 2000, 'Healthcare', '2024-01-10'),
(102, 2, 12000, 'Rent', '2024-01-01'),
(102, 3, 4100, 'Food & Dining', '2024-01-16'),
(102, 4, 3300, 'Shopping', '2024-01-23'),
(102, 5, 4300, 'Bills', '2024-01-05'),
(102, 6, 1700, 'Healthcare', '2024-02-14'),
(102, 7, 12000, 'Rent', '2024-02-01'),
(102, 8, 6200, 'Food & Dining', '2024-02-18'),
(102, 9, 5000, 'Shopping', '2024-02-21'),
(102, 10, 4500, 'Bills', '2024-02-05'),
(102, 11, 2100, 'Healthcare', '2024-03-12'),
(102, 12, 12000, 'Rent', '2024-03-01'),
(102, 13, 5700, 'Food & Dining', '2024-03-17'),
(102, 14, 3500, 'Shopping', '2024-03-20'),
(102, 15, 4700, 'Bills', '2024-03-05'),
(103, 1, 1700, 'Healthcare', '2024-01-10'),
(103, 2, 10000, 'Rent', '2024-01-01'),
(103, 3, 2700, 'Food & Dining', '2024-01-21'),
(103, 4, 6000, 'Shopping', '2024-01-23'),
(103, 5, 4200, 'Bills', '2024-01-05'),
(103, 6, 1500, 'Healthcare', '2024-02-11'),
(103, 7, 10000, 'Rent', '2024-02-01'),
(103, 8, 3500, 'Food & Dining', '2024-02-23'),
(103, 9, 4500, 'Shopping', '2024-02-25'),
(103, 10, 4800, 'Bills', '2024-02-05'),
(103, 11, 2300, 'Healthcare', '2024-03-12'),
(103, 12, 10000, 'Rent', '2024-03-01'),
(103, 13, 4500, 'Food & Dining', '2024-03-25'),
(103, 14, 3800, 'Shopping', '2024-03-27'),
(103, 15, 3900, 'Bills', '2024-03-05'),
(104, 1, 1500, 'Healthcare', '2024-01-10'),
(104, 2, 13000, 'Rent', '2024-01-01'),
(104, 3, 4200, 'Food & Dining', '2024-01-22'),
(104, 4, 3000, 'Shopping', '2024-01-23'),
(104, 5, 3200, 'Bills', '2024-01-05'),
(104, 6, 2000, 'Healthcare', '2024-02-10'),
(104, 7, 13000, 'Rent', '2024-02-01'),
(104, 8, 3200, 'Food & Dining', '2024-02-18'),
(104, 9, 3500, 'Shopping', '2024-02-27'),
(104, 10, 3450, 'Bills', '2024-02-05'),
(104, 11, 1700, 'Healthcare', '2024-03-10'),
(104, 12, 13000, 'Rent', '2024-03-01'),
(104, 13, 5000, 'Food & Dining', '2024-03-22'),
(104, 14, 4000, 'Shopping', '2024-03-25'),
(104, 15, 3870, 'Bills', '2024-03-05'),
(105, 1, 1500, 'Healthcare', '2024-01-10'),
(105, 2, 14000, 'Rent', '2024-01-01'),
(105, 3, 2500, 'Food & Dining', '2024-01-23'),
(105, 4, 3500, 'Shopping', '2024-01-17'),
(105, 5, 4100, 'Bills', '2024-01-05'),
(105, 6, 1700, 'Healthcare', '2024-02-10'),
(105, 7, 14000, 'Rent', '2024-02-01'),
(105, 8, 2900, 'Food & Dining', '2024-02-24'),
(105, 9, 3000, 'Shopping', '2024-02-19'),
(105, 10, 4300, 'Bills', '2024-02-05'),
(105, 11, 1900, 'Healthcare', '2024-03-10'),
(105, 12, 14000, 'Rent', '2024-03-01'),
(105, 13, 2700, 'Food & Dining', '2024-03-22'),
(105, 14, 3800, 'Shopping', '2024-03-20'),
(105, 15, 4200, 'Bills', '2024-03-05'),
(106, 1, 1600, 'Healthcare', '2024-01-10'),
(106, 2, 12000, 'Rent', '2024-01-01'),
(106, 3, 2300, 'Food & Dining', '2024-01-15'),
(106, 4, 4500, 'Shopping', '2024-01-18'),
(106, 5, 4100, 'Bills', '2024-01-05'),
(106, 6, 1800, 'Healthcare', '2024-02-10'),
(106, 7, 12000, 'Rent', '2024-02-01'),
(106, 8, 2500, 'Food & Dining', '2024-02-15'),
(106, 9, 3500, 'Shopping', '2024-02-23'),
(106, 10, 4200, 'Bills', '2024-02-05'),
(106, 11, 2000, 'Healthcare', '2024-03-10'),
(106, 12, 12000, 'Rent', '2024-03-01'),
(106, 13, 2900, 'Food & Dining', '2024-03-25'),
(106, 14, 3200, 'Shopping', '2024-03-20'),
(106, 15, 4000, 'Bills', '2024-03-05'),
(107, 1, 1900, 'Healthcare', '2024-01-10'),
(107, 2, 9000, 'Rent', '2024-01-01'),
(107, 3, 2600, 'Food & Dining', '2024-01-20'),
(107, 4, 4300, 'Shopping', '2024-01-27'),
(107, 5, 3700, 'Bills', '2024-01-05'),
(107, 6, 1500, 'Healthcare', '2024-02-10'),
(107, 7, 9000, 'Rent', '2024-02-01'),
(107, 8, 2900, 'Food & Dining', '2024-02-27'),
(107, 9, 2800, 'Shopping', '2024-02-25'),
(107, 10, 3900, 'Bills', '2024-02-05'),
(107, 11, 1700, 'Healthcare', '2024-03-10'),
(107, 12, 9000, 'Rent', '2024-03-01'),
(107, 13, 5300, 'Food & Dining', '2024-03-21'),
(107, 14, 4100, 'Shopping', '2024-03-28'),
(107, 15, 3700, 'Bills', '2024-03-05'),
(108, 1, 1500, 'Healthcare', '2024-01-10'),
(108, 2, 8000, 'Rent', '2024-01-01'),
(108, 3, 3000, 'Food & Dining', '2024-01-23'),
(108, 4, 2500, 'Shopping', '2024-01-17'),
(108, 5, 3300, 'Bills', '2024-01-05'),
(108, 6, 1800, 'Healthcare', '2024-02-10'),
(108, 7, 8000, 'Rent', '2024-02-05'),
(108, 8, 3200, 'Food & Dining', '2024-02-20'),
(108, 9, 2900, 'Shopping', '2024-02-15'),
(108, 10, 3400, 'Bills', '2024-02-05'),
(108, 11, 1700, 'Healthcare', '2024-03-10'),
(108, 12, 8000, 'Rent', '2024-03-01'),
(108, 13, 2600, 'Food & Dining', '2024-03-22'),
(108, 14, 7000, 'Shopping', '2024-03-16'),
(108, 15, 3000, 'Bills', '2024-03-05'),
(109, 1, 1900, 'Healthcare', '2024-01-10'),
(109, 2, 12500, 'Rent', '2024-01-01'),
(109, 3, 3000, 'Food & Dining', '2024-01-20'),
(109, 4, 2500, 'Shopping', '2024-01-25'),
(109, 5, 2800, 'Bills', '2024-01-05'),
(109, 6, 1750, 'Healthcare', '2024-02-10'),
(109, 7, 12500, 'Rent', '2024-02-01'),
(109, 8, 2900, 'Food & Dining', '2024-02-22'),
(109, 9, 3500, 'Shopping', '2024-02-28'),
(109, 10, 3000, 'Bills', '2024-02-05'),
(109, 11, 1870, 'Healthcare', '2024-03-10'),
(109, 12, 12500, 'Rent', '2024-03-01'),
(109, 13, 2700, 'Food & Dining', '2024-03-21'),
(109, 14, 3100, 'Shopping', '2024-03-25'),
(109, 15, 3255, 'Bills', '2024-03-05'),
(110, 1, 1650, 'Healthcare', '2024-01-10'),
(110, 2, 13500, 'Rent', '2024-01-01'),
(110, 3, 2750, 'Food & Dining', '2024-01-14'),
(110, 4, 2500, 'Shopping', '2024-01-21'),
(110, 5, 3000, 'Bills', '2024-01-05'),
(110, 6, 1800, 'Healthcare', '2024-02-10'),
(110, 7, 13500, 'Rent', '2024-02-01'),
(110, 8, 3150, 'Food & Dining', '2024-02-17'),
(110, 9, 2700, 'Shopping', '2024-02-23'),
(110, 10, 2850, 'Bills', '2024-02-05'),
(110, 11, 1950, 'Healthcare', '2024-03-10'),
(110, 12, 13500, 'Rent', '2024-03-01'),
(110, 13, 3300, 'Food & Dining', '2024-03-16'),
(110, 14, 2690, 'Shopping', '2024-03-26'),
(110, 15, 3200, 'Bills', '2024-03-05');

Select * from expense_details;

INSERT INTO loan (loan_id, User_id, loan_Amount, loan_date, loan_description)
VALUES
(12010, 101, 50000.00, '2024-03-15', 'Personal Loan'),
(12011, 102, 200000.00, '2024-02-20', 'Home Loan'),
(12012, 103, 450000.00, '2024-01-10', 'Car Loan'),
(12013, 104, 550000.00, '2024-02-25', 'Education Loan'),
(12014, 105, 650000.00, '2024-03-05', 'Business Loan'),
(12015, 106, 70000.00, '2024-01-30', 'Personal Loan'),
(12016, 107, 25000.00, '2024-03-18', 'Home Loan'),
(12017, 108, 500000.00, '2024-02-15', 'Car Loan'),
(12018, 109, 600000.00, '2024-01-20', 'Education Loan'),
(12019, 110, 700000.00, '2024-03-10', 'Business Loan');

select * from loan;

INSERT INTO EMI (EMI_ID, User_id, EMI_no, EMI_amount, Start_date, EMI_description)
VALUES
(124211, 101, 1, 5000.00, '2024-03-01', 'EMI for Personal Loan'),
(124212, 102, 1, 20000.00, '2024-02-05', 'EMI for Home Loan'),
(124213, 103, 1, 4500.00, '2024-01-15', 'EMI for Car Loan'),
(124214, 104, 1, 15000.00, '2024-02-20', 'EMI for Education Loan'),
(124215, 105, 1, 13000.00, '2024-03-01', 'EMI for Business Loan'),
(124216, 106, 1, 12000.00, '2024-01-05', 'EMI for Personal Loan'),
(124217, 107, 1, 1000.00, '2024-03-10', 'EMI for Home Loan'),
(124218, 108, 1, 20000.00, '2024-02-15', 'EMI for Car Loan'),
(124219, 109, 1, 15000.00, '2024-01-20', 'EMI for Education Loan'),
(124220, 110, 1, 25000.00, '2024-03-05', 'EMI for Business Loan');


select * from EMI;

INSERT INTO account_details(Account_No, User_id, Balance, loan_id, EMI_ID)
VALUES
(100001, 101, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 101), 12010, 124211),
(100002, 102, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 102), 12011, 124212),
(100003, 103, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 103), 12012, 124213),
(100004, 104, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 104), 12013, 124214),
(100005, 105, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 105), 12014, 124215),
(100006, 106, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 106), 12015, 124216),
(100007, 107, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 107), 12016, 124217),
(100008, 108, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 108), 12017, 124218),
(100009, 109, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 109), 12018, 124219),
(100010, 110, (SELECT SUM(salary + freelancing + interest + Stock_market + Side_Business) FROM income WHERE User_id = 110), 12019, 124220);

select * from account_details;

SELECT User_id, SUM(salary + freelancing + interest + Stock_market + Side_Business) AS Total_Income
FROM income
GROUP BY User_id;

ALTER TABLE account_details
ADD COLUMN user_name VARCHAR(255);

UPDATE account_details AS a
JOIN user_details AS u ON a.User_id = u.User_id
SET a.user_name = u.user_name
WHERE a.Account_No > 0; 

select * from account_details;

SELECT User_id, SUM(Spend_Amount) AS Total_Expense_January
FROM expense_details
WHERE MONTH(Expend_Date) = 1
GROUP BY User_id;

SELECT User_id, SUM(Spend_Amount) AS Total_Expense_February
FROM expense_details
WHERE MONTH(Expend_Date) = 2
GROUP BY User_id;

SELECT User_id, SUM(Spend_Amount) AS Total_Expense_March
FROM expense_details
WHERE MONTH(Expend_Date) = 3
GROUP BY User_id;

SELECT User_id, Expense_Description, SUM(Spend_Amount) AS Total_Expense_January
FROM expense_details
WHERE MONTH(Expend_Date) = 1
AND (Expense_Description = 'Rent' OR Expense_Description = 'Healthcare')
GROUP BY User_id, Expense_Description;

select user_id,user_name, balance from account_details where balance between 130000 and 140000;

select * from user_details where user_name LIKE 'A%';

SELECT User_id, salary
FROM income
ORDER BY salary DESC;

SELECT *
FROM expense_details
WHERE DATE(Expend_Date) = '2024-01-10';

SELECT *
FROM expense_details
WHERE User_id = 101
AND Expend_Date BETWEEN '2024-01-01' AND '2024-04-01';

SELECT User_id, DAY(Expend_Date) AS Rent_Payment_Date
FROM expense_details
WHERE Expense_Description = 'Rent'
GROUP BY User_id, DAY(Expend_Date);

SELECT User_id, SUM(Spend_Amount) AS Total_Healthcare_Expense
FROM expense_details
WHERE Expense_Description = 'Healthcare'
AND Expend_Date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY User_id;

SELECT User_id, SUM(Spend_Amount) AS Total_Shopping_Expense
FROM expense_details
WHERE Expense_Description = 'Shopping'
AND Expend_Date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY User_id;

SELECT User_id, SUM(Spend_Amount) AS Total_Expense_January_101
FROM expense_details
WHERE User_id = 101
AND MONTH(Expend_Date) = 1
AND YEAR(Expend_Date) = 2024;

SELECT AVG(salary) AS Average_Salary
FROM income;

SELECT l.loan_id, l.User_id, l.loan_Amount, l.loan_description
FROM loan l
WHERE l.loan_Amount = (SELECT MAX(loan_Amount) FROM loan);

SELECT DISTINCT Expense_Description
FROM expense_details;

INSERT INTO user_details (User_id, user_name, phone_no, email_id, DOB, Street_name, city, state, pin_code, age)
VALUES 
(103, 'John Doe', '1234567890', 'john@example.com', '1990-05-20', '789 Oak Street', 'New York', 'New York', '10001', 34);

SELECT Expense_Description FROM expense_details WHERE MONTH(Expend_Date) = 1
UNION
SELECT Expense_Description FROM expense_details WHERE MONTH(Expend_Date) = 2;

SELECT User_id, loan_Amount, loan_description
FROM loan
WHERE loan_Amount > (
    SELECT AVG(loan_Amount)
    FROM loan
);

SELECT u.User_id, u.user_name, l.loan_id, l.loan_Amount, l.loan_description
FROM user_details AS u
LEFT OUTER JOIN loan AS l ON u.User_id = l.User_id;

savepoint a;

update user_details 
set user_name = 'Rajesh Kumar'
where user_id = 101;

select * from user_details where User_id = 101;

rollback to a;

commit;

SELECT PERIOD_DIFF(202404, 202401);

SELECT DATEDIFF("2024-03-31", "2024-01-01");


DELIMITER //

CREATE PROCEDURE fetch_all_data()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    DECLARE user_name VARCHAR(255);
    DECLARE phone_no VARCHAR(255);
    DECLARE email_id VARCHAR(255);
    DECLARE dob DATE;
    DECLARE street_name VARCHAR(255);
    DECLARE city VARCHAR(255);
    DECLARE state VARCHAR(255);
    DECLARE pin_code VARCHAR(255);
    DECLARE age INT;
    
    DECLARE cur CURSOR FOR 
        SELECT User_id, user_name, phone_no, email_id, DOB, Street_name, city, state, pin_code, age 
        FROM user_details;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO user_id, user_name, phone_no, email_id, dob, street_name, city, state, pin_code, age;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT CONCAT('User ID: ', user_id, ', Name: ', user_name, ', Phone No: ', phone_no, ', Email: ', email_id, ', DOB: ', dob, ', Street: ', street_name, ', City: ', city, ', State: ', state, ', Pin Code: ', pin_code, ', Age: ', age);
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;
CALL fetch_all_data();

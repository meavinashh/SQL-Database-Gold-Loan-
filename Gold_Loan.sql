-- Creating and Using Database
create database if not exists Gold_Loan;
use Gold_Loan;

-- Drop Table if exists (Clean State)
drop table if exists branches, customers, goldcollaterals, loan_details, repayments, goldpricehistory;

-- Creating Table Branches
create table branches (
branch_id int primary key not null,
branch_name varchar(255) not null,
city varchar(255) not null,
state varchar(255) not null);

-- Creating Table Customers
create table customers (
customer_id int primary key not null,
branch_id int not null,
name varchar(255) not null,
phone varchar(10) not null,
email varchar(255) unique,
address text not null,
joining_date date not null,
foreign key (branch_id) references branches(branch_id));

-- Creating Table GoldCollaterals
create table goldcollaterals (
collateral_id int primary key not null,
customer_id int not null,
gold_type varchar(255) not null,
gold_carat int not null,
weight_in_grams decimal(10,2) not null,
estimated_price decimal(15,2) not null,
foreign key (customer_id) references customers(customer_id));

-- Creating Table Loan Details
create table loan_details (
loan_id int primary key not null,
branch_id int not null,
customer_id int not null,
collateral_id int not null,
loan_amount decimal(15,2) not null,
intrest_rate decimal(5,2) not null,
settlement_month int not null,
loan_date date not null,
loan_purpose varchar(255),
due_date date not null,
status varchar(20) not null,
foreign key (branch_id) references branches(branch_id),
foreign key (customer_id) references customers(customer_id),
foreign key (collateral_id) references goldcollaterals(collateral_id));

-- Creating Table Repayments
create table repayments (
repayment_id int primary key not null,
loan_id int not null,
amount_paid decimal(15,2) not null,
payment_date date not null,
due_amount decimal(10,2) default 0,
Mop varchar(50) not null,
foreign key (loan_id) references loan_details(loan_id));

-- Creating Table GoldPriceHistory
create table goldpricehistory (
price_id int primary key not null,
date date not null,
price_per_gram decimal(15,2));


-- Inserting Values in All Feilds

-- Branches Feild Values
insert into branches (branch_id, branch_name, city, state) values
(1, 'Bhiwandi Branch', 'Bhiwandi', 'Maharashtra'),
(2, 'Kalyan Branch', 'Kalyan', 'Maharashtra'),
(3, 'Lucknow Branch', 'Lucknow', 'Uttar Pradesh'),
(4, 'Delhi Branch', 'Delhi', 'New Delhi'),
(5, 'Surat Branch', 'Surat', 'Gujrat');

-- Customers Feild Values
insert into customers (customer_id, branch_id, name, phone, email, address, joining_date) values
(101, 1, 'Neeraj Patil', '8754123657', 'neerajpatil101@gmail.com', 'Kalyan', '2025-12-23'),
(102, 2, 'Anay Shrivastav', '9565451252', 'anayshrivastav102@gmail.com', 'Kalyan', '2025-10-21'),
(103, 3, 'Aniket Gupta', '7458521236', 'aniketgupta103@gmail.com', 'Delhi', '2024-09-25'),
(104, 4, 'Sandeep Maheshwari', '8521478745', 'sandeepmaheshwari104@gmail.com', 'Surat', '2024-03-01'),
(105, 5, 'Sanket Patil', '9632547812', 'sanketpatil105@gmail.com', 'Kalyan', '2025-10-15'),
(106, 4, 'Neeraj Chopra', '4587526369', null, 'Lucknow', '2024-02-20'), 
(107, 3, 'Anurag Kashyap', '2563254178', null, 'Delhi', '2024-12-02'),
(108, 1, 'Jashvant Rai', '4578569854', 'jashvantrai108@gmail.com', 'Bhiwandi', '2024-01-14'),
(109, 2, 'Kapil Maheshwari', '2365874589', null, 'Kalyan', '2024-12-26'),
(110, 3, 'Sonia Patil', '6598745215', null, 'Lucknow', '2025-05-27'),
(111, 4, 'Vikas Mishra', '4578121112', null, 'Lucknow', '2024-06-30'),
(112, 1, 'Shivam Tiwari', '1200230125', 'shivamtiwari112@gmail.com', 'Delhi', '2025-08-16'),
(113, 5, 'Dimple Sharma', '3265987452', null, 'Surat', '2025-07-12'),
(114, 3, 'Rachita Jha', '4578986532', null, 'Lucknow', '2024-10-14'),
(115, 1, 'Nikita Sharma', '2363254100', null, 'Lucknow', '2025-05-15');

-- GoldCollaterals Values
insert into goldcollaterals (collateral_id, customer_id, gold_type, gold_carat, weight_in_grams, estimated_price) values
(1, 101, 'Necklace', 22, 50.25, 305000.00),
(2, 102, 'Ring', 18, 10.50, 55000.00),
(3, 103, 'Bracelet', 22, 25.00, 152000.00),
(4, 104, 'Earrings', 20, 15.75, 92000.00),
(5, 105, 'Chain', 24, 35.40, 260000.00),
(6, 106, 'Bangles', 22, 40.00, 240000.00),
(7, 107, 'Necklace', 20, 28.00, 162000.00),
(8, 108, 'Ring', 22, 8.20, 49000.00),
(9, 109, 'Bracelet', 18, 12.50, 70000.00),
(10, 110, 'Earrings', 22, 9.80, 61000.00),
(11, 115, 'Chain', 20, 30.00, 180000.00),
(12, 105, 'Bangles', 24, 45.00, 340000.00),
(13, 113, 'Necklace', 22, 55.00, 320000.00),
(14, 114, 'Ring', 20, 11.25, 66000.00),
(15, 111, 'Bracelet', 22, 22.00, 138000.00),
(16, 112, 'Earrings', 18, 7.50, 42000.00),
(17, 107, 'Chain', 22, 33.40, 200000.00),
(18, 109, 'Bangles', 20, 38.00, 210000.00),
(19, 105, 'Necklace', 24, 48.20, 350000.00),
(20, 103, 'Ring', 22, 9.00, 54000.00);

-- Loan Details Values
insert into loan_details (loan_id, branch_id, customer_id, Collateral_id, loan_amount, intrest_rate, settlement_month, loan_date, loan_purpose, due_date, status) values
(1001, 1, 101, 1, 150000.00, 8.50, 12, '2025-08-01', null, '2026-08-01', 'Active'),
(1002, 2, 102, 2, 80000.00, 7.25, 8, '2025-07-15', 'Education', '2026-03-15', 'Closed'),
(1003, 3, 103, 3, 125000.00, 9.00, 10, '2025-06-20', null, '2026-04-20', 'Active'),
(1004, 1, 114, 4, 50000.00, 6.75, 6, '2025-05-10', null, '2025-11-10', 'Active'),
(1005, 4, 105, 5, 200000.00, 10.00, 15, '2025-04-25', null, '2026-07-25', 'Closed'),
(1006, 5, 106, 6, 95000.00, 8.25, 9, '2025-03-18', 'Medical Treatment', '2025-12-18', 'Active'),
(1007, 1, 107, 7, 60000.00, 7.50, 7, '2025-02-05', null, '2025-09-05', 'Closed'),
(1008, 3, 108, 8, 130000.00, 9.50, 12, '2025-01-12', 'Agriculture', '2026-01-12', 'Active'),
(1009, 2, 111, 9, 75000.00, 6.90, 5, '2024-12-30', 'Home Renovation', '2025-05-30', 'Closed'),
(1010, 4, 110, 10, 50000.00, 8.00, 6, '2024-11-20', null, '2025-05-20', 'Active'),
(1011, 5, 111, 11, 110000.00, 9.75, 10, '2024-10-15', 'Marriage', '2025-08-15', 'Active'),
(1012, 1, 112, 12, 85000.00, 7.10, 8, '2024-09-10', 'Education', '2025-05-10', 'Closed'),
(1013, 2, 113, 13, 140000.00, 8.80, 12, '2024-08-05', null, '2025-08-05', 'Active'),
(1014, 3, 101, 14, 95000.00, 6.50, 7, '2024-07-01', 'Agriculture', '2025-02-01', 'Closed'),
(1015, 4, 115, 15, 105000.00, 9.25, 9, '2024-06-15', null, '2025-03-15', 'Active'),
(1016, 5, 101, 16, 170000.00, 10.50, 14, '2024-05-10', 'Business Expansion', '2025-07-10', 'Closed'),
(1017, 1, 102, 17, 120000.00, 8.40, 11, '2024-04-20', null, '2025-03-20', 'Active'),
(1018, 2, 109, 18, 65000.00, 7.85, 6, '2024-03-25', null, '2024-09-25', 'Closed'),
(1019, 3, 104, 19, 155000.00, 9.60, 12, '2024-02-15', 'Home Renovation', '2025-02-15', 'Active'),
(1020, 4, 105, 20, 90000.00, 8.00, 8, '2024-01-10', null, '2024-09-10', 'Closed');

-- Repayments Values
insert into repayments (repayment_id, loan_id, amount_paid, payment_date, due_amount, mop) values
(1, 1014, 25000.00, '2025-01-15', 0, 'Card'),
(2, 1007, 18000.50, '2025-02-10', 1500.00, 'UPI'),
(3, 1019, 22000.00, '2025-02-18', 0, 'Cash'),
(4, 1003, 30000.00, '2025-03-05', 2000.00, 'Cheque'),
(5, 1016, 15000.00, '2025-03-20', 0, 'Card'),
(6, 1001, 27500.75, '2025-04-12', 500.00, 'UPI'),
(7, 1020, 19000.00, '2025-04-25', 0, 'Cheque'),
(8, 1011, 35000.00, '2025-05-02', 2500.00, 'Cash'),
(9, 1015, 27000.50, '2025-05-15', 0, 'Card'),
(10, 1004, 32000.00, '2025-06-01', 0, 'UPI'),
(11, 1010, 21000.00, '2025-06-10', 1200.00, 'Cheque'),
(12, 1013, 28000.00, '2025-07-03', 0, 'Cash'),
(13, 1006, 26000.00, '2025-07-15', 0, 'Card'),
(14, 1009, 40000.00, '2025-08-01', 3000.00, 'UPI'),
(15, 1008, 18500.00, '2025-08-05', 0, 'Cheque'),
(16, 1018, 29000.50, '2025-08-12', 500.00, 'Cash'),
(17, 1012, 25000.00, '2025-08-20', 0, 'Card'),
(18, 1005, 33000.00, '2025-08-25', 0, 'UPI'),
(19, 1002, 27500.00, '2025-09-02', 2000.00, 'Cheque'),
(20, 1017, 19500.00, '2025-09-08', 0, 'Cash');

-- Gold Price History Values
insert into goldpricehistory (price_id, date, price_per_gram) values
(1, '2024-11-15', 5850.25),
(2, '2025-03-20', 5900.50),
(3, '2024-12-05', 5955.75),
(4, '2025-02-01', 6000.00),
(5, '2024-10-22', 6025.25),
(6, '2025-01-10', 6100.50),
(7, '2024-09-18', 6155.00),
(8, '2025-04-01', 6200.75),
(9, '2024-08-25', 6255.50),
(10, '2025-03-01', 6300.00);

-- Here we see all tables data
select * from branches;
select * from customers;
select * from goldcollaterals;
select * from loan_details;
select * from repayments;
select * from goldpricehistory;

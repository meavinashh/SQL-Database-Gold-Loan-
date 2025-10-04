-- Here we see all tables data
select * from branches;
select * from customers;
select * from goldcollaterals;
select * from loan_details;
select * from repayments;
select * from goldpricehistory;

-- Using transaction for undo any mis entry of query
start transaction;

-- Analyzing Customers according to Branches

-- Total Customers 
select count(customer_id) as Total_Customers
 from customers;

-- Total Customewrs according to per Branch
select b.branch_name, count(c.customer_id) as Total_Customers
from branches b
left join customers c on b.branch_id = c.branch_id
group by b.branch_name;

-- New Customer in 2025
select name, joining_date
 from customers where year(joining_date) = 2025;
 
 -- Updating customer contact detail
 update customers 
 set phone = '8745125258', address = 'Delhi'
 where customer_id = 114;
 
-- Analyzing Loan Details
-- Total Loam Amount Issued
select concat(round(sum(loan_amount)/100000,2),' ' 'Lakhs') as Net_Loan_Amount
 from loan_details;
 
 -- Loan Amount issued by per Branch
select b.branch_name, concat(round(sum(ld.loan_amount)/100000,2), ' ' 'Lakhs') as Total_Loan_Amount
from branches b
left join loan_details ld on ld.branch_id = b.branch_id
group by b.branch_name
order by Total_Loan_Amount desc;
 
 -- Highest Intrest Rate
 select concat(max(intrest_rate),' ' '%') as Highest_inrest from loan_details;
 
 -- Customer with Highest intrtest rate
 select ld.loan_id, c.customer_id, c.name, concat(ld.intrest_rate,' ' '%') 
 from customers c
 join loan_details ld on ld.customer_id = c.customer_id
 where ld.intrest_rate = (select max(intrest_rate) from loan_details);
 
 -- Average Intrest Rate
 select concat(round(avg(intrest_rate),2),' ' '%') as Avg_Intrest_Rate
 from loan_details;

-- Loans which are active and closed
select ld.loan_id, c.customer_id, c.name, ld.status
from customers c, loan_details ld
where c.customer_id = ld.customer_id
group by ld.loan_id, c.customer_id, c.name, ld.status;

-- Total number of Active and Closed Loans
select status, count(loan_id) as Total_Loans
from loan_details
where status in ('Active', 'Closed')
group by status;

-- Loan Amount of Active loans
select ld.loan_id, c.name, concat(round(sum(ld.loan_amount)/100000,2),' ' 'Lakhs') as Total_Loan
from loan_details ld
join customers c on c.customer_id = ld.customer_id
group by ld.loan_id, c.name, ld.status
having ld.status = 'Active'
order by ld.loan_amount desc;

-- Total Loan Amount of Active and Closed Loans 
select status, concat(round(sum(loan_amount)/100000,2),' ' 'Lakhs') as Total_loan_Amount
from loan_details
group by status;

-- Intrest Rate of active Loans
select ld.loan_id, c.name, concat(ld.intrest_rate,' ' '%') as intrest_Rate
from loan_details ld
join customers c on c.customer_id = ld.customer_id
where status = 'Active'
group by ld.loan_id
order by ld.intrest_rate desc;

-- Loan Amount of Closed Loans
select ld.loan_id, c.name, concat(round(sum(ld.loan_amount)/100000,2),' ' 'Lakhs') as Total_Amount
from customers c
join loan_details ld on ld.customer_id = c.customer_id
where ld.status = 'Closed'
group by ld.loan_id, c.name
order by ld.loan_amount desc;

-- Intrest Rate of Closed Loans
select ld.loan_id, c.name, concat(ld.intrest_rate,' ' '%') as Intrest_Rate
from customers c
join loan_details ld on ld.customer_id = c.customer_id
where ld.status = 'Closed'
group by ld.loan_id, c.name
order by ld.intrest_rate desc;

-- Due Date of Loans and Remaining days for due date
select ld.loan_id, c.name, ld.due_date, monthname(ld.due_date) as Due_month, datediff(ld.due_date, ld.loan_date) as Days_Gap
from customers c
join loan_details ld on ld.customer_id = c.customer_id
group by ld.loan_id, c.name
order by Days_Gap desc;

-- Top 5 Loan Issued
select ld.loan_id, c.customer_id, c.name, concat(round(sum(ld.loan_amount)/100000,2),' ' 'Lakhs') as Total_Amount
from customers c
join loan_details ld on ld.customer_id = c.customer_id
group by ld.loan_id, c.customer_id, c.name
order by ld.loan_amount desc limit 5;

-- Goldcollateral Analysis
-- Total Gold Weight Collected for Loan
select sum(weight_in_grams) as Total_Gold_Weight from goldcollaterals;

-- Total Gold Weight by per grams
select b.branch_name, sum(gc.weight_in_grams) as Total_Grams
from goldcollaterals gc
join customers c on c.customer_id = gc.customer_id
join branches b on c.branch_id = b.branch_id
group by b.branch_name
order by Total_Grams desc; 

-- Gold Types, Quality and their Weight by Individual Customers 
select c.customer_id, c.name, gc.gold_type as Gold_Ornaments, concat(gc.gold_carat,' ' 'K') as Carat_of_Gold,
sum(gc.weight_in_grams) as Gold_Weight, concat(round(sum(gc.estimated_price)/100000,2),' ' 'Lakhs') as Estimated_Price
from customers c
join goldcollaterals gc on gc.customer_id = c.customer_id
group by c.name,c.customer_id,Gold_Ornaments,Carat_of_Gold
order by Estimated_Price desc;

-- Customer with Highest Gold values
select c.customer_id, c.name, concat(round(sum(gc.estimated_price)/100000,2),' ' 'Lakhs') as Highest_Values
from customers c
join goldcollaterals gc on gc.customer_id = c.customer_id
group by c.customer_id,c.name
order by Highest_values desc;

-- Customer who taken highest and lowest amount of loan
(
select c.name, concat(round((ld.loan_amount)/100000,2), ' Lakhs') as Loan_Amount, 'Highest' as Type
from customers c
join loan_details ld on c.customer_id = ld.customer_id
where ld.loan_amount = (select max(loan_amount) from loan_details)
limit 1 
)
UNION ALL
(
select c.name, concat(round((ld.loan_amount)/100000,2), ' Lakhs') as Loan_Amount, 'Lowest' as Type
from customers c 
join loan_details ld on c.customer_id = ld.customer_id
where ld.loan_amount = (select min(loan_amount) from loan_details)
limit 1 
);

-- Loans Respect to Estimated Values
select c.customer_id, ld.loan_id, c.name, b.branch_name, concat(gc.gold_carat,' ' 'K') as Carat_of_Gold,
concat(gc.weight_in_grams,' ' 'g') as Gold_Weight, gc.estimated_price, ld.loan_amount,
concat(round(ld.loan_amount / gc.estimated_price * 100,2),' ' '%') as Loan_to_value_ratio
from customers c 
join goldcollaterals gc on gc.customer_id = c.customer_id
join branches b on b.branch_id = c.branch_id
join loan_details ld on gc.collateral_id = ld.collateral_id
where ld.loan_amount <= gc.estimated_price
order by Loan_to_value_ratio desc;

-- Over Valed Loan Respect to Estimated Price
select c.customer_id, ld.loan_id, c.name, b.branch_name, concat(gc.gold_carat,' ' 'K') as Carat_of_Gold,
concat(gc.weight_in_grams,' ' 'g') as Gold_Weight, gc.estimated_price, ld.loan_amount,
concat(round((ld.loan_amount-gc.estimated_price) / ld.loan_amount * 100,2), ' ' '%') as Value_to_loan_ratio
from customers c
join loan_details ld on ld.customer_id = c.customer_id
join branches b on b.branch_id = c.branch_id
join goldcollaterals gc on gc.collateral_id = ld.collateral_id
where ld.loan_amount > gc.estimated_price
order by Value_to_loan_ratio desc;

-- Customers with multiple collaterals
select c.customer_id, c.name, count(gc.collateral_id) as Collateral_count
from goldcollaterals gc
join customers c on c.customer_id = gc.customer_id
group by c.customer_id, c.name
having Collateral_count > 1
order by Collateral_count desc;

-- Loans exceed due dates
select * from loan_details 
where due_date < loan_date and status = 'Active';

-- Repayment Analysis

-- First repayment of customers
select ld.loan_id, c.customer_id, c.name, ld.loan_date as Loan_start, min(ri.payment_date) as First_payment
from customers c
join loan_details ld on c.customer_id = ld.customer_id
join repayments ri on ri.loan_id = ld.loan_id
group by ld.loan_id,c.customer_id,c.name
order by ld.loan_id asc;

-- Total dues
select concat(round(sum(due_amount)/100000,2),' ' 'Lakhs') as Total_Dues from repayments;

-- Total loans and due amount per customers
select c.customer_id, c.name, count(distinct ld.loan_id) as Total_loans, sum(ri.due_amount) as Total_due
from customers c
join loan_details ld on ld.customer_id = c.customer_id
join repayments ri on ri.loan_id = ld.loan_id
group by c.customer_id,c.name
having Total_due > 0
order by Total_due desc;

-- Modes of Payments uses
-- Most used Payment Mode
select mop,count(*) as Payment_count
from repayments
group by mop
order by Payment_count desc;

-- Amount Paid by each Payment mode
select mop, concat(round(sum(amount_paid)/100000,2),' ' 'Lakhs') as Total_paid
from repayments
group by mop
order by Total_paid desc;

-- Analysis of Gold Price History
select date, monthname(date), price_per_gram
from goldpricehistory
order by Price_per_gram desc;







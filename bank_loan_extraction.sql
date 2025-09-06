-- Display Table

select *
from bank_loan_data;

-- A. Bank Loan Report | Summary

-- KPI

-- 1. Loan Applications

-- 1.1 Total Loan Applications

select COUNT(id) as total_loan_applications
from bank_loan_data;

-- 1.2 MTD Loan Applications

select COUNT(id) as MTD_total_applications
from bank_loan_data
where MONTH(issue_date) = 12;

-- 1.3 PMTD Loan Application

select COUNT(id) as PMTD_total_applications
from bank_loan_data
where MONTH(issue_date) = 11;

-- 2. Funded Amount

-- 2.1 Total Funded Amount

select sum(loan_amount) as total_funded_amount
from bank_loan_data;

-- 2.2 MTD Total Funded Amount

select sum(loan_amount) as MTD_total_funded_amount
from bank_loan_data
where MONTH(issue_date) = 12;

-- 2.3 PMTD Total Funded Amount

select sum(loan_amount) as PMTD_total_funded_amount
from bank_loan_data
where MONTH(issue_date) = 11;

-- 3. Amount Received

-- 3.1 Total Amount Received

select sum(total_payment) as total_amount_received
from bank_loan_data;

-- 3.2 MTD Total Amount Received

select sum(total_payment) as MTD_total_amount_received
from bank_loan_data
where MONTH(issue_date) = 12;

-- 3.3 PMTD Total Amount Received

select sum(total_payment) as PMTD_total_amount_received
from bank_loan_data
where MONTH(issue_date) = 11;

-- 4. Average Interest Rate

-- 4.1 Average Interest Rate

select round(avg(int_rate) * 100, 2) as avg_int_rate 
from bank_loan_data;

-- 4.2 MTD Average Interest Rate

select round(avg(int_rate) * 100, 2) as MTD_avg_int_rate 
from bank_loan_data
where MONTH(issue_date) = 12;

-- 4.3 PMTD Average Interest Rate

select round(avg(int_rate) * 100, 2) as PMTD_avg_int_rate 
from bank_loan_data
where MONTH(issue_date) = 11;

-- 5. Average DTI

-- 5.1 Average DTI

select round(avg(dti)*100, 2) as avg_dti
from bank_loan_data;

-- 5.2 MTD Average DTI

select round(avg(dti)*100, 2) as MTD_avg_dti
from bank_loan_data
where MONTH(issue_date) = 12;

-- 5.3 PMTD Average DTI

select round(avg(dti)*100, 2) as PMTD_avg_dti
from bank_loan_data
where MONTH(issue_date) = 11;

-- 6. Good Loan Issued

-- 6.1 Good Loan Percentage

select
cast((count(case
	when loan_status = 'Fully Paid' or loan_status = 'Current' then id
end) * 100.0) / count(id) as decimal(10,2)) as good_loan_percentage
from bank_loan_data;

-- 6.2 Good Loan Applications

select count(id) as good_loan_applications
from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';

-- 6.3 Good Loan Funded Amount

select sum(loan_amount) as good_loan_funded_amount
from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';

-- 6.4 Good Loan Amount Received

select sum(total_payment) as good_loan_amount_received
from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';

-- 7. Bad Loan Issued

-- 7.1 Bad Loan Percentage

select
cast((count(case
	when loan_status = 'Charged Off' then id
end) * 100.0) / count(id) as decimal(10,2)) as bad_loan_percentage
from bank_loan_data;

-- 7.2 Bad Loan Applications

select count(id) as bad_loan_applications
from bank_loan_data
where loan_status = 'Charged Off';

-- 7.3 Bad Loan Funded Amount

select sum(loan_amount) as bad_loan_funded_amount
from bank_loan_data
where loan_status = 'Charged Off';

-- 7.4 Bad Loan Amount Received

select sum(total_payment) as bad_loan_amount_received
from bank_loan_data
where loan_status = 'Charged Off';

-- 8. Loan Status

select 
loan_status,
count(id) as loan_count,
sum(total_payment) as total_amount_received,
sum(loan_amount) as total_funded_amount,
cast(avg(int_rate * 100) as decimal(10,2)) as int_rate,
cast(avg(dti * 100) as decimal(10,2)) as dti
from bank_loan_data
group by loan_status;

select 
loan_status,
SUM(total_payment) as MTD_total_amount_received,
SUM(loan_amount) as MTD_total_funded_amount
from bank_loan_data
where MONTH(issue_date) = 12
group by loan_status;

-- B. Bank Loan Report | Overview

-- 1. Month

select 
MONTH(issue_date) as month_number,
DATENAME(MONTH, issue_date) as month_name,
COUNT(id) as total_loan_applications,
SUM(loan_amount) as total_funded_amount,
SUM(total_payment) as total_amount_received
from bank_loan_data
group by MONTH(issue_date), DATENAME(month, issue_date)
order by month(issue_date);

-- 2. State

select address_state as state,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by address_state
order by address_state;

-- 3. Term

select term,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by term
order by term;

-- 4. Employee length

SELECT emp_length AS employee_Length, 
COUNT(id) AS total_Loan_Applications,
SUM(loan_amount) AS total_Funded_Amount,
SUM(total_payment) AS total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

-- 5. Purpose

SELECT purpose, 
COUNT(id) AS total_loan_applications,
SUM(loan_amount) AS total_funded_amount,
SUM(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

-- 6. Home Ownership

SELECT home_ownership AS home_ownership, 
COUNT(id) AS total_loan_applications,
SUM(loan_amount) AS total_funded_amount,
SUM(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership




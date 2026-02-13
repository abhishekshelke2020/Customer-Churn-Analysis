create database telecom;
use telecom;

select * from churn_data;


--- see the Data type and column names 
select column_name , data_type 
from INFORMATION_SCHEMA.COLUMNS
where table_name = 'churn_data';

--Check Null values
select * from churn_data 
where customerID is null
or
gender is null
or 
SeniorCitizen is null
or
Partner is null
or
Dependents is null
or
tenure is null
or
PhoneService is null
or
MultipleLines is null
or
InternetService is null
or
OnlineSecurity is null
or
OnlineBackup is null
or
DeviceProtection is null
or
TechSupport is null
or
StreamingTV is null
or
StreamingMovies is null
or
Contract is null
or
PaperlessBilling is null
or
PaymentMethod is null
or
MonthlyCharges is null
or
Totalcharges  is null
or
Churn is null;

--Find Duplicate values .
with Dup_cte as (
				select *,
						ROW_NUMBER() over(partition by customerID order by tenure) as count_rows
				from churn_data 
	)
	select * from Dup_cte
	where count_rows > 1;


-- Remove Duplicate Values 
	with Dup_cte as (
				select *,
						ROW_NUMBER() over(partition by customerID order by tenure) as rn
				from churn_data 
	)
	delete from Dup_cte
	where count_rows > 1;


--In Totalcharges column Replace null value with 0 
update churn_data 
set Totalcharges = 0
where Totalcharges is null ;

--Contract column Standardization (month to month to Month-to-month )
update churn_data 
set Contract = 'Month-To-Month'
where Contract = 'month to month' ; 


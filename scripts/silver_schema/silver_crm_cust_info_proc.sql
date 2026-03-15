/*Truncate table silver.crm_cust_info;*/

Insert INTO silver.crm_cust_info (
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_matrial_status,
cst_gndr,
cst_create_date)

select
cst_id,
cst_key,
trim(cst_firstname) as cst_firstname,
trim(cst_lastname) as cst_lastname,
case when Upper (trim(cst_matrial_status)) ='F' then 'Female'
	 when Upper (trim(cst_matrial_status)) ='M' then 'Male'
	 else 'N/A'
end cst_matrial_status,

case when Upper (trim(cst_gndr)) ='F' then 'Female'
	 when Upper (trim(cst_gndr)) ='M' then 'Male'
	 else 'N/A'
end cst_gndr,
cst_create_date
from(
select *,
ROW_NUMBER () over(partition by cst_id order by cst_create_date desc) as flag_last
from bronze.crm_cust_info
where cst_id is not Null)t 
where flag_last =1

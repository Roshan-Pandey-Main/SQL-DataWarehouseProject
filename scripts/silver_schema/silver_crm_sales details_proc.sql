Insert Into silver.crm_sales_details(
[sls_ord_num]
      ,[sls_prd_key]
      ,[sls_cust_id]
      ,[sls_order_dt]
      ,[sls_ship_dt]
      ,[sls_due_dt]
      ,[sls_sales]
      ,[sls_quantity]
      ,[sls_price])
select
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt =0 or len(sls_order_dt) !=8 then Null
	 else cast(cast(sls_order_dt As varchar) as date)
end sls_order_dt,
case when sls_ship_dt =0 or len(sls_ship_dt) !=8 then Null
	 else cast(cast(sls_ship_dt As varchar) as date)
end sls_ship_dt,
case when sls_due_dt =0 or len(sls_due_dt) !=8 then Null
	 else cast(cast(sls_due_dt As varchar) as date)
end sls_due_dt,
case when sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity* ABS(sls_price)
	then sls_quantity * Abs(sls_price)
	else sls_sales
end as sls_sales,
case when sls_price is null or sls_price<=0
then sls_sales /nullif(sls_quantity,0)
else sls_price
end as sls_price,
sls_quantity
from bronze.crm_sales_details

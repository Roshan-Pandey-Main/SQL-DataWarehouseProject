insert silver.erp_px_cat_g1v2(id,cat,subcat,maintenance)
select
id,
cat,
subcat,
maintenance
from bronze.erp_px_cat_g1v2
------------------------------------------------------------
insert into silver.erp_loc_a101(cid,cntry)
select
Replace(cid,'-','')cid,
case when trim(cntry)='DE' then 'Germany'
	when trim(cntry) in ('US','USA') then'United States'
	when trim(cntry) ='' or cntry is null then 'n/a'
	else trim(cntry)
end as cntry
from bronze.erp_loc_a101
----------------------------------------------------------------------
insert into silver.erp_cust_az12(cid,bdate,gen)
select
case when cid like'NAS%' then SUBSTRING(cid,4,len(cid))
else cid
end cid,
case when bdate> getdate() then null
else bdate
end Bdate,
case when upper(trim(gen)) in ('F','Female')then 'Female'
     when upper(trim(gen)) in ('M','Male')then 'Male'
     else 'N/A'
end as gen
from bronze.erp_cust_az12


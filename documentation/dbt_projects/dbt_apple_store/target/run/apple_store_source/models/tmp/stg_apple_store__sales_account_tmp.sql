
  create or replace   view TEST.PUBLIC_apple_store_source.stg_apple_store__sales_account_tmp
  
   as (
    select * 
from TEST.itunes_connect.sales_account
  );


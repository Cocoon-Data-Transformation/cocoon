
  create or replace   view TEST.PUBLIC_apple_store_source.stg_apple_store__app_store_device_tmp
  
   as (
    select * 
from TEST.itunes_connect.app_store_source_type_device_report
  );



  create or replace   view TEST.PUBLIC_apple_store_source.stg_apple_store__usage_device_tmp
  
   as (
    select * 
from TEST.itunes_connect.usage_source_type_device_report
  );


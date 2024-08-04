
  create or replace   view TEST.PUBLIC_apple_store_source.stg_apple_store__crashes_platform_version_tmp
  
   as (
    select * 
from TEST.itunes_connect.crashes_platform_version_device_report
  );


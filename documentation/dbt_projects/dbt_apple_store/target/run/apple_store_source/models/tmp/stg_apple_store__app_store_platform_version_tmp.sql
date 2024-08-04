
  create or replace   view TEST.PUBLIC_apple_store_source.stg_apple_store__app_store_platform_version_tmp
  
   as (
    select * 
from TEST.itunes_connect.app_store_platform_version_source_type_report
  );


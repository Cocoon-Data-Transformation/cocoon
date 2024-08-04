
  create or replace   view TEST.PUBLIC_apple_store_source.stg_apple_store__usage_territory_tmp
  
   as (
    select * 
from TEST.itunes_connect.usage_territory_source_type_report
  );


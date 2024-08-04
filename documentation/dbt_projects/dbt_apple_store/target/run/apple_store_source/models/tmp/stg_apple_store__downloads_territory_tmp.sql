
  create or replace   view TEST.PUBLIC_apple_store_source.stg_apple_store__downloads_territory_tmp
  
   as (
    select * 
from TEST.itunes_connect.downloads_territory_source_type_report
  );


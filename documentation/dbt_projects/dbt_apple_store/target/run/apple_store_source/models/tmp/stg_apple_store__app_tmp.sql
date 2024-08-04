
  create or replace   view TEST.PUBLIC_apple_store_source.stg_apple_store__app_tmp
  
   as (
    select * 
from TEST.itunes_connect.app
  );



  create or replace   view TEST.PUBLIC__source_amplitude.stg_amplitude__event_type_tmp
  
   as (
    select * 
from TEST.amplitude.event_type
  );


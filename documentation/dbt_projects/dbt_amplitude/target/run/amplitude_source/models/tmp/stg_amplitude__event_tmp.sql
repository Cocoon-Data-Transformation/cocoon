
  create or replace   view TEST.PUBLIC__source_amplitude.stg_amplitude__event_tmp
  
   as (
    select * 
from TEST.amplitude.event
  );


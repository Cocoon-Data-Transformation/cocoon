
    
    

select
    unique_event_type_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC__source_amplitude.stg_amplitude__event_type
where unique_event_type_id is not null
group by unique_event_type_id
having count(*) > 1



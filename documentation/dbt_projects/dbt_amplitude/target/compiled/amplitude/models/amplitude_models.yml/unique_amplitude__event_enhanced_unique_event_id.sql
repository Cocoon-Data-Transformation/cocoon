
    
    

select
    unique_event_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_amplitude.amplitude__event_enhanced
where unique_event_id is not null
group by unique_event_id
having count(*) > 1



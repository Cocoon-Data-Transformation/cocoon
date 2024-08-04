
    
    

select
    unique_session_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_amplitude.amplitude__sessions
where unique_session_id is not null
group by unique_session_id
having count(*) > 1



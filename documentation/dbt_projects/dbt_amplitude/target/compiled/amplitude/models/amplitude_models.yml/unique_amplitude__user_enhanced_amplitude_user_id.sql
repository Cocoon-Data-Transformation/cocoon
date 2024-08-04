
    
    

select
    amplitude_user_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_amplitude.amplitude__user_enhanced
where amplitude_user_id is not null
group by amplitude_user_id
having count(*) > 1



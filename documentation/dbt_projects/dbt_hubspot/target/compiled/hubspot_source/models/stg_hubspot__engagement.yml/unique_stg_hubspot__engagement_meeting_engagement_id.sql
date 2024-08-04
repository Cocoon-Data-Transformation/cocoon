
    
    

select
    engagement_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_meeting
where engagement_id is not null
group by engagement_id
having count(*) > 1



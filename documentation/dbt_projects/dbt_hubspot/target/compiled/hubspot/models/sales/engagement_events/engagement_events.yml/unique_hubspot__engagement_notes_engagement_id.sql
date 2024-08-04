
    
    

select
    engagement_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_hubspot.hubspot__engagement_notes
where engagement_id is not null
group by engagement_id
having count(*) > 1



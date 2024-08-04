
    
    

select
    email_campaign_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_campaign
where email_campaign_id is not null
group by email_campaign_id
having count(*) > 1



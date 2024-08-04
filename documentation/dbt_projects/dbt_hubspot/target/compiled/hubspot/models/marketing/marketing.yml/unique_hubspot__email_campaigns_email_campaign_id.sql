
    
    

select
    email_campaign_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_hubspot.hubspot__email_campaigns
where email_campaign_id is not null
group by email_campaign_id
having count(*) > 1



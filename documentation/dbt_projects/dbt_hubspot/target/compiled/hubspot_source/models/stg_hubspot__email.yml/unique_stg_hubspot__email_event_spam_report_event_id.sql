
    
    

select
    event_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_spam_report
where event_id is not null
group by event_id
having count(*) > 1



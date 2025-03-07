
    
    

with __dbt__cte__int_hubspot__email_event_aggregates as (


with events as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event

), aggregates as (

    select
        sent_by_event_id as email_send_id,
        count(case when event_type = 'OPEN' then sent_by_event_id end) as opens,
        count(case when event_type = 'SENT' then sent_by_event_id end) as sends,
        count(case when event_type = 'DELIVERED' then sent_by_event_id end) as deliveries,
        count(case when event_type = 'DROPPED' then sent_by_event_id end) as drops,
        count(case when event_type = 'CLICK' then sent_by_event_id end) as clicks,
        count(case when event_type = 'FORWARD' then sent_by_event_id end) as forwards,
        count(case when event_type = 'DEFERRED' then sent_by_event_id end) as deferrals,
        count(case when event_type = 'BOUNCE' then sent_by_event_id end) as bounces,
        count(case when event_type = 'SPAMREPORT' then sent_by_event_id end) as spam_reports,
        count(case when event_type = 'PRINT' then sent_by_event_id end) as prints
    from events
    where sent_by_event_id is not null
    group by 1

)

select *
from aggregates
) select
    email_send_id as unique_field,
    count(*) as n_records

from __dbt__cte__int_hubspot__email_event_aggregates
where email_send_id is not null
group by email_send_id
having count(*) > 1



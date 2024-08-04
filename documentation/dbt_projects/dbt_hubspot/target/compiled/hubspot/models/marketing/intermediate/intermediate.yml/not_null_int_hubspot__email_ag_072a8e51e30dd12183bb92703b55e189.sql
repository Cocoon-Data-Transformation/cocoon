
    
    



with __dbt__cte__int_hubspot__email_aggregate_status_change as (


with base as (

    select *
    from TEST.PUBLIC_hubspot.hubspot__email_event_status_change

), aggregates as (

    select
        email_campaign_id,
        email_send_id,
        count(case when subscription_status = 'UNSUBSCRIBED' then 1 end) as unsubscribes
    from base
    where email_send_id is not null
    group by 1,2

)

select *
from aggregates
) select email_send_id
from __dbt__cte__int_hubspot__email_aggregate_status_change
where email_send_id is null



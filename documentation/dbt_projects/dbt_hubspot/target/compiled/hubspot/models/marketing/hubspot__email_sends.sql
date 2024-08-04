

with  __dbt__cte__int_hubspot__email_event_aggregates as (


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
),  __dbt__cte__int_hubspot__email_aggregate_status_change as (


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
), sends as (

    select *
    from TEST.PUBLIC_hubspot.hubspot__email_event_sent

), metrics as (

    select *
    from __dbt__cte__int_hubspot__email_event_aggregates

), joined as (

    select
        sends.*,
        coalesce(metrics.bounces,0) as bounces,
        coalesce(metrics.clicks,0) as clicks,
        coalesce(metrics.deferrals,0) as deferrals,
        coalesce(metrics.deliveries,0) as deliveries,
        coalesce(metrics.drops,0) as drops,
        coalesce(metrics.forwards,0) as forwards,
        coalesce(metrics.opens,0) as opens,
        coalesce(metrics.prints,0) as prints,
        coalesce(metrics.spam_reports,0) as spam_reports
    from sends
    left join metrics using (email_send_id)

), booleans as (

    select 
        *,
        bounces > 0 as was_bounced,
        clicks > 0 as was_clicked,
        deferrals > 0 as was_deferred,
        deliveries > 0 as was_delivered,
        forwards > 0 as was_forwarded,
        opens > 0 as was_opened,
        prints > 0 as was_printed,
        spam_reports > 0 as was_spam_reported
    from joined



), unsubscribes as (

    select *
    from __dbt__cte__int_hubspot__email_aggregate_status_change

), unsubscribes_joined as (

    select 
        booleans.*,
        coalesce(unsubscribes.unsubscribes,0) as unsubscribes,
        coalesce(unsubscribes.unsubscribes,0) > 0 as was_unsubcribed
    from booleans
    left join unsubscribes using (email_send_id)

)

select *
from unsubscribes_joined


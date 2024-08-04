


with campaigns as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_campaign

), email_sends as (

    select *
    from TEST.PUBLIC_hubspot.hubspot__email_sends

), email_metrics as (
    
    select 
        email_campaign_id,
        
    from email_sends
    group by 1

), joined as (

    select 
        campaigns.*,
        
    from campaigns
    left join email_metrics
        on campaigns.email_campaign_id = email_metrics.email_campaign_id

)

select *
from joined
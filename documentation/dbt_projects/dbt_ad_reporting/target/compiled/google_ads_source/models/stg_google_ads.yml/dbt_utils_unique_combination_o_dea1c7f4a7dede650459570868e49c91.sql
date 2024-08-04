





with validation_errors as (

    select
        source_relation, campaign_id, ad_network_type, device, date_day
    from TEST.PUBLIC_google_ads_source.stg_google_ads__campaign_stats
    group by source_relation, campaign_id, ad_network_type, device, date_day
    having count(*) > 1

)

select *
from validation_errors



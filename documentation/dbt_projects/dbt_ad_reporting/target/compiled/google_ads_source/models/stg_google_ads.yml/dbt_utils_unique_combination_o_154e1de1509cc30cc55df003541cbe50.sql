





with validation_errors as (

    select
        source_relation, ad_group_id, device, ad_network_type, date_day
    from TEST.PUBLIC_google_ads_source.stg_google_ads__ad_group_stats
    group by source_relation, ad_group_id, device, ad_network_type, date_day
    having count(*) > 1

)

select *
from validation_errors



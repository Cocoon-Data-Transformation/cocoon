





with validation_errors as (

    select
        source_relation, ad_id, ad_network_type, device, ad_group_id, keyword_ad_group_criterion, date_day
    from TEST.PUBLIC_google_ads_source.stg_google_ads__ad_stats
    group by source_relation, ad_id, ad_network_type, device, ad_group_id, keyword_ad_group_criterion, date_day
    having count(*) > 1

)

select *
from validation_errors



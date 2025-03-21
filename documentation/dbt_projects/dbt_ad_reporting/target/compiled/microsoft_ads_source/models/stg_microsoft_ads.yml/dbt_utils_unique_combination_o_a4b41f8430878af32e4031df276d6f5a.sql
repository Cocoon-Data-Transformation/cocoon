





with validation_errors as (

    select
        source_relation, date_day, account_id, campaign_id, ad_group_id, ad_id, keyword_id, search_query, device_os, device_type, network, language, bid_match_type, delivered_match_type, top_vs_other
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__search_daily_report
    group by source_relation, date_day, account_id, campaign_id, ad_group_id, ad_id, keyword_id, search_query, device_os, device_type, network, language, bid_match_type, delivered_match_type, top_vs_other
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, date_day, account_id, campaign_id, device_os, device_type, network, currency_code, ad_distribution, bid_match_type, delivered_match_type, top_vs_other, budget_association_status, budget_name, budget_status
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__campaign_daily_report
    group by source_relation, date_day, account_id, campaign_id, device_os, device_type, network, currency_code, ad_distribution, bid_match_type, delivered_match_type, top_vs_other, budget_association_status, budget_name, budget_status
    having count(*) > 1

)

select *
from validation_errors



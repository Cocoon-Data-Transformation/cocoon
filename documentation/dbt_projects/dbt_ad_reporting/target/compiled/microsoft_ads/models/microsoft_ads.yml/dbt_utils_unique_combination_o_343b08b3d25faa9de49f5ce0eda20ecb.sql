





with validation_errors as (

    select
        source_relation, date_day, account_id, campaign_id, ad_group_id, ad_id, ad_type, device_os, device_type, network, currency_code
    from TEST.PUBLIC_microsoft_ads.microsoft_ads__ad_report
    group by source_relation, date_day, account_id, campaign_id, ad_group_id, ad_id, ad_type, device_os, device_type, network, currency_code
    having count(*) > 1

)

select *
from validation_errors



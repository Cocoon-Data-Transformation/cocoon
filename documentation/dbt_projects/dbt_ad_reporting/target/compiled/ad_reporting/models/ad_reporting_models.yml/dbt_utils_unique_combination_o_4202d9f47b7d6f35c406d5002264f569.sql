





with validation_errors as (

    select
        source_relation, platform, date_day, ad_group_id, campaign_id, account_id, base_url, url_host, url_path, utm_campaign, utm_content, utm_medium, utm_source, utm_term
    from TEST.PUBLIC_ad_reporting.ad_reporting__url_report
    group by source_relation, platform, date_day, ad_group_id, campaign_id, account_id, base_url, url_host, url_path, utm_campaign, utm_content, utm_medium, utm_source, utm_term
    having count(*) > 1

)

select *
from validation_errors



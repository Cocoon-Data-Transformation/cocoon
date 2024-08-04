





with validation_errors as (

    select
        source_relation, platform, date_day, search_query, search_match_type, keyword_id, ad_group_id, campaign_id, account_id
    from TEST.PUBLIC_ad_reporting.ad_reporting__search_report
    group by source_relation, platform, date_day, search_query, search_match_type, keyword_id, ad_group_id, campaign_id, account_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, date_day, click_url, ad_id, account_id, ad_group_id, campaign_id, post_id, currency
    from TEST.PUBLIC_reddit_ads.reddit_ads__url_report
    group by source_relation, date_day, click_url, ad_id, account_id, ad_group_id, campaign_id, post_id, currency
    having count(*) > 1

)

select *
from validation_errors



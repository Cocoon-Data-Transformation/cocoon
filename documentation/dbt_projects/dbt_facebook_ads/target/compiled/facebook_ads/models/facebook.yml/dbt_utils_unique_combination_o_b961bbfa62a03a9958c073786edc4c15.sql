





with validation_errors as (

    select
        source_relation, date_day, account_id, campaign_id, ad_set_id
    from TEST.PUBLIC_facebook_ads.facebook_ads__ad_set_report
    group by source_relation, date_day, account_id, campaign_id, ad_set_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, pin_promotion_id, ad_group_id, campaign_id, advertiser_id, date_day
    from TEST.PUBLIC_pinterest.pinterest_ads__url_report
    group by source_relation, pin_promotion_id, ad_group_id, campaign_id, advertiser_id, date_day
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, date_day, pin_promotion_id, ad_group_id, campaign_id, advertiser_id
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__pin_promotion_report
    group by source_relation, date_day, pin_promotion_id, ad_group_id, campaign_id, advertiser_id
    having count(*) > 1

)

select *
from validation_errors



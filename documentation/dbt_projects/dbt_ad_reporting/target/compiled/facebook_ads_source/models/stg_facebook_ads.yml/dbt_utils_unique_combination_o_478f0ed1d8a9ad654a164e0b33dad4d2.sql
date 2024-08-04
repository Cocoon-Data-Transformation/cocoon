





with validation_errors as (

    select
        source_relation, date_day, ad_id, account_id
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__basic_ad
    group by source_relation, date_day, ad_id, account_id
    having count(*) > 1

)

select *
from validation_errors



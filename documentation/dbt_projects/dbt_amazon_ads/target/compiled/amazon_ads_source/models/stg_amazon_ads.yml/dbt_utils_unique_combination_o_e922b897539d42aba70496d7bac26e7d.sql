





with validation_errors as (

    select
        source_relation, ad_group_id, date_day
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__ad_group_level_report
    group by source_relation, ad_group_id, date_day
    having count(*) > 1

)

select *
from validation_errors



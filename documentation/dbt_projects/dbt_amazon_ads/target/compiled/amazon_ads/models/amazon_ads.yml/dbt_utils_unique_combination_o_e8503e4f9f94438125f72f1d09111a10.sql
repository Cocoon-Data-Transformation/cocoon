





with validation_errors as (

    select
        source_relation, date_day, ad_group_id
    from TEST.PUBLIC_amazon_ads.amazon_ads__ad_group_report
    group by source_relation, date_day, ad_group_id
    having count(*) > 1

)

select *
from validation_errors



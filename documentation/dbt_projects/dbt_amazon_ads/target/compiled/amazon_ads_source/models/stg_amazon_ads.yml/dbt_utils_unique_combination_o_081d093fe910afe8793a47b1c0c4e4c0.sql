





with validation_errors as (

    select
        source_relation, ad_group_id, last_updated_date
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__ad_group_history
    group by source_relation, ad_group_id, last_updated_date
    having count(*) > 1

)

select *
from validation_errors



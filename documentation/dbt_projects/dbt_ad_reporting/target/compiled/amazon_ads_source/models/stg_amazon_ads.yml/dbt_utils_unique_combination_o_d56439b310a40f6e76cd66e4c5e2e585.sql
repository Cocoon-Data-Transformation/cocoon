





with validation_errors as (

    select
        source_relation, ad_id, last_updated_date
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__product_ad_history
    group by source_relation, ad_id, last_updated_date
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, keyword_id, last_updated_date
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__keyword_history
    group by source_relation, keyword_id, last_updated_date
    having count(*) > 1

)

select *
from validation_errors



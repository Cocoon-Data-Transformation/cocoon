





with validation_errors as (

    select
        source_relation, ad_group_id
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__ad_group
    group by source_relation, ad_group_id
    having count(*) > 1

)

select *
from validation_errors



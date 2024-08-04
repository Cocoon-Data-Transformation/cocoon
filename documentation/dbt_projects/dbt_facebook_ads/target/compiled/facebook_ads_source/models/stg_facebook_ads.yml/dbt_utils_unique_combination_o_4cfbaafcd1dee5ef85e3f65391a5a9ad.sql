





with validation_errors as (

    select
        source_relation, _fivetran_id
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__creative_history
    group by source_relation, _fivetran_id
    having count(*) > 1

)

select *
from validation_errors



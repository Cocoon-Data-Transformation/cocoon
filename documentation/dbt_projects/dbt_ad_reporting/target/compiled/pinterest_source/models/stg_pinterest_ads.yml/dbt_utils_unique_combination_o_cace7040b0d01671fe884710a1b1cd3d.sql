





with validation_errors as (

    select
        source_relation, _fivetran_synced, pin_promotion_id
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__pin_promotion_history
    group by source_relation, _fivetran_synced, pin_promotion_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, ad_group_id, _fivetran_synced
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__ad_group_history
    group by source_relation, ad_group_id, _fivetran_synced
    having count(*) > 1

)

select *
from validation_errors



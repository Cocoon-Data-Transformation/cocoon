





with validation_errors as (

    select
        user_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__user
    group by user_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



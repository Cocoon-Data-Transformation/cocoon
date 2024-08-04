





with validation_errors as (

    select
        distribution_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__distribution
    group by distribution_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



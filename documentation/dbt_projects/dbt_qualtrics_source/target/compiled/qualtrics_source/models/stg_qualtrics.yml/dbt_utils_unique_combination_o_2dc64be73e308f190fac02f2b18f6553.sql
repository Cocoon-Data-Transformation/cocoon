





with validation_errors as (

    select
        directory_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__directory
    group by directory_id, source_relation
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        _fivetran_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__question_response
    group by _fivetran_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



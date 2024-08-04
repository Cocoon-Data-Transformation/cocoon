





with validation_errors as (

    select
        response_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__survey_response
    group by response_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



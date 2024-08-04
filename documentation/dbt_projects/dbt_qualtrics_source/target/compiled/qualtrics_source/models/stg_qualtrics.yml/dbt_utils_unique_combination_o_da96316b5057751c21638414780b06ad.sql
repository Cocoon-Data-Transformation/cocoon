





with validation_errors as (

    select
        question_id, survey_id, key, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__question_option
    group by question_id, survey_id, key, source_relation
    having count(*) > 1

)

select *
from validation_errors



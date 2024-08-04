





with validation_errors as (

    select
        block_id, question_id, survey_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__block_question
    group by block_id, question_id, survey_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



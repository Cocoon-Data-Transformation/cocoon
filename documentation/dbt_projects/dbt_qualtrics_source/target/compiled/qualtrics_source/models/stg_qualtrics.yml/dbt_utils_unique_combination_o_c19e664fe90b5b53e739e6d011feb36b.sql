





with validation_errors as (

    select
        survey_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__survey
    group by survey_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



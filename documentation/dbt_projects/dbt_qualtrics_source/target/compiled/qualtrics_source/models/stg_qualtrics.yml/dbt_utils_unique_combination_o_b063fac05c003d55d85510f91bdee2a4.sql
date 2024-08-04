





with validation_errors as (

    select
        version_id, survey_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__survey_version
    group by version_id, survey_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



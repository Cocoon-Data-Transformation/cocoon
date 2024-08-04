





with validation_errors as (

    select
        import_id, response_id, key, value, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__survey_embedded_data
    group by import_id, response_id, key, value, source_relation
    having count(*) > 1

)

select *
from validation_errors



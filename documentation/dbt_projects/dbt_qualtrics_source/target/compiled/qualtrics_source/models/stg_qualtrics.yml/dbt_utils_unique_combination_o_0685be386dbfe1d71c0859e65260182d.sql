





with validation_errors as (

    select
        contact_id, directory_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__directory_contact
    group by contact_id, directory_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



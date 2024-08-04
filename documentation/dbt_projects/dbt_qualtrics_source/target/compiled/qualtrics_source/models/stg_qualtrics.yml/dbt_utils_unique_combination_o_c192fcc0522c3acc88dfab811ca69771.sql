





with validation_errors as (

    select
        contact_id, distribution_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__distribution_contact
    group by contact_id, distribution_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



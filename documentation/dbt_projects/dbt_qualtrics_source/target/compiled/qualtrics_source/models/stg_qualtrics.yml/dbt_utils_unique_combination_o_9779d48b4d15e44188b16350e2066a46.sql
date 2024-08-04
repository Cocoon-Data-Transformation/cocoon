





with validation_errors as (

    select
        contact_lookup_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__contact_mailing_list_membership
    group by contact_lookup_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



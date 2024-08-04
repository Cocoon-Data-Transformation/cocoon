





with validation_errors as (

    select
        mailing_list_id, directory_id, source_relation
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__directory_mailing_list
    group by mailing_list_id, directory_id, source_relation
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, date_day, advertiser_id
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__advertiser_report
    group by source_relation, date_day, advertiser_id
    having count(*) > 1

)

select *
from validation_errors



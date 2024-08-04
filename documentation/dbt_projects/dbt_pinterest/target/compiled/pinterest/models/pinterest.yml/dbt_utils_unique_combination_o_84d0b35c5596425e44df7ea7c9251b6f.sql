





with validation_errors as (

    select
        source_relation, advertiser_id, date_day
    from TEST.PUBLIC_pinterest.pinterest_ads__advertiser_report
    group by source_relation, advertiser_id, date_day
    having count(*) > 1

)

select *
from validation_errors



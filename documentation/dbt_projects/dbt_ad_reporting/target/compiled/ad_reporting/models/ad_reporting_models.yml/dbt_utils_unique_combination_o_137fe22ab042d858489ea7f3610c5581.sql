





with validation_errors as (

    select
        source_relation, platform, date_day, account_id
    from TEST.PUBLIC_ad_reporting.ad_reporting__account_report
    group by source_relation, platform, date_day, account_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, date_day, profile_id
    from TEST.PUBLIC_amazon_ads.amazon_ads__account_report
    group by source_relation, date_day, profile_id
    having count(*) > 1

)

select *
from validation_errors



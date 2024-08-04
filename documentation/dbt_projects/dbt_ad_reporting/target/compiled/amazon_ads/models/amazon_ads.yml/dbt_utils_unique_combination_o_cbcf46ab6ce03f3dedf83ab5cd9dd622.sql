





with validation_errors as (

    select
        source_relation, date_day, portfolio_id
    from TEST.PUBLIC_amazon_ads.amazon_ads__portfolio_report
    group by source_relation, date_day, portfolio_id
    having count(*) > 1

)

select *
from validation_errors



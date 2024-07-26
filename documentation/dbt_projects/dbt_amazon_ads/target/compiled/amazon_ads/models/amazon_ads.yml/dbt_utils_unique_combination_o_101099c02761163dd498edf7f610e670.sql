





with validation_errors as (

    select
        source_relation, date_day, search_term, keyword_id
    from TEST.PUBLIC_amazon_ads.amazon_ads__search_report
    group by source_relation, date_day, search_term, keyword_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, ad_squad_id, date_day
    from TEST.PUBLIC_snapchat_ads.snapchat_ads__ad_squad_report
    group by source_relation, ad_squad_id, date_day
    having count(*) > 1

)

select *
from validation_errors



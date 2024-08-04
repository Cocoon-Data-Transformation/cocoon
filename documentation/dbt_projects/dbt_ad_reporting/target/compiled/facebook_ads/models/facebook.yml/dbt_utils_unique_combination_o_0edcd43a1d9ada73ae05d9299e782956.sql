





with validation_errors as (

    select
        source_relation, _fivetran_id, key, type
    from TEST.PUBLIC_facebook_ads.facebook_ads__url_tags
    group by source_relation, _fivetran_id, key, type
    having count(*) > 1

)

select *
from validation_errors



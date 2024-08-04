





with validation_errors as (

    select
        source_relation, search_term_text, match_type, date_day, keyword_id, ad_group_id, campaign_id, organization_id
    from TEST.PUBLIC_apple_search_ads.apple_search_ads__search_term_report
    group by source_relation, search_term_text, match_type, date_day, keyword_id, ad_group_id, campaign_id, organization_id
    having count(*) > 1

)

select *
from validation_errors



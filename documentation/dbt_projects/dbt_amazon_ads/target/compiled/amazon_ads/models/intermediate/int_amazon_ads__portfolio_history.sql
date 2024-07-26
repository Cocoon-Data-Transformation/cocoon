



with portfolios as (
    select
    
        *
        from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__portfolio_history
        where is_most_recent_record = True
    
)

select * 
from portfolios
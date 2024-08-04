

with transactions as (
    select 
        *,
        md5(cast(coalesce(cast(source_relation as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(transaction_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as transactions_unique_id
    from TEST.PUBLIC_stg_shopify.stg_shopify__transaction

    

), tender_transactions as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__tender_transaction

), joined as (
    select 
        transactions.*,
        tender_transactions.payment_method,
        parent_transactions.created_timestamp as parent_created_timestamp,
        parent_transactions.kind as parent_kind,
        parent_transactions.amount as parent_amount,
        parent_transactions.status as parent_status
    from transactions
    left join tender_transactions
        on transactions.transaction_id = tender_transactions.transaction_id
        and transactions.source_relation = tender_transactions.source_relation
    left join transactions as parent_transactions
        on transactions.parent_id = parent_transactions.transaction_id
        and transactions.source_relation = parent_transactions.source_relation

), exchange_rate as (

    select
        *,
        coalesce(cast(nullif(

  parse_json( receipt )['charges']['data'][0]['balance_transaction']['exchange_rate'], '') as numeric(28,6) ),1) as exchange_rate,
        coalesce(cast(nullif(

  parse_json( receipt )['charges']['data'][0]['balance_transaction']['exchange_rate'], '') as numeric(28,6) ),1) * amount as currency_exchange_calculated_amount
    from joined

)

select *
from exchange_rate
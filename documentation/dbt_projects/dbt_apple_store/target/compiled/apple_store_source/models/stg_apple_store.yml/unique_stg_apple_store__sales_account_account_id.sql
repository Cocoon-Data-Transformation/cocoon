
    
    

select
    account_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_apple_store_source.stg_apple_store__sales_account
where account_id is not null
group by account_id
having count(*) > 1



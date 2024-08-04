
    
    

select
    app_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_apple_store_source.stg_apple_store__app
where app_id is not null
group by app_id
having count(*) > 1



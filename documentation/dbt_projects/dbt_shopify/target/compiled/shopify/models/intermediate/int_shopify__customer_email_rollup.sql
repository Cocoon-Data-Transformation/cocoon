with customers as (

    select 
        *,
        row_number() over(
            partition by 


    email


            order by created_timestamp desc) 
            as customer_index

    from TEST.PUBLIC_stg_shopify.stg_shopify__customer
    where email is not null -- nonsensical to include any null emails here

), customer_tags as (

    select 
        *
    from TEST.PUBLIC_stg_shopify.stg_shopify__customer_tag

), rollup_customers as (

    select
        -- fields to group by
        lower(customers.email) as email,
        customers.source_relation,

        -- fields to string agg together
        
    listagg(distinct cast(customers.customer_id as TEXT), ', ')

 as customer_ids,
        
    listagg(distinct cast(customers.phone as TEXT), ', ')

 as phone_numbers,
        
    listagg(distinct cast(customer_tags.value as TEXT), ', ')

 as customer_tags,

        -- fields to take aggregates of
        min(customers.created_timestamp) as first_account_created_at,
        max(customers.created_timestamp) as last_account_created_at,
        max(customers.updated_timestamp) as last_updated_at,
        max(customers.marketing_consent_updated_at) as marketing_consent_updated_at,
        max(customers._fivetran_synced) as last_fivetran_synced,

        -- take true if ever given for boolean fields
        

    max( case when customers.customer_index = 1 then customers.is_tax_exempt else null end )

 as is_tax_exempt, -- since this changes every year
        

    max( customers.is_verified_email )

 as is_verified_email

        -- for all other fields, just take the latest value
        
        
        

    from customers 
    left join customer_tags
        on customers.customer_id = customer_tags.customer_id
        and customers.source_relation = customer_tags.source_relation

    group by 1,2

)

select *
from rollup_customers
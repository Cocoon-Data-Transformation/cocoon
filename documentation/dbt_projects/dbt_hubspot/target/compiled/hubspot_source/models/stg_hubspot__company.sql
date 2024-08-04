

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__company_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as company_id , 
    cast(null as boolean) as is_company_deleted , 
    cast(null as TEXT) as company_name , 
    cast(null as TEXT) as description , 
    cast(null as timestamp) as created_date , 
    cast(null as TEXT) as industry , 
    cast(null as TEXT) as street_address , 
    cast(null as TEXT) as street_address_2 , 
    cast(null as TEXT) as city , 
    cast(null as TEXT) as state , 
    cast(null as TEXT) as country , 
    cast(null as integer) as company_annual_revenue 


    from base

), fields as (

    select


        -- just default columns + explicitly configured passthrough columns
        -- a few columns below are aliased within the macros/get_company_columns.sql macro
        company_id,
        is_company_deleted,
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        company_name,
        description,
        created_date,
        industry,
        street_address,
        street_address_2,
        city,
        state,
        country,
        company_annual_revenue
        
        --The below macro adds the fields defined within your hubspot__ticket_pass_through_columns variable into the staging model
        





        -- The below macro add the ability to create calculated fields using the hubspot__company_calculated_fields variable.
        


        
    from macro



), joined as (
    

select fields.*

from fields
)

select *
from joined
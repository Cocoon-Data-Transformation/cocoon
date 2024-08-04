

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__contact_tmp

), macro as (

    select
        
    cast(null as boolean) as is_contact_deleted , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as contact_id , 
    cast(null as TEXT) as calculated_merged_vids , 
    cast(null as TEXT) as email , 
    cast(null as TEXT) as contact_company , 
    cast(null as TEXT) as first_name , 
    cast(null as TEXT) as last_name , 
    cast(null as timestamp) as created_date , 
    cast(null as TEXT) as job_title , 
    cast(null as integer) as company_annual_revenue 


    from base

), fields as (

    select


        -- just default columns + explicitly configured passthrough columns.
        -- a few columns below are aliased within the macros/get_contact_columns.sql macro
        contact_id,
        is_contact_deleted,
        calculated_merged_vids, -- will be null for BigQuery users until v3 api is rolled out to them
        email,
        contact_company,
        first_name,
        last_name,
        cast(created_date as timestamp) as created_date,
        job_title,
        company_annual_revenue,
        cast(_fivetran_synced as timestamp) as _fivetran_synced

        --The below macro adds the fields defined within your hubspot__contact_pass_through_columns variable into the staging model
        





        -- The below macro add the ability to create calculated fields using the hubspot__contact_calculated_fields variable.
        



    from macro
    

), joined as (
    

select fields.*

from fields
)

select *
from joined
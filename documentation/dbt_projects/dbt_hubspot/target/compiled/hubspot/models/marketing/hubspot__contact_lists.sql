

with contact_lists as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__contact_list



), email_metrics as (

    select *
    from TEST.PUBLIC_hubspot.int_hubspot__email_metrics__by_contact_list

), joined as (
    
    select 
        contact_lists.*,
        
    from contact_lists
    left join email_metrics
        using (contact_list_id)

)

select *
from joined


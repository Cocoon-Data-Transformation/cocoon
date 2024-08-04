

with email_sends as (

    select *
    from TEST.PUBLIC_hubspot.hubspot__email_sends

), contact_list_member as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__contact_list_member

), joined as (

    select
        email_sends.*,
        contact_list_member.contact_list_id
    from email_sends
    left join contact_list_member
        using (contact_id)
    where contact_list_member.contact_list_id is not null

), email_metrics as (
    
    select 
        contact_list_id,
        
    from joined
    group by 1

)

select *
from email_metrics
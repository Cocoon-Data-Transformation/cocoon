

with contacts as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__contact
), contact_merge_audit as (

    
    select
        contacts.contact_id,
        split_part(merges.value, ':', 0) as vid_to_merge
    
    from contacts
    cross join 
        table(flatten(STRTOK_TO_ARRAY(calculated_merged_vids, ';'))) as merges






), contact_merge_removal as (
    select 
        contacts.*
    from contacts
    
    left join contact_merge_audit
        on cast(contacts.contact_id as TEXT) = cast(contact_merge_audit.vid_to_merge as TEXT)
    
    where contact_merge_audit.vid_to_merge is null
)

select *
from contact_merge_removal
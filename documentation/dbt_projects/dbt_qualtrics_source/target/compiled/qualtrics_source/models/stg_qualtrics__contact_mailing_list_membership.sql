with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__contact_mailing_list_membership_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    contact_id
    
 , 
    cast(null as TEXT) as 
    
    contact_lookup_id
    
 , 
    cast(null as TEXT) as 
    
    directory_id
    
 , 
    cast(null as TEXT) as 
    
    mailing_list_id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    owner_id
    
 , 
    cast(null as timestamp) as 
    
    unsubscribe_date
    
 , 
    cast(null as boolean) as 
    
    unsubscribed
    
 



        


, cast('' as TEXT) as source_relation



        
    from base
),

final as (
    
    select 
        contact_id,
        contact_lookup_id,
        directory_id,
        mailing_list_id,
        name,
        owner_id as owner_user_id,
        cast(unsubscribe_date as timestamp) as unsubscribed_at,
        unsubscribed as is_unsubscribed,
        _fivetran_synced,
        source_relation

    from fields
)

select *
from final
with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__user_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    account_creation_date
    
 , 
    cast(null as timestamp) as 
    
    account_expiration_date
    
 , 
    cast(null as TEXT) as 
    
    account_status
    
 , 
    cast(null as TEXT) as 
    
    division_id
    
 , 
    cast(null as TEXT) as 
    
    email
    
 , 
    cast(null as TEXT) as 
    
    first_name
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    language
    
 , 
    cast(null as timestamp) as 
    
    last_login_date
    
 , 
    cast(null as TEXT) as 
    
    last_name
    
 , 
    cast(null as TEXT) as 
    
    organization_id
    
 , 
    cast(null as timestamp) as 
    
    password_expiration_date
    
 , 
    cast(null as timestamp) as 
    
    password_last_changed_date
    
 , 
    cast(null as integer) as 
    
    response_count_auditable
    
 , 
    cast(null as integer) as 
    
    response_count_deleted
    
 , 
    cast(null as integer) as 
    
    response_count_generated
    
 , 
    cast(null as TEXT) as 
    
    time_zone
    
 , 
    cast(null as boolean) as 
    
    unsubscribed
    
 , 
    cast(null as TEXT) as 
    
    user_type
    
 , 
    cast(null as TEXT) as 
    
    username
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        cast(account_creation_date as timestamp) as account_created_at,
        cast(account_expiration_date as timestamp) as account_expires_at,
        account_status,
        division_id,
        email,
        first_name,
        id as user_id,
        language,
        cast(last_login_date as timestamp) as last_login_at,
        last_name,
        organization_id,
        cast(password_expiration_date as timestamp) as password_expires_at,
        cast(password_last_changed_date as timestamp) as password_last_changed_at,
        response_count_auditable,
        response_count_deleted,
        response_count_generated,
        time_zone,
        unsubscribed as is_unsubscribed,
        user_type,
        username,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation
    from fields
)

select *
from final
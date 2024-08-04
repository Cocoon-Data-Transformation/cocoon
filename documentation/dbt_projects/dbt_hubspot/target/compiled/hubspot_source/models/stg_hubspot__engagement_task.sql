

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_task_tmp

), macro as (

    select
        
        
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as integer) as 
    
    engagement_id
    
 , 
    cast(null as TEXT) as engagement_type , 
    cast(null as timestamp) as created_timestamp , 
    cast(null as timestamp) as occurred_timestamp , 
    cast(null as integer) as owner_id , 
    cast(null as integer) as team_id 


         
            
        
        

        
        

 
        
    from base
)

select *
from macro
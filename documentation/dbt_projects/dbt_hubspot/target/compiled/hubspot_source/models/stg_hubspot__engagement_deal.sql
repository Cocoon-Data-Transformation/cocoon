

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_deal_tmp

), macro as (

    select
        
        
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    deal_id
    
 , 
    cast(null as integer) as 
    
    engagement_id
    
 


         
            
        
        

        
        

 
        
    from base

)

select *
from macro
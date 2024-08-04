with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__t880_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as numeric(28,6)) as 
    
    _fivetran_rowid
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    city
    
 , 
    cast(null as TEXT) as 
    
    cntry
    
 , 
    cast(null as TEXT) as 
    
    curr
    
 , 
    cast(null as TEXT) as 
    
    glsip
    
 , 
    cast(null as TEXT) as 
    
    indpo
    
 , 
    cast(null as TEXT) as 
    
    langu
    
 , 
    cast(null as TEXT) as 
    
    lccomp
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as TEXT) as 
    
    mclnt
    
 , 
    cast(null as TEXT) as 
    
    mcomp
    
 , 
    cast(null as TEXT) as 
    
    modcp
    
 , 
    cast(null as TEXT) as 
    
    name1
    
 , 
    cast(null as TEXT) as 
    
    name2
    
 , 
    cast(null as TEXT) as 
    
    pobox
    
 , 
    cast(null as TEXT) as 
    
    pstlc
    
 , 
    cast(null as TEXT) as 
    
    rcomp
    
 , 
    cast(null as TEXT) as 
    
    resta
    
 , 
    cast(null as TEXT) as 
    
    rform
    
 , 
    cast(null as TEXT) as 
    
    stret
    
 , 
    cast(null as TEXT) as 
    
    strt2
    
 , 
    cast(null as TEXT) as 
    
    zweig
    
 


    from base
),

final as (

    select
        cast(mandt as TEXT) as mandt,
        rcomp,
        name1
    from fields
)

select * 
from final
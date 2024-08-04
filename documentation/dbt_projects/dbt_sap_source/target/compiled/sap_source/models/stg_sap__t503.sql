with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__t503_tmp
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
    
    abart
    
 , 
    cast(null as TEXT) as 
    
    abtyp
    
 , 
    cast(null as TEXT) as 
    
    aksta
    
 , 
    cast(null as TEXT) as 
    
    ansta
    
 , 
    cast(null as TEXT) as 
    
    antyp
    
 , 
    cast(null as TEXT) as 
    
    austa
    
 , 
    cast(null as TEXT) as 
    
    burkz
    
 , 
    cast(null as TEXT) as 
    
    inwid
    
 , 
    cast(null as TEXT) as 
    
    konty
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as TEXT) as 
    
    molga
    
 , 
    cast(null as TEXT) as 
    
    persg
    
 , 
    cast(null as TEXT) as 
    
    persk
    
 , 
    cast(null as TEXT) as 
    
    trfkz
    
 , 
    cast(null as TEXT) as 
    
    typsz
    
 , 
    cast(null as TEXT) as 
    
    zeity
    
 


    from base
),

final as (

    select    
        mandt,
        persg,
        persk,
        abart,
        abtyp,
        aksta,
        ansta,
        antyp,
        austa,
        burkz,
        inwid,
        konty,
        molga,
        trfkz,
        typsz,
        zeity
    from fields
)

select * 
from final
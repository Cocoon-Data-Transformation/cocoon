with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__ska1_tmp
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
    
    bilkt
    
 , 
    cast(null as TEXT) as 
    
    erdat
    
 , 
    cast(null as TEXT) as 
    
    ernam
    
 , 
    cast(null as TEXT) as 
    
    func_area
    
 , 
    cast(null as TEXT) as 
    
    gvtyp
    
 , 
    cast(null as TEXT) as 
    
    ktoks
    
 , 
    cast(null as TEXT) as 
    
    ktopl
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as TEXT) as 
    
    mcod1
    
 , 
    cast(null as TEXT) as 
    
    mustr
    
 , 
    cast(null as TEXT) as 
    
    sakan
    
 , 
    cast(null as TEXT) as 
    
    saknr
    
 , 
    cast(null as TEXT) as 
    
    vbund
    
 , 
    cast(null as TEXT) as 
    
    xbilk
    
 , 
    cast(null as TEXT) as 
    
    xloev
    
 , 
    cast(null as TEXT) as 
    
    xspea
    
 , 
    cast(null as TEXT) as 
    
    xspeb
    
 , 
    cast(null as TEXT) as 
    
    xspep
    
 


    from base
),

final as (
    
    select 
        mandt,
        ktopl,
        saknr,
        bilkt,
        gvtyp,
        vbund,
        xbilk,
        sakan,
        erdat,
        ernam,
        ktoks,
        xloev,
        xspea,
        xspeb,
        xspep,
        func_area,
        mustr,	
        _fivetran_rowid,
        _fivetran_deleted,
        _fivetran_synced
    from fields
)

select *
from final
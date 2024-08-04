with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__pa0000_tmp
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
    
    aedtm
    
 , 
    cast(null as TEXT) as 
    
    begda
    
 , 
    cast(null as TEXT) as 
    
    endda
    
 , 
    cast(null as TEXT) as 
    
    flag1
    
 , 
    cast(null as TEXT) as 
    
    flag2
    
 , 
    cast(null as TEXT) as 
    
    flag3
    
 , 
    cast(null as TEXT) as 
    
    flag4
    
 , 
    cast(null as TEXT) as 
    
    grpvl
    
 , 
    cast(null as TEXT) as 
    
    histo
    
 , 
    cast(null as TEXT) as 
    
    itbld
    
 , 
    cast(null as TEXT) as 
    
    itxex
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as TEXT) as 
    
    massg
    
 , 
    cast(null as TEXT) as 
    
    massn
    
 , 
    cast(null as TEXT) as 
    
    objps
    
 , 
    cast(null as TEXT) as 
    
    ordex
    
 , 
    cast(null as TEXT) as 
    
    pernr
    
 , 
    cast(null as TEXT) as 
    
    preas
    
 , 
    cast(null as TEXT) as 
    
    refex
    
 , 
    cast(null as TEXT) as 
    
    rese1
    
 , 
    cast(null as TEXT) as 
    
    rese2
    
 , 
    cast(null as TEXT) as 
    
    seqnr
    
 , 
    cast(null as TEXT) as 
    
    sprps
    
 , 
    cast(null as TEXT) as 
    
    stat1
    
 , 
    cast(null as TEXT) as 
    
    stat2
    
 , 
    cast(null as TEXT) as 
    
    stat3
    
 , 
    cast(null as TEXT) as 
    
    subty
    
 , 
    cast(null as TEXT) as 
    
    uname
    
 


    from base
),

final as (
    
    select
        mandt,
        pernr,
        subty,
        objps,
        sprps,
        endda,
        begda,
        seqnr,
        aedtm,
        flag1,
        flag2,
        flag3,
        flag4,
        grpvl,
        histo,
        itbld,
        itxex,
        massg,
        massn,
        ordex,
        preas,
        refex,
        rese1,
        rese2,
        stat1,
        stat2,
        stat3,
        uname
    from fields
)

select *
from final
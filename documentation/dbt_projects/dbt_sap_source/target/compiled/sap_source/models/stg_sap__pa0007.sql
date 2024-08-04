with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__pa0007_tmp
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
    cast(null as numeric(28,6)) as 
    
    arbst
    
 , 
    cast(null as TEXT) as 
    
    awtyp
    
 , 
    cast(null as TEXT) as 
    
    begda
    
 , 
    cast(null as TEXT) as 
    
    dysch
    
 , 
    cast(null as numeric(28,6)) as 
    
    empct
    
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
    cast(null as numeric(28,6)) as 
    
    jrstd
    
 , 
    cast(null as TEXT) as 
    
    kztim
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as numeric(28,6)) as 
    
    maxja
    
 , 
    cast(null as numeric(28,6)) as 
    
    maxmo
    
 , 
    cast(null as numeric(28,6)) as 
    
    maxta
    
 , 
    cast(null as numeric(28,6)) as 
    
    maxwo
    
 , 
    cast(null as numeric(28,6)) as 
    
    minja
    
 , 
    cast(null as numeric(28,6)) as 
    
    minmo
    
 , 
    cast(null as numeric(28,6)) as 
    
    minta
    
 , 
    cast(null as numeric(28,6)) as 
    
    minwo
    
 , 
    cast(null as numeric(28,6)) as 
    
    mostd
    
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
    
    schkz
    
 , 
    cast(null as TEXT) as 
    
    seqnr
    
 , 
    cast(null as TEXT) as 
    
    sprps
    
 , 
    cast(null as TEXT) as 
    
    subty
    
 , 
    cast(null as TEXT) as 
    
    teilk
    
 , 
    cast(null as TEXT) as 
    
    uname
    
 , 
    cast(null as numeric(28,6)) as 
    
    wkwdy
    
 , 
    cast(null as numeric(28,6)) as 
    
    wostd
    
 , 
    cast(null as TEXT) as 
    
    wweek
    
 , 
    cast(null as TEXT) as 
    
    zterf
    
 


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
        arbst,
        awtyp,
        dysch,
        empct,
        flag1,
        flag2,
        flag3,
        flag4,
        grpvl,
        histo,
        itbld,
        itxex,
        jrstd,
        kztim,
        maxja,
        maxmo,
        maxta,
        maxwo,
        minja,
        minmo,
        minta,
        minwo,
        mostd,
        ordex,
        preas,
        refex,
        rese1,
        rese2,
        schkz,
        teilk,
        uname,
        wkwdy,
        wostd,
        wweek,
        zterf
    from fields
)

select *
from final
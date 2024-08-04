with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__faglflexa_tmp
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
    
    activ
    
 , 
    cast(null as TEXT) as 
    
    awtyp
    
 , 
    cast(null as TEXT) as 
    
    belnr
    
 , 
    cast(null as TEXT) as 
    
    bschl
    
 , 
    cast(null as TEXT) as 
    
    bstat
    
 , 
    cast(null as TEXT) as 
    
    budat
    
 , 
    cast(null as TEXT) as 
    
    buzei
    
 , 
    cast(null as TEXT) as 
    
    cost_elem
    
 , 
    cast(null as TEXT) as 
    
    docln
    
 , 
    cast(null as TEXT) as 
    
    docnr
    
 , 
    cast(null as TEXT) as 
    
    drcrk
    
 , 
    cast(null as TEXT) as 
    
    gjahr
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl
    
 , 
    cast(null as TEXT) as 
    
    kokrs
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl
    
 , 
    cast(null as TEXT) as 
    
    linetype
    
 , 
    cast(null as TEXT) as 
    
    logsys
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl
    
 , 
    cast(null as TEXT) as 
    
    poper
    
 , 
    cast(null as TEXT) as 
    
    pprctr
    
 , 
    cast(null as TEXT) as 
    
    prctr
    
 , 
    cast(null as TEXT) as 
    
    psegment
    
 , 
    cast(null as TEXT) as 
    
    racct
    
 , 
    cast(null as TEXT) as 
    
    rassc
    
 , 
    cast(null as TEXT) as 
    
    rbukrs
    
 , 
    cast(null as TEXT) as 
    
    rbusa
    
 , 
    cast(null as TEXT) as 
    
    rclnt
    
 , 
    cast(null as TEXT) as 
    
    rcntr
    
 , 
    cast(null as TEXT) as 
    
    rfarea
    
 , 
    cast(null as TEXT) as 
    
    rldnr
    
 , 
    cast(null as TEXT) as 
    
    rmvct
    
 , 
    cast(null as TEXT) as 
    
    rrcty
    
 , 
    cast(null as TEXT) as 
    
    rtcur
    
 , 
    cast(null as TEXT) as 
    
    runit
    
 , 
    cast(null as TEXT) as 
    
    rvers
    
 , 
    cast(null as TEXT) as 
    
    rwcur
    
 , 
    cast(null as TEXT) as 
    
    ryear
    
 , 
    cast(null as TEXT) as 
    
    sbusa
    
 , 
    cast(null as TEXT) as 
    
    scntr
    
 , 
    cast(null as TEXT) as 
    
    segment
    
 , 
    cast(null as TEXT) as 
    
    sfarea
    
 , 
    cast(null as numeric(28,6)) as faglflexa_timestamp , 
    cast(null as numeric(28,6)) as 
    
    tsl
    
 , 
    cast(null as TEXT) as 
    
    usnam
    
 , 
    cast(null as numeric(28,6)) as 
    
    wsl
    
 , 
    cast(null as TEXT) as 
    
    xsplitmod
    
 , 
    cast(null as TEXT) as 
    
    zzspreg
    
 


    from base
),

final as (   

    select
        cast(rclnt as TEXT) as rclnt,
        ryear,
        docnr,
        cast(rldnr as TEXT) as rldnr,
        cast(rbukrs as TEXT) as rbukrs,
        docln,
        activ,
        rmvct,
        rtcur,
        runit,
        awtyp,
        rrcty,
        rvers,
        logsys,
        racct,
        cost_elem,
        rcntr,
        prctr,
        rfarea,
        rbusa,
        kokrs,
        segment,
        scntr,
        pprctr,
        sfarea,
        sbusa,
        rassc,
        psegment,
        tsl,
        hsl,
        ksl,
        osl,
        msl,
        wsl,
        drcrk,
        poper,
        rwcur,
        cast(gjahr as TEXT) as gjahr,
        budat,
        cast(belnr as TEXT) as belnr,
        cast(buzei as TEXT) as buzei,
        bschl,
        bstat,
        faglflexa_timestamp,
        _fivetran_synced
    from fields
)

select * 
from final
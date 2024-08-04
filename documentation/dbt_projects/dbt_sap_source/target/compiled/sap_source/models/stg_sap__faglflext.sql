with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__faglflext_tmp
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
    
    cost_elem
    
 , 
    cast(null as TEXT) as 
    
    drcrk
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl01
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl02
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl03
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl04
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl05
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl06
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl07
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl08
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl09
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl10
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl11
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl12
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl13
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl14
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl15
    
 , 
    cast(null as numeric(28,6)) as 
    
    hsl16
    
 , 
    cast(null as numeric(28,6)) as 
    
    hslvt
    
 , 
    cast(null as TEXT) as 
    
    kokrs
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl01
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl02
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl03
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl04
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl05
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl06
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl07
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl08
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl09
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl10
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl11
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl12
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl13
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl14
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl15
    
 , 
    cast(null as numeric(28,6)) as 
    
    ksl16
    
 , 
    cast(null as numeric(28,6)) as 
    
    kslvt
    
 , 
    cast(null as TEXT) as 
    
    logsys
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl01
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl02
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl03
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl04
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl05
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl06
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl07
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl08
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl09
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl10
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl11
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl12
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl13
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl14
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl15
    
 , 
    cast(null as numeric(28,6)) as 
    
    msl16
    
 , 
    cast(null as numeric(28,6)) as 
    
    mslvt
    
 , 
    cast(null as numeric(28,6)) as 
    
    objnr00
    
 , 
    cast(null as numeric(28,6)) as 
    
    objnr01
    
 , 
    cast(null as numeric(28,6)) as 
    
    objnr02
    
 , 
    cast(null as numeric(28,6)) as 
    
    objnr03
    
 , 
    cast(null as numeric(28,6)) as 
    
    objnr04
    
 , 
    cast(null as numeric(28,6)) as 
    
    objnr05
    
 , 
    cast(null as numeric(28,6)) as 
    
    objnr06
    
 , 
    cast(null as numeric(28,6)) as 
    
    objnr07
    
 , 
    cast(null as numeric(28,6)) as 
    
    objnr08
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl01
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl02
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl03
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl04
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl05
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl06
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl07
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl08
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl09
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl10
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl11
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl12
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl13
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl14
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl15
    
 , 
    cast(null as numeric(28,6)) as 
    
    osl16
    
 , 
    cast(null as numeric(28,6)) as 
    
    oslvt
    
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
    
    rpmax
    
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
    cast(null as numeric(28,6)) as faglflext_timestamp , 
    cast(null as numeric(28,6)) as 
    
    tsl01
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl02
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl03
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl04
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl05
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl06
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl07
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl08
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl09
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl10
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl11
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl12
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl13
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl14
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl15
    
 , 
    cast(null as numeric(28,6)) as 
    
    tsl16
    
 , 
    cast(null as numeric(28,6)) as 
    
    tslvt
    
 , 
    cast(null as TEXT) as 
    
    zzspreg
    
 


    from base
),

final as (

    select
        cast(rclnt as TEXT) as rclnt,
        ryear,
        objnr00,
        objnr01,
        objnr02,
        objnr03,
        objnr04,
        objnr05,
        objnr06,
        objnr07,
        objnr08,
        drcrk,
        rpmax,
        activ,
        rmvct,
        rtcur,
        runit,
        awtyp,
        cast(rldnr as TEXT) as rldnr,
        rrcty,
        rvers,
        logsys,
        racct,
        cost_elem, 
        cast(rbukrs as TEXT) as rbukrs,
        rcntr,
        prctr,
        rfarea,
        rbusa,
        kokrs,
        segment,
        zzspreg,
        scntr,
        pprctr,
        sfarea,
        sbusa,
        rassc,
        psegment,
        hslvt,
        hsl01,
        hsl02,
        hsl03,
        hsl04,
        hsl05,
        hsl06,
        hsl07,
        hsl08,
        hsl09,
        hsl10,
        hsl11,
        hsl12,
        hsl13,
        hsl14,
        hsl15,
        hsl16,
        tslvt,
        tsl01,
        tsl02,
        tsl03,
        tsl04,
        tsl05,
        tsl06,
        tsl07,
        tsl08,
        tsl09,
        tsl10,
        tsl11,
        tsl12,
        tsl13,
        tsl14,
        tsl15,
        tsl16,
        kslvt,
        ksl01,
        ksl02,
        ksl03,
        ksl04,
        ksl05,
        ksl06,
        ksl07,
        ksl08,
        ksl09,
        ksl10,
        ksl11,
        ksl12,
        ksl13,
        ksl14,
        ksl15,
        ksl16,
        oslvt,
        osl01,
        osl02,
        osl03,
        osl04,
        osl05,
        osl06,
        osl07,
        osl08,
        osl09,
        osl10,
        osl11,
        osl12,
        osl13,
        osl14,
        osl15,
        osl16,
        faglflext_timestamp,
        _fivetran_rowid,
        _fivetran_deleted,
        _fivetran_synced
    from fields
)

select * 
from final
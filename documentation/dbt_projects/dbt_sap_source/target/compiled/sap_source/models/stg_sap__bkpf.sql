with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__bkpf_tmp
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
    
    _sapf15_status
    
 , 
    cast(null as TEXT) as 
    
    adisc
    
 , 
    cast(null as TEXT) as 
    
    aedat
    
 , 
    cast(null as TEXT) as 
    
    arcid
    
 , 
    cast(null as TEXT) as 
    
    ausbk
    
 , 
    cast(null as TEXT) as 
    
    awkey
    
 , 
    cast(null as TEXT) as 
    
    awsys
    
 , 
    cast(null as TEXT) as 
    
    awtyp
    
 , 
    cast(null as TEXT) as 
    
    basw2
    
 , 
    cast(null as TEXT) as 
    
    basw3
    
 , 
    cast(null as TEXT) as 
    
    batch
    
 , 
    cast(null as TEXT) as 
    
    belnr
    
 , 
    cast(null as TEXT) as 
    
    bktxt
    
 , 
    cast(null as TEXT) as 
    
    blart
    
 , 
    cast(null as TEXT) as 
    
    bldat
    
 , 
    cast(null as TEXT) as 
    
    blind
    
 , 
    cast(null as TEXT) as 
    
    brnch
    
 , 
    cast(null as TEXT) as 
    
    bstat
    
 , 
    cast(null as TEXT) as 
    
    budat
    
 , 
    cast(null as TEXT) as 
    
    bukrs
    
 , 
    cast(null as TEXT) as 
    
    bvorg
    
 , 
    cast(null as TEXT) as 
    
    cash_alloc
    
 , 
    cast(null as TEXT) as 
    
    ccins
    
 , 
    cast(null as TEXT) as 
    
    ccnum
    
 , 
    cast(null as TEXT) as 
    
    cpudt
    
 , 
    cast(null as TEXT) as 
    
    cputm
    
 , 
    cast(null as numeric(28,6)) as 
    
    ctxkrs
    
 , 
    cast(null as TEXT) as 
    
    curt2
    
 , 
    cast(null as TEXT) as 
    
    curt3
    
 , 
    cast(null as TEXT) as 
    
    dbblg
    
 , 
    cast(null as TEXT) as 
    
    doccat
    
 , 
    cast(null as TEXT) as 
    
    dokid
    
 , 
    cast(null as TEXT) as 
    
    duefl
    
 , 
    cast(null as TEXT) as 
    
    exclude_flag
    
 , 
    cast(null as TEXT) as 
    
    fikrs
    
 , 
    cast(null as TEXT) as 
    
    fm_umart
    
 , 
    cast(null as TEXT) as 
    
    follow_on
    
 , 
    cast(null as numeric(28,6)) as 
    
    frath
    
 , 
    cast(null as TEXT) as 
    
    gjahr
    
 , 
    cast(null as TEXT) as 
    
    glvor
    
 , 
    cast(null as TEXT) as 
    
    grpid
    
 , 
    cast(null as TEXT) as 
    
    hwae2
    
 , 
    cast(null as TEXT) as 
    
    hwae3
    
 , 
    cast(null as TEXT) as 
    
    hwaer
    
 , 
    cast(null as TEXT) as 
    
    iblar
    
 , 
    cast(null as TEXT) as 
    
    intdate
    
 , 
    cast(null as TEXT) as 
    
    intform
    
 , 
    cast(null as TEXT) as 
    
    knumv
    
 , 
    cast(null as numeric(28,6)) as 
    
    kur2x
    
 , 
    cast(null as numeric(28,6)) as 
    
    kur3x
    
 , 
    cast(null as numeric(28,6)) as 
    
    kurs2
    
 , 
    cast(null as numeric(28,6)) as 
    
    kurs3
    
 , 
    cast(null as numeric(28,6)) as 
    
    kursf
    
 , 
    cast(null as TEXT) as 
    
    kurst
    
 , 
    cast(null as numeric(28,6)) as 
    
    kursx
    
 , 
    cast(null as TEXT) as 
    
    kuty2
    
 , 
    cast(null as TEXT) as 
    
    kuty3
    
 , 
    cast(null as numeric(28,6)) as 
    
    kzkrs
    
 , 
    cast(null as TEXT) as 
    
    kzwrs
    
 , 
    cast(null as TEXT) as 
    
    ldgrp
    
 , 
    cast(null as TEXT) as 
    
    lotkz
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as TEXT) as 
    
    monat
    
 , 
    cast(null as TEXT) as 
    
    numpg
    
 , 
    cast(null as TEXT) as 
    
    offset_refer_dat
    
 , 
    cast(null as TEXT) as 
    
    offset_status
    
 , 
    cast(null as TEXT) as 
    
    penrc
    
 , 
    cast(null as TEXT) as 
    
    ppnam
    
 , 
    cast(null as TEXT) as 
    
    propmano
    
 , 
    cast(null as TEXT) as 
    
    psoak
    
 , 
    cast(null as TEXT) as 
    
    psobt
    
 , 
    cast(null as TEXT) as 
    
    psodt
    
 , 
    cast(null as TEXT) as 
    
    psofn
    
 , 
    cast(null as TEXT) as 
    
    psoks
    
 , 
    cast(null as TEXT) as 
    
    psosg
    
 , 
    cast(null as TEXT) as 
    
    psotm
    
 , 
    cast(null as TEXT) as 
    
    psoty
    
 , 
    cast(null as TEXT) as 
    
    psozl
    
 , 
    cast(null as TEXT) as 
    
    reindat
    
 , 
    cast(null as TEXT) as 
    
    resubmission
    
 , 
    cast(null as TEXT) as 
    
    rldnr
    
 , 
    cast(null as TEXT) as 
    
    sampled
    
 , 
    cast(null as TEXT) as 
    
    sname
    
 , 
    cast(null as TEXT) as 
    
    ssblk
    
 , 
    cast(null as TEXT) as 
    
    stblg
    
 , 
    cast(null as TEXT) as 
    
    stgrd
    
 , 
    cast(null as TEXT) as 
    
    stjah
    
 , 
    cast(null as TEXT) as 
    
    stodt
    
 , 
    cast(null as TEXT) as 
    
    subset
    
 , 
    cast(null as TEXT) as 
    
    tcode
    
 , 
    cast(null as numeric(28,6)) as 
    
    txkrs
    
 , 
    cast(null as TEXT) as 
    
    umrd2
    
 , 
    cast(null as TEXT) as 
    
    umrd3
    
 , 
    cast(null as TEXT) as 
    
    upddt
    
 , 
    cast(null as TEXT) as 
    
    usnam
    
 , 
    cast(null as TEXT) as 
    
    vatdate
    
 , 
    cast(null as TEXT) as 
    
    waers
    
 , 
    cast(null as TEXT) as 
    
    wwert
    
 , 
    cast(null as TEXT) as 
    
    xblnr
    
 , 
    cast(null as TEXT) as 
    
    xblnr_alt
    
 , 
    cast(null as TEXT) as 
    
    xmca
    
 , 
    cast(null as TEXT) as 
    
    xmwst
    
 , 
    cast(null as TEXT) as 
    
    xnetb
    
 , 
    cast(null as TEXT) as 
    
    xref1_hd
    
 , 
    cast(null as TEXT) as 
    
    xref2_hd
    
 , 
    cast(null as TEXT) as 
    
    xreorg
    
 , 
    cast(null as TEXT) as 
    
    xreversal
    
 , 
    cast(null as TEXT) as 
    
    xrueb
    
 , 
    cast(null as TEXT) as 
    
    xsnet
    
 , 
    cast(null as TEXT) as 
    
    xsplit
    
 , 
    cast(null as TEXT) as 
    
    xstov
    
 , 
    cast(null as TEXT) as 
    
    xusvr
    
 , 
    cast(null as TEXT) as 
    
    xwvof
    
 


    from base
),

final as (

    select 
        cast(mandt as TEXT) as mandt,
        cast(bukrs as TEXT) as bukrs,
        cast(belnr as TEXT) as belnr,
        cast(gjahr as TEXT) as gjahr,
        blart,
        bldat,
        monat,
        cpudt,
        xblnr,
        waers,
        glvor,
        awkey,
        fikrs,
        hwaer,
        hwae2,
        hwae3,
        awsys,
        ldgrp,
        kursf,
        xreorg
    from fields
)

select * 
from final
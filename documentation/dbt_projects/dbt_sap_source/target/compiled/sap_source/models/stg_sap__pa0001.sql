with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__pa0001_tmp
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
    
    abkrs
    
 , 
    cast(null as TEXT) as 
    
    aedtm
    
 , 
    cast(null as TEXT) as 
    
    ansvh
    
 , 
    cast(null as TEXT) as 
    
    begda
    
 , 
    cast(null as TEXT) as 
    
    btrtl
    
 , 
    cast(null as TEXT) as 
    
    budget_pd
    
 , 
    cast(null as TEXT) as 
    
    bukrs
    
 , 
    cast(null as TEXT) as 
    
    ename
    
 , 
    cast(null as TEXT) as 
    
    endda
    
 , 
    cast(null as TEXT) as 
    
    fistl
    
 , 
    cast(null as TEXT) as 
    
    fkber
    
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
    
    geber
    
 , 
    cast(null as TEXT) as 
    
    grant_nbr
    
 , 
    cast(null as TEXT) as 
    
    grpvl
    
 , 
    cast(null as TEXT) as 
    
    gsber
    
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
    
    juper
    
 , 
    cast(null as TEXT) as 
    
    kokrs
    
 , 
    cast(null as TEXT) as 
    
    kostl
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as TEXT) as 
    
    mstbr
    
 , 
    cast(null as TEXT) as 
    
    objps
    
 , 
    cast(null as TEXT) as 
    
    ordex
    
 , 
    cast(null as TEXT) as 
    
    orgeh
    
 , 
    cast(null as TEXT) as 
    
    otype
    
 , 
    cast(null as TEXT) as 
    
    pernr
    
 , 
    cast(null as TEXT) as 
    
    persg
    
 , 
    cast(null as TEXT) as 
    
    persk
    
 , 
    cast(null as TEXT) as 
    
    plans
    
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
    
    sacha
    
 , 
    cast(null as TEXT) as 
    
    sachp
    
 , 
    cast(null as TEXT) as 
    
    sachz
    
 , 
    cast(null as TEXT) as 
    
    sbmod
    
 , 
    cast(null as TEXT) as 
    
    seqnr
    
 , 
    cast(null as TEXT) as 
    
    sgmnt
    
 , 
    cast(null as TEXT) as 
    
    sname
    
 , 
    cast(null as TEXT) as 
    
    sprps
    
 , 
    cast(null as TEXT) as 
    
    stell
    
 , 
    cast(null as TEXT) as 
    
    subty
    
 , 
    cast(null as TEXT) as 
    
    uname
    
 , 
    cast(null as TEXT) as 
    
    vdsk1
    
 , 
    cast(null as TEXT) as 
    
    werks
    
 


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
        abkrs,
        aedtm,
        ansvh,
        btrtl,
        budget_pd,
        bukrs,
        ename,
        fistl,
        fkber,
        flag1,
        flag2,
        flag3,
        flag4,
        geber,
        grant_nbr,
        grpvl,
        gsber,
        histo,
        itbld,
        itxex,
        juper,
        kokrs,
        kostl,
        mstbr,
        ordex,
        orgeh,
        otype,
        persg,
        persk,
        plans,
        preas,
        refex,
        rese1,
        rese2,
        sacha,
        sachp,
        sachz,
        sbmod,
        sgmnt,
        sname,
        stell,
        uname,
        vdsk1,
        werks
    from fields
)

select *
from final
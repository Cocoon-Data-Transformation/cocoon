with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__pa0031_tmp
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
    
    rfp01
    
 , 
    cast(null as TEXT) as 
    
    rfp02
    
 , 
    cast(null as TEXT) as 
    
    rfp03
    
 , 
    cast(null as TEXT) as 
    
    rfp04
    
 , 
    cast(null as TEXT) as 
    
    rfp05
    
 , 
    cast(null as TEXT) as 
    
    rfp06
    
 , 
    cast(null as TEXT) as 
    
    rfp07
    
 , 
    cast(null as TEXT) as 
    
    rfp08
    
 , 
    cast(null as TEXT) as 
    
    rfp09
    
 , 
    cast(null as TEXT) as 
    
    rfp10
    
 , 
    cast(null as TEXT) as 
    
    rfp11
    
 , 
    cast(null as TEXT) as 
    
    rfp12
    
 , 
    cast(null as TEXT) as 
    
    rfp13
    
 , 
    cast(null as TEXT) as 
    
    rfp14
    
 , 
    cast(null as TEXT) as 
    
    rfp15
    
 , 
    cast(null as TEXT) as 
    
    rfp16
    
 , 
    cast(null as TEXT) as 
    
    rfp17
    
 , 
    cast(null as TEXT) as 
    
    rfp18
    
 , 
    cast(null as TEXT) as 
    
    rfp19
    
 , 
    cast(null as TEXT) as 
    
    rfp20
    
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
        ordex,
        preas,
        refex,
        rese1,
        rese2,
        rfp01,
        rfp02,
        rfp03,
        rfp04,
        rfp05,
        rfp06,
        rfp07,
        rfp08,
        rfp09,
        rfp10,
        rfp11,
        rfp12,
        rfp13,
        rfp14,
        rfp15,
        rfp16,
        rfp17,
        rfp18,
        rfp19,
        rfp20,
        uname
    from fields
)

select *
from final
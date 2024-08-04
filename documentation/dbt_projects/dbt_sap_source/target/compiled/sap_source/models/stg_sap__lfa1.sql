with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__lfa1_tmp
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
    
    actss
    
 , 
    cast(null as TEXT) as 
    
    adrnr
    
 , 
    cast(null as TEXT) as 
    
    alc
    
 , 
    cast(null as TEXT) as 
    
    anred
    
 , 
    cast(null as TEXT) as 
    
    bahns
    
 , 
    cast(null as TEXT) as 
    
    bbbnr
    
 , 
    cast(null as TEXT) as 
    
    bbsnr
    
 , 
    cast(null as TEXT) as 
    
    begru
    
 , 
    cast(null as TEXT) as 
    
    brsch
    
 , 
    cast(null as TEXT) as 
    
    bubkz
    
 , 
    cast(null as TEXT) as 
    
    carrier_conf
    
 , 
    cast(null as TEXT) as 
    
    cnae
    
 , 
    cast(null as TEXT) as 
    
    comsize
    
 , 
    cast(null as TEXT) as 
    
    confs
    
 , 
    cast(null as TEXT) as 
    
    crc_num
    
 , 
    cast(null as TEXT) as 
    
    crtn
    
 , 
    cast(null as TEXT) as 
    
    cvp_xblck
    
 , 
    cast(null as TEXT) as 
    
    datlt
    
 , 
    cast(null as TEXT) as 
    
    decregpc
    
 , 
    cast(null as TEXT) as 
    
    dlgrp
    
 , 
    cast(null as TEXT) as 
    
    dtams
    
 , 
    cast(null as TEXT) as 
    
    dtaws
    
 , 
    cast(null as TEXT) as 
    
    duefl
    
 , 
    cast(null as TEXT) as 
    
    emnfr
    
 , 
    cast(null as TEXT) as 
    
    erdat
    
 , 
    cast(null as TEXT) as 
    
    ernam
    
 , 
    cast(null as TEXT) as 
    
    esrnr
    
 , 
    cast(null as TEXT) as 
    
    exp
    
 , 
    cast(null as TEXT) as 
    
    fiskn
    
 , 
    cast(null as TEXT) as 
    
    fisku
    
 , 
    cast(null as TEXT) as 
    
    fityp
    
 , 
    cast(null as TEXT) as 
    
    gbdat
    
 , 
    cast(null as TEXT) as 
    
    gbort
    
 , 
    cast(null as TEXT) as 
    
    icmstaxpay
    
 , 
    cast(null as TEXT) as 
    
    indtyp
    
 , 
    cast(null as TEXT) as 
    
    ipisp
    
 , 
    cast(null as TEXT) as 
    
    j_1kfrepre
    
 , 
    cast(null as TEXT) as 
    
    j_1kftbus
    
 , 
    cast(null as TEXT) as 
    
    j_1kftind
    
 , 
    cast(null as numeric(28,6)) as 
    
    j_sc_capital
    
 , 
    cast(null as TEXT) as 
    
    j_sc_currency
    
 , 
    cast(null as TEXT) as 
    
    konzs
    
 , 
    cast(null as TEXT) as 
    
    kraus
    
 , 
    cast(null as TEXT) as 
    
    ktock
    
 , 
    cast(null as TEXT) as 
    
    ktokk
    
 , 
    cast(null as TEXT) as 
    
    kunnr
    
 , 
    cast(null as TEXT) as 
    
    land1
    
 , 
    cast(null as TEXT) as 
    
    legalnat
    
 , 
    cast(null as TEXT) as 
    
    lfurl
    
 , 
    cast(null as TEXT) as 
    
    lifnr
    
 , 
    cast(null as TEXT) as 
    
    lnrza
    
 , 
    cast(null as TEXT) as 
    
    loevm
    
 , 
    cast(null as TEXT) as 
    
    ltsna
    
 , 
    cast(null as TEXT) as 
    
    lzone
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as TEXT) as 
    
    mcod1
    
 , 
    cast(null as TEXT) as 
    
    mcod2
    
 , 
    cast(null as TEXT) as 
    
    mcod3
    
 , 
    cast(null as TEXT) as 
    
    min_comp
    
 , 
    cast(null as TEXT) as 
    
    name1
    
 , 
    cast(null as TEXT) as 
    
    name2
    
 , 
    cast(null as TEXT) as 
    
    name3
    
 , 
    cast(null as TEXT) as 
    
    name4
    
 , 
    cast(null as TEXT) as 
    
    nodel
    
 , 
    cast(null as TEXT) as 
    
    ort01
    
 , 
    cast(null as TEXT) as 
    
    ort02
    
 , 
    cast(null as TEXT) as 
    
    pfach
    
 , 
    cast(null as TEXT) as 
    
    pfort
    
 , 
    cast(null as TEXT) as 
    
    plkal
    
 , 
    cast(null as TEXT) as 
    
    pmt_office
    
 , 
    cast(null as TEXT) as 
    
    podkzb
    
 , 
    cast(null as TEXT) as 
    
    ppa_relevant
    
 , 
    cast(null as TEXT) as 
    
    profs
    
 , 
    cast(null as TEXT) as 
    
    psofg
    
 , 
    cast(null as TEXT) as 
    
    psohs
    
 , 
    cast(null as TEXT) as 
    
    psois
    
 , 
    cast(null as TEXT) as 
    
    pson1
    
 , 
    cast(null as TEXT) as 
    
    pson2
    
 , 
    cast(null as TEXT) as 
    
    pson3
    
 , 
    cast(null as TEXT) as 
    
    psost
    
 , 
    cast(null as TEXT) as 
    
    psotl
    
 , 
    cast(null as TEXT) as 
    
    psovn
    
 , 
    cast(null as TEXT) as 
    
    pstl2
    
 , 
    cast(null as TEXT) as 
    
    pstlz
    
 , 
    cast(null as TEXT) as 
    
    qssys
    
 , 
    cast(null as TEXT) as 
    
    qssysdat
    
 , 
    cast(null as TEXT) as 
    
    regio
    
 , 
    cast(null as TEXT) as 
    
    regss
    
 , 
    cast(null as TEXT) as 
    
    revdb
    
 , 
    cast(null as TEXT) as 
    
    rg
    
 , 
    cast(null as TEXT) as 
    
    rgdate
    
 , 
    cast(null as TEXT) as 
    
    ric
    
 , 
    cast(null as TEXT) as 
    
    rne
    
 , 
    cast(null as TEXT) as 
    
    rnedate
    
 , 
    cast(null as TEXT) as 
    
    scacd
    
 , 
    cast(null as TEXT) as 
    
    scheduling_type
    
 , 
    cast(null as TEXT) as 
    
    sexkz
    
 , 
    cast(null as TEXT) as 
    
    sfrgr
    
 , 
    cast(null as TEXT) as 
    
    sortl
    
 , 
    cast(null as TEXT) as 
    
    sperm
    
 , 
    cast(null as TEXT) as 
    
    sperq
    
 , 
    cast(null as TEXT) as 
    
    sperr
    
 , 
    cast(null as TEXT) as 
    
    sperz
    
 , 
    cast(null as TEXT) as 
    
    spras
    
 , 
    cast(null as numeric(28,6)) as 
    
    staging_time
    
 , 
    cast(null as TEXT) as 
    
    stcd1
    
 , 
    cast(null as TEXT) as 
    
    stcd2
    
 , 
    cast(null as TEXT) as 
    
    stcd3
    
 , 
    cast(null as TEXT) as 
    
    stcd4
    
 , 
    cast(null as TEXT) as 
    
    stcd5
    
 , 
    cast(null as TEXT) as 
    
    stcdt
    
 , 
    cast(null as TEXT) as 
    
    stceg
    
 , 
    cast(null as TEXT) as 
    
    stenr
    
 , 
    cast(null as TEXT) as 
    
    stgdl
    
 , 
    cast(null as TEXT) as 
    
    stkza
    
 , 
    cast(null as TEXT) as 
    
    stkzn
    
 , 
    cast(null as TEXT) as 
    
    stkzu
    
 , 
    cast(null as TEXT) as 
    
    stras
    
 , 
    cast(null as TEXT) as 
    
    submi_relevant
    
 , 
    cast(null as TEXT) as 
    
    taxbs
    
 , 
    cast(null as TEXT) as 
    
    tdt
    
 , 
    cast(null as TEXT) as 
    
    telbx
    
 , 
    cast(null as TEXT) as 
    
    telf1
    
 , 
    cast(null as TEXT) as 
    
    telf2
    
 , 
    cast(null as TEXT) as 
    
    telfx
    
 , 
    cast(null as TEXT) as 
    
    teltx
    
 , 
    cast(null as TEXT) as 
    
    telx1
    
 , 
    cast(null as TEXT) as 
    
    term_li
    
 , 
    cast(null as TEXT) as 
    
    transport_chain
    
 , 
    cast(null as TEXT) as 
    
    txjcd
    
 , 
    cast(null as TEXT) as 
    
    uf
    
 , 
    cast(null as TEXT) as 
    
    updat
    
 , 
    cast(null as TEXT) as 
    
    uptim
    
 , 
    cast(null as TEXT) as 
    
    vbund
    
 , 
    cast(null as TEXT) as 
    
    werkr
    
 , 
    cast(null as TEXT) as 
    
    werks
    
 , 
    cast(null as TEXT) as 
    
    xcpdk
    
 , 
    cast(null as TEXT) as 
    
    xlfza
    
 , 
    cast(null as TEXT) as 
    
    xzemp
    
 


    from base
),

final as (
    
    select
        mandt,
        lifnr,
        brsch,
        ktokk,
        land1,
        loevm,
        name1,
        name2,
        name3,
        ort01,
        ort02,
        pfach,
        pstl2,
        pstlz,
        regio,
        sortl,
        spras,
        stcd1,
        stcd2,
        stcd3,
        stras,
        telf1,
        telfx,
        xcpdk,
        vbund,
        kraus,
        pfort,
        werks
    from fields
)

select *
from final
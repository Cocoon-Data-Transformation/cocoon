with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__bseg_tmp
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
    
    abper
    
 , 
    cast(null as numeric(28,6)) as 
    
    absbt
    
 , 
    cast(null as numeric(28,6)) as 
    
    agzei
    
 , 
    cast(null as TEXT) as 
    
    altkt
    
 , 
    cast(null as TEXT) as 
    
    anbwa
    
 , 
    cast(null as TEXT) as 
    
    anfae
    
 , 
    cast(null as TEXT) as 
    
    anfbj
    
 , 
    cast(null as TEXT) as 
    
    anfbn
    
 , 
    cast(null as TEXT) as 
    
    anfbu
    
 , 
    cast(null as TEXT) as 
    
    anln1
    
 , 
    cast(null as TEXT) as 
    
    anln2
    
 , 
    cast(null as TEXT) as 
    
    aplzl
    
 , 
    cast(null as TEXT) as 
    
    aufnr
    
 , 
    cast(null as TEXT) as 
    
    aufpl
    
 , 
    cast(null as TEXT) as 
    
    augbl
    
 , 
    cast(null as TEXT) as 
    
    augcp
    
 , 
    cast(null as TEXT) as 
    
    augdt
    
 , 
    cast(null as TEXT) as 
    
    auggj
    
 , 
    cast(null as numeric(28,6)) as 
    
    bdif2
    
 , 
    cast(null as numeric(28,6)) as 
    
    bdif3
    
 , 
    cast(null as numeric(28,6)) as 
    
    bdiff
    
 , 
    cast(null as TEXT) as 
    
    belnr
    
 , 
    cast(null as TEXT) as 
    
    bewar
    
 , 
    cast(null as numeric(28,6)) as 
    
    blnbt
    
 , 
    cast(null as TEXT) as 
    
    blnkz
    
 , 
    cast(null as numeric(28,6)) as 
    
    blnpz
    
 , 
    cast(null as numeric(28,6)) as 
    
    bonfb
    
 , 
    cast(null as numeric(28,6)) as 
    
    bpmng
    
 , 
    cast(null as TEXT) as 
    
    bprme
    
 , 
    cast(null as TEXT) as 
    
    bschl
    
 , 
    cast(null as TEXT) as 
    
    btype
    
 , 
    cast(null as numeric(28,6)) as 
    
    bualt
    
 , 
    cast(null as TEXT) as 
    
    budget_pd
    
 , 
    cast(null as TEXT) as 
    
    bukrs
    
 , 
    cast(null as TEXT) as 
    
    bupla
    
 , 
    cast(null as TEXT) as 
    
    bustw
    
 , 
    cast(null as TEXT) as 
    
    buzei
    
 , 
    cast(null as TEXT) as 
    
    buzid
    
 , 
    cast(null as TEXT) as 
    
    bvtyp
    
 , 
    cast(null as TEXT) as 
    
    bwkey
    
 , 
    cast(null as TEXT) as 
    
    bwtar
    
 , 
    cast(null as TEXT) as 
    
    bzdat
    
 , 
    cast(null as TEXT) as 
    
    ccbtc
    
 , 
    cast(null as TEXT) as 
    
    cession_kz
    
 , 
    cast(null as TEXT) as 
    
    dabrz
    
 , 
    cast(null as TEXT) as 
    
    depot
    
 , 
    cast(null as TEXT) as 
    
    diekz
    
 , 
    cast(null as TEXT) as 
    
    disbj
    
 , 
    cast(null as TEXT) as 
    
    disbn
    
 , 
    cast(null as TEXT) as 
    
    disbz
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmb21
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmb22
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmb23
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmb31
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmb32
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmb33
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmbe2
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmbe3
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmbt1
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmbt2
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmbt3
    
 , 
    cast(null as numeric(28,6)) as 
    
    dmbtr
    
 , 
    cast(null as TEXT) as 
    
    docln
    
 , 
    cast(null as TEXT) as 
    
    dtws1
    
 , 
    cast(null as TEXT) as 
    
    dtws2
    
 , 
    cast(null as TEXT) as 
    
    dtws3
    
 , 
    cast(null as TEXT) as 
    
    dtws4
    
 , 
    cast(null as TEXT) as 
    
    ebeln
    
 , 
    cast(null as TEXT) as 
    
    ebelp
    
 , 
    cast(null as TEXT) as 
    
    egbld
    
 , 
    cast(null as TEXT) as 
    
    eglld
    
 , 
    cast(null as TEXT) as 
    
    egrup
    
 , 
    cast(null as TEXT) as 
    
    elikz
    
 , 
    cast(null as TEXT) as 
    
    empfb
    
 , 
    cast(null as TEXT) as 
    
    erfme
    
 , 
    cast(null as numeric(28,6)) as 
    
    erfmg
    
 , 
    cast(null as TEXT) as 
    
    esrnr
    
 , 
    cast(null as TEXT) as 
    
    esrpz
    
 , 
    cast(null as TEXT) as 
    
    esrre
    
 , 
    cast(null as TEXT) as 
    
    eten2
    
 , 
    cast(null as TEXT) as 
    
    etype
    
 , 
    cast(null as TEXT) as 
    
    fastpay
    
 , 
    cast(null as TEXT) as 
    
    fdgrp
    
 , 
    cast(null as TEXT) as 
    
    fdlev
    
 , 
    cast(null as TEXT) as 
    
    fdtag
    
 , 
    cast(null as numeric(28,6)) as 
    
    fdwbt
    
 , 
    cast(null as TEXT) as 
    
    filkd
    
 , 
    cast(null as TEXT) as 
    
    fipos
    
 , 
    cast(null as TEXT) as 
    
    fistl
    
 , 
    cast(null as TEXT) as 
    
    fkber
    
 , 
    cast(null as TEXT) as 
    
    fkber_long
    
 , 
    cast(null as TEXT) as 
    
    fkont
    
 , 
    cast(null as TEXT) as 
    
    fmfgus_key
    
 , 
    cast(null as TEXT) as 
    
    fmxdocln
    
 , 
    cast(null as TEXT) as 
    
    fmxdocnr
    
 , 
    cast(null as TEXT) as 
    
    fmxyear
    
 , 
    cast(null as TEXT) as 
    
    fmxzekkn
    
 , 
    cast(null as numeric(28,6)) as 
    
    fwbas
    
 , 
    cast(null as numeric(28,6)) as 
    
    fwzuz
    
 , 
    cast(null as numeric(28,6)) as 
    
    gbetr
    
 , 
    cast(null as TEXT) as 
    
    geber
    
 , 
    cast(null as TEXT) as 
    
    gityp
    
 , 
    cast(null as TEXT) as 
    
    gjahr
    
 , 
    cast(null as TEXT) as 
    
    glupm
    
 , 
    cast(null as TEXT) as 
    
    gmvkz
    
 , 
    cast(null as TEXT) as 
    
    grant_nbr
    
 , 
    cast(null as TEXT) as 
    
    gricd
    
 , 
    cast(null as TEXT) as 
    
    grirg
    
 , 
    cast(null as TEXT) as 
    
    gsber
    
 , 
    cast(null as TEXT) as 
    
    gvtyp
    
 , 
    cast(null as TEXT) as 
    
    hbkid
    
 , 
    cast(null as TEXT) as 
    
    hkont
    
 , 
    cast(null as TEXT) as 
    
    hktid
    
 , 
    cast(null as TEXT) as 
    
    hrkft
    
 , 
    cast(null as numeric(28,6)) as 
    
    hwbas
    
 , 
    cast(null as TEXT) as 
    
    hwmet
    
 , 
    cast(null as numeric(28,6)) as 
    
    hwzuz
    
 , 
    cast(null as TEXT) as 
    
    hzuon
    
 , 
    cast(null as TEXT) as 
    
    idxsp
    
 , 
    cast(null as TEXT) as 
    
    ignr_ivref
    
 , 
    cast(null as TEXT) as 
    
    imkey
    
 , 
    cast(null as TEXT) as 
    
    intreno
    
 , 
    cast(null as TEXT) as 
    
    j_1tpbupl
    
 , 
    cast(null as TEXT) as 
    
    kblnr
    
 , 
    cast(null as TEXT) as 
    
    kblpos
    
 , 
    cast(null as TEXT) as 
    
    kidno
    
 , 
    cast(null as TEXT) as 
    
    kkber
    
 , 
    cast(null as numeric(28,6)) as 
    
    klibt
    
 , 
    cast(null as TEXT) as 
    
    koart
    
 , 
    cast(null as TEXT) as 
    
    kokrs
    
 , 
    cast(null as TEXT) as 
    
    kontl
    
 , 
    cast(null as TEXT) as 
    
    kontt
    
 , 
    cast(null as TEXT) as 
    
    kostl
    
 , 
    cast(null as TEXT) as 
    
    kstar
    
 , 
    cast(null as TEXT) as 
    
    kstrg
    
 , 
    cast(null as TEXT) as 
    
    ktosl
    
 , 
    cast(null as TEXT) as 
    
    kunnr
    
 , 
    cast(null as numeric(28,6)) as 
    
    kursr
    
 , 
    cast(null as numeric(28,6)) as 
    
    kzbtr
    
 , 
    cast(null as TEXT) as 
    
    landl
    
 , 
    cast(null as TEXT) as 
    
    lifnr
    
 , 
    cast(null as TEXT) as 
    
    linfv
    
 , 
    cast(null as TEXT) as 
    
    lnran
    
 , 
    cast(null as TEXT) as 
    
    lokkt
    
 , 
    cast(null as TEXT) as 
    
    lstar
    
 , 
    cast(null as TEXT) as 
    
    lzbkz
    
 , 
    cast(null as TEXT) as 
    
    maber
    
 , 
    cast(null as TEXT) as 
    
    madat
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as TEXT) as 
    
    mansp
    
 , 
    cast(null as TEXT) as 
    
    manst
    
 , 
    cast(null as TEXT) as 
    
    matnr
    
 , 
    cast(null as TEXT) as 
    
    measure
    
 , 
    cast(null as TEXT) as 
    
    meins
    
 , 
    cast(null as numeric(28,6)) as 
    
    menge
    
 , 
    cast(null as TEXT) as 
    
    mndid
    
 , 
    cast(null as TEXT) as 
    
    mschl
    
 , 
    cast(null as TEXT) as 
    
    mwart
    
 , 
    cast(null as TEXT) as 
    
    mwsk1
    
 , 
    cast(null as TEXT) as 
    
    mwsk2
    
 , 
    cast(null as TEXT) as 
    
    mwsk3
    
 , 
    cast(null as TEXT) as 
    
    mwskz
    
 , 
    cast(null as numeric(28,6)) as 
    
    mwst2
    
 , 
    cast(null as numeric(28,6)) as 
    
    mwst3
    
 , 
    cast(null as numeric(28,6)) as 
    
    mwsts
    
 , 
    cast(null as numeric(28,6)) as 
    
    navfw
    
 , 
    cast(null as numeric(28,6)) as 
    
    navh2
    
 , 
    cast(null as numeric(28,6)) as 
    
    navh3
    
 , 
    cast(null as numeric(28,6)) as 
    
    navhw
    
 , 
    cast(null as numeric(28,6)) as 
    
    nebtr
    
 , 
    cast(null as TEXT) as 
    
    nplnr
    
 , 
    cast(null as numeric(28,6)) as 
    
    nprei
    
 , 
    cast(null as TEXT) as 
    
    obzei
    
 , 
    cast(null as TEXT) as 
    
    paobjnr
    
 , 
    cast(null as TEXT) as 
    
    pargb
    
 , 
    cast(null as TEXT) as 
    
    pasubnr
    
 , 
    cast(null as TEXT) as 
    
    pays_prov
    
 , 
    cast(null as TEXT) as 
    
    pays_tran
    
 , 
    cast(null as TEXT) as 
    
    pbudget_pd
    
 , 
    cast(null as numeric(28,6)) as 
    
    peinh
    
 , 
    cast(null as numeric(28,6)) as 
    
    pendays
    
 , 
    cast(null as numeric(28,6)) as 
    
    penfc
    
 , 
    cast(null as numeric(28,6)) as 
    
    penlc1
    
 , 
    cast(null as numeric(28,6)) as 
    
    penlc2
    
 , 
    cast(null as numeric(28,6)) as 
    
    penlc3
    
 , 
    cast(null as TEXT) as 
    
    penrc
    
 , 
    cast(null as TEXT) as 
    
    pernr
    
 , 
    cast(null as TEXT) as 
    
    perop_beg
    
 , 
    cast(null as TEXT) as 
    
    perop_end
    
 , 
    cast(null as TEXT) as 
    
    pfkber
    
 , 
    cast(null as TEXT) as 
    
    pgeber
    
 , 
    cast(null as TEXT) as 
    
    pgrant_nbr
    
 , 
    cast(null as numeric(28,6)) as 
    
    popts
    
 , 
    cast(null as TEXT) as 
    
    posn2
    
 , 
    cast(null as TEXT) as 
    
    ppa_ex_ind
    
 , 
    cast(null as numeric(28,6)) as 
    
    ppdif2
    
 , 
    cast(null as numeric(28,6)) as 
    
    ppdif3
    
 , 
    cast(null as numeric(28,6)) as 
    
    ppdiff
    
 , 
    cast(null as TEXT) as 
    
    pprct
    
 , 
    cast(null as TEXT) as 
    
    prctr
    
 , 
    cast(null as TEXT) as 
    
    prodper
    
 , 
    cast(null as TEXT) as 
    
    projk
    
 , 
    cast(null as TEXT) as 
    
    projn
    
 , 
    cast(null as TEXT) as 
    
    prznr
    
 , 
    cast(null as TEXT) as 
    
    psalt
    
 , 
    cast(null as TEXT) as 
    
    psegment
    
 , 
    cast(null as numeric(28,6)) as 
    
    pswbt
    
 , 
    cast(null as TEXT) as 
    
    pswsl
    
 , 
    cast(null as numeric(28,6)) as 
    
    pyamt
    
 , 
    cast(null as TEXT) as 
    
    pycur
    
 , 
    cast(null as numeric(28,6)) as 
    
    qbshb
    
 , 
    cast(null as numeric(28,6)) as 
    
    qsfbt
    
 , 
    cast(null as numeric(28,6)) as 
    
    qsshb
    
 , 
    cast(null as TEXT) as 
    
    qsskz
    
 , 
    cast(null as TEXT) as 
    
    qsznr
    
 , 
    cast(null as numeric(28,6)) as 
    
    rdif2
    
 , 
    cast(null as numeric(28,6)) as 
    
    rdif3
    
 , 
    cast(null as numeric(28,6)) as 
    
    rdiff
    
 , 
    cast(null as TEXT) as 
    
    re_account
    
 , 
    cast(null as TEXT) as 
    
    re_bukrs
    
 , 
    cast(null as TEXT) as 
    
    rebzg
    
 , 
    cast(null as TEXT) as 
    
    rebzj
    
 , 
    cast(null as TEXT) as 
    
    rebzt
    
 , 
    cast(null as TEXT) as 
    
    rebzz
    
 , 
    cast(null as TEXT) as 
    
    recid
    
 , 
    cast(null as TEXT) as 
    
    recrf
    
 , 
    cast(null as numeric(28,6)) as 
    
    rewrt
    
 , 
    cast(null as numeric(28,6)) as 
    
    rewwr
    
 , 
    cast(null as TEXT) as 
    
    rfzei
    
 , 
    cast(null as TEXT) as 
    
    rpacq
    
 , 
    cast(null as TEXT) as 
    
    rstgr
    
 , 
    cast(null as TEXT) as 
    
    ryacq
    
 , 
    cast(null as TEXT) as 
    
    saknr
    
 , 
    cast(null as TEXT) as 
    
    samnr
    
 , 
    cast(null as numeric(28,6)) as 
    
    sctax
    
 , 
    cast(null as TEXT) as 
    
    secco
    
 , 
    cast(null as TEXT) as 
    
    segment
    
 , 
    cast(null as TEXT) as 
    
    sgtxt
    
 , 
    cast(null as TEXT) as 
    
    shkzg
    
 , 
    cast(null as TEXT) as 
    
    shzuz
    
 , 
    cast(null as numeric(28,6)) as 
    
    skfbt
    
 , 
    cast(null as numeric(28,6)) as 
    
    sknt2
    
 , 
    cast(null as numeric(28,6)) as 
    
    sknt3
    
 , 
    cast(null as numeric(28,6)) as 
    
    sknto
    
 , 
    cast(null as TEXT) as 
    
    spgrc
    
 , 
    cast(null as TEXT) as 
    
    spgrg
    
 , 
    cast(null as TEXT) as 
    
    spgrm
    
 , 
    cast(null as TEXT) as 
    
    spgrp
    
 , 
    cast(null as TEXT) as 
    
    spgrq
    
 , 
    cast(null as TEXT) as 
    
    spgrs
    
 , 
    cast(null as TEXT) as 
    
    spgrt
    
 , 
    cast(null as TEXT) as 
    
    spgrv
    
 , 
    cast(null as TEXT) as 
    
    squan
    
 , 
    cast(null as TEXT) as 
    
    srtype
    
 , 
    cast(null as TEXT) as 
    
    stbuk
    
 , 
    cast(null as TEXT) as 
    
    stceg
    
 , 
    cast(null as TEXT) as 
    
    stekz
    
 , 
    cast(null as numeric(28,6)) as 
    
    sttax
    
 , 
    cast(null as TEXT) as 
    
    taxps
    
 , 
    cast(null as TEXT) as 
    
    tbtkz
    
 , 
    cast(null as numeric(28,6)) as 
    
    txbfw
    
 , 
    cast(null as numeric(28,6)) as 
    
    txbh2
    
 , 
    cast(null as numeric(28,6)) as 
    
    txbh3
    
 , 
    cast(null as numeric(28,6)) as 
    
    txbhw
    
 , 
    cast(null as TEXT) as 
    
    txdat
    
 , 
    cast(null as TEXT) as 
    
    txgrp
    
 , 
    cast(null as TEXT) as 
    
    txjcd
    
 , 
    cast(null as TEXT) as 
    
    umsks
    
 , 
    cast(null as TEXT) as 
    
    umskz
    
 , 
    cast(null as TEXT) as 
    
    uzawe
    
 , 
    cast(null as TEXT) as 
    
    valut
    
 , 
    cast(null as TEXT) as 
    
    vbel2
    
 , 
    cast(null as TEXT) as 
    
    vbeln
    
 , 
    cast(null as TEXT) as 
    
    vbewa
    
 , 
    cast(null as TEXT) as 
    
    vbund
    
 , 
    cast(null as TEXT) as 
    
    vertn
    
 , 
    cast(null as TEXT) as 
    
    vertt
    
 , 
    cast(null as TEXT) as 
    
    vname
    
 , 
    cast(null as TEXT) as 
    
    vorgn
    
 , 
    cast(null as TEXT) as 
    
    vprsv
    
 , 
    cast(null as TEXT) as 
    
    vptnr
    
 , 
    cast(null as TEXT) as 
    
    vrsdt
    
 , 
    cast(null as TEXT) as 
    
    vrskz
    
 , 
    cast(null as TEXT) as 
    
    werks
    
 , 
    cast(null as numeric(28,6)) as 
    
    wmwst
    
 , 
    cast(null as numeric(28,6)) as 
    
    wrbt1
    
 , 
    cast(null as numeric(28,6)) as 
    
    wrbt2
    
 , 
    cast(null as numeric(28,6)) as 
    
    wrbt3
    
 , 
    cast(null as numeric(28,6)) as 
    
    wrbtr
    
 , 
    cast(null as numeric(28,6)) as 
    
    wskto
    
 , 
    cast(null as TEXT) as 
    
    wverw
    
 , 
    cast(null as TEXT) as 
    
    xanet
    
 , 
    cast(null as TEXT) as 
    
    xauto
    
 , 
    cast(null as TEXT) as 
    
    xbilk
    
 , 
    cast(null as TEXT) as 
    
    xcpdd
    
 , 
    cast(null as TEXT) as 
    
    xegdr
    
 , 
    cast(null as TEXT) as 
    
    xfakt
    
 , 
    cast(null as TEXT) as 
    
    xfrge_bseg
    
 , 
    cast(null as TEXT) as 
    
    xhkom
    
 , 
    cast(null as TEXT) as 
    
    xhres
    
 , 
    cast(null as TEXT) as 
    
    xinve
    
 , 
    cast(null as TEXT) as 
    
    xkres
    
 , 
    cast(null as TEXT) as 
    
    xlgclr
    
 , 
    cast(null as TEXT) as 
    
    xncop
    
 , 
    cast(null as TEXT) as 
    
    xnegp
    
 , 
    cast(null as TEXT) as 
    
    xopvw
    
 , 
    cast(null as TEXT) as 
    
    xpanz
    
 , 
    cast(null as TEXT) as 
    
    xpypr
    
 , 
    cast(null as TEXT) as 
    
    xragl
    
 , 
    cast(null as TEXT) as 
    
    xref1
    
 , 
    cast(null as TEXT) as 
    
    xref2
    
 , 
    cast(null as TEXT) as 
    
    xref3
    
 , 
    cast(null as TEXT) as 
    
    xsauf
    
 , 
    cast(null as TEXT) as 
    
    xserg
    
 , 
    cast(null as TEXT) as 
    
    xskrl
    
 , 
    cast(null as TEXT) as 
    
    xskst
    
 , 
    cast(null as TEXT) as 
    
    xspro
    
 , 
    cast(null as TEXT) as 
    
    xuman
    
 , 
    cast(null as TEXT) as 
    
    xumsw
    
 , 
    cast(null as TEXT) as 
    
    xzahl
    
 , 
    cast(null as numeric(28,6)) as 
    
    zbd1p
    
 , 
    cast(null as numeric(28,6)) as 
    
    zbd1t
    
 , 
    cast(null as numeric(28,6)) as 
    
    zbd2p
    
 , 
    cast(null as numeric(28,6)) as 
    
    zbd2t
    
 , 
    cast(null as numeric(28,6)) as 
    
    zbd3t
    
 , 
    cast(null as TEXT) as 
    
    zbfix
    
 , 
    cast(null as TEXT) as 
    
    zekkn
    
 , 
    cast(null as TEXT) as 
    
    zfbdt
    
 , 
    cast(null as TEXT) as 
    
    zinkz
    
 , 
    cast(null as TEXT) as 
    
    zlsch
    
 , 
    cast(null as TEXT) as 
    
    zlspr
    
 , 
    cast(null as TEXT) as 
    
    zolld
    
 , 
    cast(null as TEXT) as 
    
    zollt
    
 , 
    cast(null as TEXT) as 
    
    zterm
    
 , 
    cast(null as TEXT) as 
    
    zumsk
    
 , 
    cast(null as TEXT) as 
    
    zuonr
    
 , 
    cast(null as TEXT) as 
    
    zzbuspartn
    
 , 
    cast(null as TEXT) as 
    
    zzchan
    
 , 
    cast(null as TEXT) as 
    
    zzlob
    
 , 
    cast(null as TEXT) as 
    
    zzloca
    
 , 
    cast(null as TEXT) as 
    
    zzproduct
    
 , 
    cast(null as TEXT) as 
    
    zzregion
    
 , 
    cast(null as TEXT) as 
    
    zzspreg
    
 , 
    cast(null as TEXT) as 
    
    zzstate
    
 , 
    cast(null as TEXT) as 
    
    zzuserfld1
    
 , 
    cast(null as TEXT) as 
    
    zzuserfld2
    
 , 
    cast(null as TEXT) as 
    
    zzuserfld3
    
 


    from base
),

final as (

    select
        cast(mandt as TEXT) as mandt,
        cast(bukrs as TEXT) as bukrs,
        cast(belnr as TEXT) as belnr,
        cast(gjahr as TEXT) as gjahr,
        cast(buzei as TEXT) as buzei,
        anln1,
        anln2,
        aufnr,
        augbl,
        augdt,
        ebeln,
        ebelp,
        eten2, 
        filkd,
        gsber, 
        koart, 
        kostl,
        maber,
        madat,

        mansp,
        manst,
        mschl,
        mwskz,
        posn2,
        qbshb,
        qsfbt,
        qsshb,
        rebzg,
        samnr,
        sgtxt,
        shkzg,
        skfbt,
        wskto,
        sknto, 
        umsks,
        umskz,
        uzawe,
        valut,
        vbel2,
        vbeln,
        vbewa,
        vbund,
        vertn,
        vertt, 
        werks, 
        wverw, 
        xzahl, 
        zbd1p,
        zbd1t,
        zbd2p,
        zbd2t,
        zbd3t,
        zfbdt, 
        zlsch,
        zlspr,
        zterm,
        zuonr,
        xref1,
        xref2, 
        rstgr,  
        rebzt,
        pswsl,
        pswbt,
        hkont,
        xnegp,
        zbfix,
        rfzei,
        ccbtc,
        kkber,
        xref3,
        dtws1,
        dtws2,
        dtws3,
        dtws4,
        absbt, 
        projk,
        xpypr,
        kidno, 
        bupla,
        secco, 
        pycur,
        pyamt, 
        xragl,
        cession_kz,
        buzid,
        auggj,
        agzei, 
        bdiff,
        bdif2,
        bdif3,
        bewar,
        dabrz,
        dmbtr,
        fkber,
        fkber_long,
        imkey,
        kstar,
        kunnr,
        lifnr,
        meins,
        menge,
        pargb, 
        pfkber, 
        pprct, 
        saknr,
        wrbtr,
        xopvw,
        xlgclr,
        zzspreg,
        zzbuspartn,
        zzproduct,
        zzloca,
        zzchan,
        zzlob, 
        zzuserfld1,
        zzuserfld2,
        zzuserfld3,
        zzregion,
        zzstate
    from fields
)

select *
from final
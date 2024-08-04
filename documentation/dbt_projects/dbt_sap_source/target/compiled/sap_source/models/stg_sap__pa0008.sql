with base as (

    select * 
    from TEST.PUBLIC_stg_sap.stg_sap__pa0008_tmp
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
    
    ancur
    
 , 
    cast(null as numeric(28,6)) as 
    
    ansal
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz01
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz02
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz03
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz04
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz05
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz06
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz07
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz08
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz09
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz10
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz11
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz12
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz13
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz14
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz15
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz16
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz17
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz18
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz19
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz20
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz21
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz22
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz23
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz24
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz25
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz26
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz27
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz28
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz29
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz30
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz31
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz32
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz33
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz34
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz35
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz36
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz37
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz38
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz39
    
 , 
    cast(null as numeric(28,6)) as 
    
    anz40
    
 , 
    cast(null as TEXT) as 
    
    begda
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet01
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet02
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet03
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet04
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet05
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet06
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet07
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet08
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet09
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet10
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet11
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet12
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet13
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet14
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet15
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet16
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet17
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet18
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet19
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet20
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet21
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet22
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet23
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet24
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet25
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet26
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet27
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet28
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet29
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet30
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet31
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet32
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet33
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet34
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet35
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet36
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet37
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet38
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet39
    
 , 
    cast(null as numeric(28,6)) as 
    
    bet40
    
 , 
    cast(null as numeric(28,6)) as 
    
    bsgrd
    
 , 
    cast(null as TEXT) as 
    
    cpind
    
 , 
    cast(null as numeric(28,6)) as 
    
    divgv
    
 , 
    cast(null as TEXT) as 
    
    ein01
    
 , 
    cast(null as TEXT) as 
    
    ein02
    
 , 
    cast(null as TEXT) as 
    
    ein03
    
 , 
    cast(null as TEXT) as 
    
    ein04
    
 , 
    cast(null as TEXT) as 
    
    ein05
    
 , 
    cast(null as TEXT) as 
    
    ein06
    
 , 
    cast(null as TEXT) as 
    
    ein07
    
 , 
    cast(null as TEXT) as 
    
    ein08
    
 , 
    cast(null as TEXT) as 
    
    ein09
    
 , 
    cast(null as TEXT) as 
    
    ein10
    
 , 
    cast(null as TEXT) as 
    
    ein11
    
 , 
    cast(null as TEXT) as 
    
    ein12
    
 , 
    cast(null as TEXT) as 
    
    ein13
    
 , 
    cast(null as TEXT) as 
    
    ein14
    
 , 
    cast(null as TEXT) as 
    
    ein15
    
 , 
    cast(null as TEXT) as 
    
    ein16
    
 , 
    cast(null as TEXT) as 
    
    ein17
    
 , 
    cast(null as TEXT) as 
    
    ein18
    
 , 
    cast(null as TEXT) as 
    
    ein19
    
 , 
    cast(null as TEXT) as 
    
    ein20
    
 , 
    cast(null as TEXT) as 
    
    ein21
    
 , 
    cast(null as TEXT) as 
    
    ein22
    
 , 
    cast(null as TEXT) as 
    
    ein23
    
 , 
    cast(null as TEXT) as 
    
    ein24
    
 , 
    cast(null as TEXT) as 
    
    ein25
    
 , 
    cast(null as TEXT) as 
    
    ein26
    
 , 
    cast(null as TEXT) as 
    
    ein27
    
 , 
    cast(null as TEXT) as 
    
    ein28
    
 , 
    cast(null as TEXT) as 
    
    ein29
    
 , 
    cast(null as TEXT) as 
    
    ein30
    
 , 
    cast(null as TEXT) as 
    
    ein31
    
 , 
    cast(null as TEXT) as 
    
    ein32
    
 , 
    cast(null as TEXT) as 
    
    ein33
    
 , 
    cast(null as TEXT) as 
    
    ein34
    
 , 
    cast(null as TEXT) as 
    
    ein35
    
 , 
    cast(null as TEXT) as 
    
    ein36
    
 , 
    cast(null as TEXT) as 
    
    ein37
    
 , 
    cast(null as TEXT) as 
    
    ein38
    
 , 
    cast(null as TEXT) as 
    
    ein39
    
 , 
    cast(null as TEXT) as 
    
    ein40
    
 , 
    cast(null as TEXT) as 
    
    endda
    
 , 
    cast(null as TEXT) as 
    
    falgk
    
 , 
    cast(null as TEXT) as 
    
    falgr
    
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
    
    flaga
    
 , 
    cast(null as TEXT) as 
    
    grpvl
    
 , 
    cast(null as TEXT) as 
    
    histo
    
 , 
    cast(null as TEXT) as 
    
    ind01
    
 , 
    cast(null as TEXT) as 
    
    ind02
    
 , 
    cast(null as TEXT) as 
    
    ind03
    
 , 
    cast(null as TEXT) as 
    
    ind04
    
 , 
    cast(null as TEXT) as 
    
    ind05
    
 , 
    cast(null as TEXT) as 
    
    ind06
    
 , 
    cast(null as TEXT) as 
    
    ind07
    
 , 
    cast(null as TEXT) as 
    
    ind08
    
 , 
    cast(null as TEXT) as 
    
    ind09
    
 , 
    cast(null as TEXT) as 
    
    ind10
    
 , 
    cast(null as TEXT) as 
    
    ind11
    
 , 
    cast(null as TEXT) as 
    
    ind12
    
 , 
    cast(null as TEXT) as 
    
    ind13
    
 , 
    cast(null as TEXT) as 
    
    ind14
    
 , 
    cast(null as TEXT) as 
    
    ind15
    
 , 
    cast(null as TEXT) as 
    
    ind16
    
 , 
    cast(null as TEXT) as 
    
    ind17
    
 , 
    cast(null as TEXT) as 
    
    ind18
    
 , 
    cast(null as TEXT) as 
    
    ind19
    
 , 
    cast(null as TEXT) as 
    
    ind20
    
 , 
    cast(null as TEXT) as 
    
    ind21
    
 , 
    cast(null as TEXT) as 
    
    ind22
    
 , 
    cast(null as TEXT) as 
    
    ind23
    
 , 
    cast(null as TEXT) as 
    
    ind24
    
 , 
    cast(null as TEXT) as 
    
    ind25
    
 , 
    cast(null as TEXT) as 
    
    ind26
    
 , 
    cast(null as TEXT) as 
    
    ind27
    
 , 
    cast(null as TEXT) as 
    
    ind28
    
 , 
    cast(null as TEXT) as 
    
    ind29
    
 , 
    cast(null as TEXT) as 
    
    ind30
    
 , 
    cast(null as TEXT) as 
    
    ind31
    
 , 
    cast(null as TEXT) as 
    
    ind32
    
 , 
    cast(null as TEXT) as 
    
    ind33
    
 , 
    cast(null as TEXT) as 
    
    ind34
    
 , 
    cast(null as TEXT) as 
    
    ind35
    
 , 
    cast(null as TEXT) as 
    
    ind36
    
 , 
    cast(null as TEXT) as 
    
    ind37
    
 , 
    cast(null as TEXT) as 
    
    ind38
    
 , 
    cast(null as TEXT) as 
    
    ind39
    
 , 
    cast(null as TEXT) as 
    
    ind40
    
 , 
    cast(null as TEXT) as 
    
    itbld
    
 , 
    cast(null as TEXT) as 
    
    itxex
    
 , 
    cast(null as TEXT) as 
    
    lga01
    
 , 
    cast(null as TEXT) as 
    
    lga02
    
 , 
    cast(null as TEXT) as 
    
    lga03
    
 , 
    cast(null as TEXT) as 
    
    lga04
    
 , 
    cast(null as TEXT) as 
    
    lga05
    
 , 
    cast(null as TEXT) as 
    
    lga06
    
 , 
    cast(null as TEXT) as 
    
    lga07
    
 , 
    cast(null as TEXT) as 
    
    lga08
    
 , 
    cast(null as TEXT) as 
    
    lga09
    
 , 
    cast(null as TEXT) as 
    
    lga10
    
 , 
    cast(null as TEXT) as 
    
    lga11
    
 , 
    cast(null as TEXT) as 
    
    lga12
    
 , 
    cast(null as TEXT) as 
    
    lga13
    
 , 
    cast(null as TEXT) as 
    
    lga14
    
 , 
    cast(null as TEXT) as 
    
    lga15
    
 , 
    cast(null as TEXT) as 
    
    lga16
    
 , 
    cast(null as TEXT) as 
    
    lga17
    
 , 
    cast(null as TEXT) as 
    
    lga18
    
 , 
    cast(null as TEXT) as 
    
    lga19
    
 , 
    cast(null as TEXT) as 
    
    lga20
    
 , 
    cast(null as TEXT) as 
    
    lga21
    
 , 
    cast(null as TEXT) as 
    
    lga22
    
 , 
    cast(null as TEXT) as 
    
    lga23
    
 , 
    cast(null as TEXT) as 
    
    lga24
    
 , 
    cast(null as TEXT) as 
    
    lga25
    
 , 
    cast(null as TEXT) as 
    
    lga26
    
 , 
    cast(null as TEXT) as 
    
    lga27
    
 , 
    cast(null as TEXT) as 
    
    lga28
    
 , 
    cast(null as TEXT) as 
    
    lga29
    
 , 
    cast(null as TEXT) as 
    
    lga30
    
 , 
    cast(null as TEXT) as 
    
    lga31
    
 , 
    cast(null as TEXT) as 
    
    lga32
    
 , 
    cast(null as TEXT) as 
    
    lga33
    
 , 
    cast(null as TEXT) as 
    
    lga34
    
 , 
    cast(null as TEXT) as 
    
    lga35
    
 , 
    cast(null as TEXT) as 
    
    lga36
    
 , 
    cast(null as TEXT) as 
    
    lga37
    
 , 
    cast(null as TEXT) as 
    
    lga38
    
 , 
    cast(null as TEXT) as 
    
    lga39
    
 , 
    cast(null as TEXT) as 
    
    lga40
    
 , 
    cast(null as TEXT) as 
    
    mandt
    
 , 
    cast(null as TEXT) as 
    
    objps
    
 , 
    cast(null as TEXT) as 
    
    opk01
    
 , 
    cast(null as TEXT) as 
    
    opk02
    
 , 
    cast(null as TEXT) as 
    
    opk03
    
 , 
    cast(null as TEXT) as 
    
    opk04
    
 , 
    cast(null as TEXT) as 
    
    opk05
    
 , 
    cast(null as TEXT) as 
    
    opk06
    
 , 
    cast(null as TEXT) as 
    
    opk07
    
 , 
    cast(null as TEXT) as 
    
    opk08
    
 , 
    cast(null as TEXT) as 
    
    opk09
    
 , 
    cast(null as TEXT) as 
    
    opk10
    
 , 
    cast(null as TEXT) as 
    
    opk11
    
 , 
    cast(null as TEXT) as 
    
    opk12
    
 , 
    cast(null as TEXT) as 
    
    opk13
    
 , 
    cast(null as TEXT) as 
    
    opk14
    
 , 
    cast(null as TEXT) as 
    
    opk15
    
 , 
    cast(null as TEXT) as 
    
    opk16
    
 , 
    cast(null as TEXT) as 
    
    opk17
    
 , 
    cast(null as TEXT) as 
    
    opk18
    
 , 
    cast(null as TEXT) as 
    
    opk19
    
 , 
    cast(null as TEXT) as 
    
    opk20
    
 , 
    cast(null as TEXT) as 
    
    opk21
    
 , 
    cast(null as TEXT) as 
    
    opk22
    
 , 
    cast(null as TEXT) as 
    
    opk23
    
 , 
    cast(null as TEXT) as 
    
    opk24
    
 , 
    cast(null as TEXT) as 
    
    opk25
    
 , 
    cast(null as TEXT) as 
    
    opk26
    
 , 
    cast(null as TEXT) as 
    
    opk27
    
 , 
    cast(null as TEXT) as 
    
    opk28
    
 , 
    cast(null as TEXT) as 
    
    opk29
    
 , 
    cast(null as TEXT) as 
    
    opk30
    
 , 
    cast(null as TEXT) as 
    
    opk31
    
 , 
    cast(null as TEXT) as 
    
    opk32
    
 , 
    cast(null as TEXT) as 
    
    opk33
    
 , 
    cast(null as TEXT) as 
    
    opk34
    
 , 
    cast(null as TEXT) as 
    
    opk35
    
 , 
    cast(null as TEXT) as 
    
    opk36
    
 , 
    cast(null as TEXT) as 
    
    opk37
    
 , 
    cast(null as TEXT) as 
    
    opk38
    
 , 
    cast(null as TEXT) as 
    
    opk39
    
 , 
    cast(null as TEXT) as 
    
    opk40
    
 , 
    cast(null as TEXT) as 
    
    ordex
    
 , 
    cast(null as TEXT) as 
    
    orzst
    
 , 
    cast(null as TEXT) as 
    
    partn
    
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
    
    stvor
    
 , 
    cast(null as TEXT) as 
    
    subty
    
 , 
    cast(null as TEXT) as 
    
    trfar
    
 , 
    cast(null as TEXT) as 
    
    trfgb
    
 , 
    cast(null as TEXT) as 
    
    trfgr
    
 , 
    cast(null as TEXT) as 
    
    trfst
    
 , 
    cast(null as TEXT) as 
    
    uname
    
 , 
    cast(null as TEXT) as 
    
    vglgb
    
 , 
    cast(null as TEXT) as 
    
    vglgr
    
 , 
    cast(null as TEXT) as 
    
    vglst
    
 , 
    cast(null as TEXT) as 
    
    vglsv
    
 , 
    cast(null as TEXT) as 
    
    vglta
    
 , 
    cast(null as TEXT) as 
    
    waers
    
 


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
        ancur,
        ansal,
        anz01,
        anz02,
        anz03,
        anz04,
        anz05,
        anz06,
        anz07,
        anz08,
        anz09,
        anz10,
        anz11,
        anz12,
        anz13,
        anz14,
        anz15,
        anz16,
        anz17,
        anz18,
        anz19,
        anz20,
        anz21,
        anz22,
        anz23,
        anz24,
        anz25,
        anz26,
        anz27,
        anz28,
        anz29,
        anz30,
        anz31,
        anz32,
        anz33,
        anz34,
        anz35,
        anz36,
        anz37,
        anz38,
        anz39,
        anz40,
        bet01,
        bet02,
        bet03,
        bet04,
        bet05,
        bet06,
        bet07,
        bet08,
        bet09,
        bet10,
        bet11,
        bet12,
        bet13,
        bet14,
        bet15,
        bet16,
        bet17,
        bet18,
        bet19,
        bet20,
        bet21,
        bet22,
        bet23,
        bet24,
        bet25,
        bet26,
        bet27,
        bet28,
        bet29,
        bet30,
        bet31,
        bet32,
        bet33,
        bet34,
        bet35,
        bet36,
        bet37,
        bet38,
        bet39,
        bet40,
        bsgrd,
        cpind,
        divgv,
        ein01,
        ein02,
        ein03,
        ein04,
        ein05,
        ein06,
        ein07,
        ein08,
        ein09,
        ein10,
        ein11,
        ein12,
        ein13,
        ein14,
        ein15,
        ein16,
        ein17,
        ein18,
        ein19,
        ein20,
        ein21,
        ein22,
        ein23,
        ein24,
        ein25,
        ein26,
        ein27,
        ein28,
        ein29,
        ein30,
        ein31,
        ein32,
        ein33,
        ein34,
        ein35,
        ein36,
        ein37,
        ein38,
        ein39,
        ein40,
        falgk,
        falgr,
        flag1,
        flag2,
        flag3,
        flag4,
        flaga,
        grpvl,
        histo,
        ind01,
        ind02,
        ind03,
        ind04,
        ind05,
        ind06,
        ind07,
        ind08,
        ind09,
        ind10,
        ind11,
        ind12,
        ind13,
        ind14,
        ind15,
        ind16,
        ind17,
        ind18,
        ind19,
        ind20,
        ind21,
        ind22,
        ind23,
        ind24,
        ind25,
        ind26,
        ind27,
        ind28,
        ind29,
        ind30,
        ind31,
        ind32,
        ind33,
        ind34,
        ind35,
        ind36,
        ind37,
        ind38,
        ind39,
        ind40,
        itbld,
        itxex,
        lga01,
        lga02,
        lga03,
        lga04,
        lga05,
        lga06,
        lga07,
        lga08,
        lga09,
        lga10,
        lga11,
        lga12,
        lga13,
        lga14,
        lga15,
        lga16,
        lga17,
        lga18,
        lga19,
        lga20,
        lga21,
        lga22,
        lga23,
        lga24,
        lga25,
        lga26,
        lga27,
        lga28,
        lga29,
        lga30,
        lga31,
        lga32,
        lga33,
        lga34,
        lga35,
        lga36,
        lga37,
        lga38,
        lga39,
        lga40,
        opk01,
        opk02,
        opk03,
        opk04,
        opk05,
        opk06,
        opk07,
        opk08,
        opk09,
        opk10,
        opk11,
        opk12,
        opk13,
        opk14,
        opk15,
        opk16,
        opk17,
        opk18,
        opk19,
        opk20,
        opk21,
        opk22,
        opk23,
        opk24,
        opk25,
        opk26,
        opk27,
        opk28,
        opk29,
        opk30,
        opk31,
        opk32,
        opk33,
        opk34,
        opk35,
        opk36,
        opk37,
        opk38,
        opk39,
        opk40,
        ordex,
        orzst,
        partn,
        preas,
        refex,
        rese1,
        rese2,
        stvor,
        trfar,
        trfgb,
        trfgr,
        trfst,
        uname,
        vglgb,
        vglgr,
        vglst,
        vglsv,
        vglta,
        waers
    from fields
)

select *
from final
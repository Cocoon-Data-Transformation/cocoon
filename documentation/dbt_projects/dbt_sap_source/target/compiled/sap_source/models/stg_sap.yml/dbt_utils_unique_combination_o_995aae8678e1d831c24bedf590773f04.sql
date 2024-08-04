





with validation_errors as (

    select
        mandt, pernr, subty, objps, sprps, endda, begda, seqnr
    from TEST.PUBLIC_stg_sap.stg_sap__pa0007
    group by mandt, pernr, subty, objps, sprps, endda, begda, seqnr
    having count(*) > 1

)

select *
from validation_errors



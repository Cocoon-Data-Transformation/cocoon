





with validation_errors as (

    select
        mandt, bukrs, belnr, gjahr, buzei
    from TEST.PUBLIC_stg_sap.stg_sap__bseg
    group by mandt, bukrs, belnr, gjahr, buzei
    having count(*) > 1

)

select *
from validation_errors



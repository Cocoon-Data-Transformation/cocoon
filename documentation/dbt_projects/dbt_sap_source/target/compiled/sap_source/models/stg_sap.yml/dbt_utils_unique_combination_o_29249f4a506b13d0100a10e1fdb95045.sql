





with validation_errors as (

    select
        mandt, bukrs, belnr, gjahr
    from TEST.PUBLIC_stg_sap.stg_sap__bkpf
    group by mandt, bukrs, belnr, gjahr
    having count(*) > 1

)

select *
from validation_errors



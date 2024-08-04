





with validation_errors as (

    select
        mandt, kunnr
    from TEST.PUBLIC_stg_sap.stg_sap__kna1
    group by mandt, kunnr
    having count(*) > 1

)

select *
from validation_errors



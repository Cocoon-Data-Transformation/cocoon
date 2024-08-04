





with validation_errors as (

    select
        mandt, ktopl, saknr
    from TEST.PUBLIC_stg_sap.stg_sap__ska1
    group by mandt, ktopl, saknr
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        mandt, lifnr
    from TEST.PUBLIC_stg_sap.stg_sap__lfa1
    group by mandt, lifnr
    having count(*) > 1

)

select *
from validation_errors



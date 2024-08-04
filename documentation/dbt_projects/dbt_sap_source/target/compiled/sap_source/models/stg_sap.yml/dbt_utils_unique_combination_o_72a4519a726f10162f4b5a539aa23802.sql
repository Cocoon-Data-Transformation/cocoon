





with validation_errors as (

    select
        mandt, bukrs
    from TEST.PUBLIC_stg_sap.stg_sap__t001
    group by mandt, bukrs
    having count(*) > 1

)

select *
from validation_errors



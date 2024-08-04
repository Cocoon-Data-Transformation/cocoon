





with validation_errors as (

    select
        mandt, persg, persk
    from TEST.PUBLIC_stg_sap.stg_sap__t503
    group by mandt, persg, persk
    having count(*) > 1

)

select *
from validation_errors



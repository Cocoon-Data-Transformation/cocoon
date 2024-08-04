





with validation_errors as (

    select
        mandt, rcomp
    from TEST.PUBLIC_stg_sap.stg_sap__t880
    group by mandt, rcomp
    having count(*) > 1

)

select *
from validation_errors



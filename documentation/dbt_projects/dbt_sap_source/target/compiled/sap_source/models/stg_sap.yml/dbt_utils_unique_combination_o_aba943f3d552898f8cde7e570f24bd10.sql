





with validation_errors as (

    select
        mandt, matnr
    from TEST.PUBLIC_stg_sap.stg_sap__mara
    group by mandt, matnr
    having count(*) > 1

)

select *
from validation_errors



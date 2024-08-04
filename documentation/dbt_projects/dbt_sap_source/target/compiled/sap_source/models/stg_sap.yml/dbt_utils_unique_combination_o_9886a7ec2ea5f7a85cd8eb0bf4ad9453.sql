





with validation_errors as (

    select
        rclnt, ryear, docnr, rldnr, rbukrs, docln
    from TEST.PUBLIC_stg_sap.stg_sap__faglflexa
    group by rclnt, ryear, docnr, rldnr, rbukrs, docln
    having count(*) > 1

)

select *
from validation_errors



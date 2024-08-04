





with validation_errors as (

    select
        rclnt, ryear, objnr00, objnr01, objnr02, objnr03, objnr04, objnr05, objnr06, objnr07, objnr08, drcrk, rpmax
    from TEST.PUBLIC_stg_sap.stg_sap__faglflext
    group by rclnt, ryear, objnr00, objnr01, objnr02, objnr03, objnr04, objnr05, objnr06, objnr07, objnr08, drcrk, rpmax
    having count(*) > 1

)

select *
from validation_errors



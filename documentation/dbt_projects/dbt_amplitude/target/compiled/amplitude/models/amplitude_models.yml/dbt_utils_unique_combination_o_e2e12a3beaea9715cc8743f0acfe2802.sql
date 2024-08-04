





with validation_errors as (

    select
        event_day, event_type
    from TEST.PUBLIC_amplitude.amplitude__daily_performance
    group by event_day, event_type
    having count(*) > 1

)

select *
from validation_errors



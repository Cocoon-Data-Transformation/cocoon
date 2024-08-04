

with event_data as (

    select * 
    from TEST.PUBLIC_amplitude.amplitude__event_enhanced
),

-- create end_date_adjust variable





        







spine as (

    select spine.* 

    from (
        





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
    
    

    )

    select *
    from unioned
    where generated_number <= 1674
    order by generated_number



),

all_periods as (

    select (
        

    dateadd(
        day,
        row_number() over (order by 1) - 1,
        cast('2020-01-01' as date)
        )


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= cast('2024-08-01' as date)

)

select * from filtered

 
    ) as spine

    
),

date_spine as (


    select
        distinct event_data.event_type,
        cast(spine.date_day as date) as event_day,
        md5(cast(coalesce(cast(spine.date_day as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(event_data.event_type as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as date_spine_unique_key
    from spine 
    join event_data
        on spine.date_day >= event_data.event_day -- each event_type will have a record for every day since their first day
)

select * 
from date_spine
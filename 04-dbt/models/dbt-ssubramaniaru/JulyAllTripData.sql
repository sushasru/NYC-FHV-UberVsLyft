{{ config(materialized='table') }}

with tripdata_2019 as (
    select distinct * from {{ref('fhvhv_tripdata_2019')}}
        where ride_type in ('Uber','Lyft') and pickup_zone is not null and dropoff_zone is not null 
        and pickup_servicezone is not null and dropoff_servicezone is not null
),
    tripdata_2020 as (
    select distinct * from {{ref('fhvhv_tripdata_2020')}}
        where ride_type in ('Uber','Lyft') and pickup_zone is not null and dropoff_zone is not null
        and pickup_servicezone is not null and dropoff_servicezone is not null
),
    tripdata_2021 as (
    select distinct * from {{ref('fhvhv_tripdata_2021')}}
        where ride_type in ('Uber','Lyft') and pickup_zone is not null and dropoff_zone is not null
        and pickup_servicezone is not null and dropoff_servicezone is not null
),
    tripdata_2022 as (
    select distinct * from {{ref('fhvhv_tripdata_2022')}}
        where ride_type in ('Uber','Lyft') and pickup_zone is not null and dropoff_zone is not null
        and pickup_servicezone is not null and dropoff_servicezone is not null
),

trips_unioned as (
    select * from tripdata_2019
    union all
    select * from tripdata_2020
    union all
    select * from tripdata_2021
    union all
    select * from tripdata_2022
)

select * from trips_unioned




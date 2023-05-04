{{ config(materialized='view') }}

select distinct {{getridetype('hvfhs_license_num')}} as ride_type
        ,DATETIME(pickup_datetime,"America/New_York") as pickup_datetime
        ,DATETIME(dropoff_datetime,"America/New_York") as dropoff_datetime
        ,pickup.Borough as pickup_borough, pickup.Zone as pickup_zone, pickup.service_zone as pickup_servicezone
        ,dropoff.Borough as dropoff_borough, dropoff.Zone as dropoff_zone, dropoff.service_zone as dropoff_servicezone
        ,case when base_passenger_fare is null then 0.0 else base_passenger_fare end as base_passenger_fare
        ,case when tolls is null then 0.0 else tolls end as tolls
        ,case when bcf is null then 0.0 else bcf end as bcf
        ,case when sales_tax is null then 0.0 else sales_tax end as sales_tax
        ,case when congestion_surcharge is null then 0.0 else congestion_surcharge end as congestion_surcharge
        ,case when airport_fee is null then 0.0 else airport_fee end as airport_fee
        ,tips
        ,driver_pay
        ,shared_request_flag
        ,shared_match_flag 
    from {{source('nyc_fhvhv_tripdetails_zones_raw','fhvhv_tripdata_2022-07')}} as t
    inner join {{source('nyc_fhvhv_tripdetails_zones_raw','taxi_zone_lookup')}} as pickup
    on t.PULocationID = pickup.LocationID
    inner join {{source('nyc_fhvhv_tripdetails_zones_raw','taxi_zone_lookup')}} as dropoff
    on t.DOLocationID =  dropoff.LocationID
    where base_passenger_fare > 0

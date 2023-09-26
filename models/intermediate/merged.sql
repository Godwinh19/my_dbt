
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table', schema="intermediate") }}

with source_data as (
    select
        "new_recovered" as "recovered",
        "_airbyte_ab_id" as "id",
    FROM {{ source('covid', 'covid_normalized') }}
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

where id is not null

{{ config (
    materialized="table"
)}}

select
    total_confirmed,
    total_tested,
    total_recovered,
from {{ref('covid_epidemiology')}}
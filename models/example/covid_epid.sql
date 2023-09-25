-- This is a dbt model file for creating a table
{{ config (
    materialized="table"
)}}

with covid_vt as (
    select
        total_confirmed,
        total_tested,
        total_recovered
    from {{ref('covid')}}
)

select *
from covid_vt
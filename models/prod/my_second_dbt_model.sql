{{ config(
  materialized='table'
) }}

select *
from {{ ref('merged') }}

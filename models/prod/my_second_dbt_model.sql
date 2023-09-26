{{ config(
  materialized='table',
  schema = "public"
) }}

select
 new_recovered,
 new_tested,
from {{ ref('merged') }}

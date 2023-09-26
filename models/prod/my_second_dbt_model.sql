{{ config(
  materialized='table',
  schema = "public"
) }}

select *
from {{ ref('merged') }}

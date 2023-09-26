{{ config(
  materialized='table',
  schema = "staging"
) }}

select
 _airbyte_ab_id as id,
 new_recovered,
 new_tested,
from {{ ref('merged') }}

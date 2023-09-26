{{ config(
  materialized='table',
  indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
   unique_key = 'id',
) }}

select
 _airbyte_ab_id as id,
 new_recovered,
 new_tested,
 _airbyte_emitted_at,
from {{ ref('merged') }}
where 1 = 1

{{ config(
   indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
   unique_key = 'id',
   schema = "public",
) }}


select
    {{ adapter.quote('date') }},
     _airbyte_ab_id as id,
     new_recovered,
     _airbyte_emitted_at
from {{ ref('merged') }}
where 1 = 1

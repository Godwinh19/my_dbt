{{ config(
    indexes = [{'columns':['_airbyte_ab_id'],'type':'hash'}],
) }}


select
    {{ adapter.quote('date') }},
    new_recovered,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_covid_hashid
from {{ source('staging', 'covid_normalized') }}

where 1 = 1

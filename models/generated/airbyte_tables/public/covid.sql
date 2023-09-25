{{ config (
    materialized="table"
)}}

select
    "date",
    new_recovered,
    new_tested,
    total_deceased,
    new_deceased,
    new_confirmed,
    total_confirmed,
    total_tested,
    total_recovered,
    "key",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_covid_hashid
from __dbt__cte__covid_ab3
-- covid from "postgres".public._airbyte_raw_covid
where 1 = 1
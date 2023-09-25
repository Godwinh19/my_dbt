

  create  table "postgres".public."covid_epidemiology__dbt_tmp"
  as (

with __dbt__cte__covid_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public._airbyte_raw_covid
select
    jsonb_extract_path_text(_airbyte_data, 'date') as "date",
    jsonb_extract_path_text(_airbyte_data, 'new_recovered') as new_recovered,
    jsonb_extract_path_text(_airbyte_data, 'new_tested') as new_tested,
    jsonb_extract_path_text(_airbyte_data, 'total_deceased') as total_deceased,
    jsonb_extract_path_text(_airbyte_data, 'new_deceased') as new_deceased,
    jsonb_extract_path_text(_airbyte_data, 'new_confirmed') as new_confirmed,
    jsonb_extract_path_text(_airbyte_data, 'total_confirmed') as total_confirmed,
    jsonb_extract_path_text(_airbyte_data, 'total_tested') as total_tested,
    jsonb_extract_path_text(_airbyte_data, 'total_recovered') as total_recovered,
    jsonb_extract_path_text(_airbyte_data, 'key') as "key",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public._airbyte_raw_covid as table_alias
-- covid
where 1 = 1
),  __dbt__cte__covid_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__covid_ab1
select
    cast("date" as text) as "date",
    cast(new_recovered as
    float
) as new_recovered,
    cast(new_tested as
    float
) as new_tested,
    cast(total_deceased as
    float
) as total_deceased,
    cast(new_deceased as
    float
) as new_deceased,
    cast(new_confirmed as
    float
) as new_confirmed,
    cast(total_confirmed as
    float
) as total_confirmed,
    cast(total_tested as
    float
) as total_tested,
    cast(total_recovered as
    float
) as total_recovered,
    cast("key" as text) as "key",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__covid_ab1
-- covid
where 1 = 1
),  __dbt__cte__covid_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__covid_ab2
select
    md5(cast(coalesce(cast("date" as text), '') || '-' || coalesce(cast(new_recovered as text), '') || '-' || coalesce(cast(new_tested as text), '') || '-' || coalesce(cast(total_deceased as text), '') || '-' || coalesce(cast(new_deceased as text), '') || '-' || coalesce(cast(new_confirmed as text), '') || '-' || coalesce(cast(total_confirmed as text), '') || '-' || coalesce(cast(total_tested as text), '') || '-' || coalesce(cast(total_recovered as text), '') || '-' || coalesce(cast("key" as text), '') as text)) as _airbyte_covid_hashid,
    tmp.*
from __dbt__cte__covid_ab2 tmp
-- covid
where 1 = 1
)-- Final base SQL model
-- depends_on: __dbt__cte__covid_ab3
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
  );
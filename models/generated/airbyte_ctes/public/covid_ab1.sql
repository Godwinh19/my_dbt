
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
{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('table_one_ab3') }}
select
    updated_at,
    {{ adapter.quote('name') }} as name_rename,
    {{ adapter.quote('id') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_table_one_hashid
from {{ ref('table_one_ab3') }}
-- table_one from {{ source('public', '_airbyte_raw_table_one') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}


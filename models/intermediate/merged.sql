{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='covid_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}

with source_data as (
select
    {{ adapter.quote('date') }},
    new_recovered,
    new_tested,
    total_deceased,
    new_deceased,
    new_confirmed,
    total_confirmed,
    total_tested,
    total_recovered,
    {{ adapter.quote('key') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_covid_hashid
from {{ source('staging', 'covid_normalized') }}
)
select * from source_data
where 1 = 1

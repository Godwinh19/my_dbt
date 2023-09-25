{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='covid_epidemiology_scd'
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
-- Final base SQL model
-- depends_on: {{ ref('covid_epidemiology_ab3') }}
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
    _airbyte_covid_epidemiology_hashid
from {{ ref('covid_epidemiology_ab3') }}
-- covid_epidemiology from {{ source('public', '_airbyte_raw_covid_epidemiology') }}
where 1 = 1


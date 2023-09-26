{{ config(
  indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
  schema = "public"
   unique_key = 'id',
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

select
 _airbyte_ab_id as id,
 new_recovered,
 new_tested,
 _airbyte_emitted_at,
from {{ ref('merged') }}
where 1 = 1

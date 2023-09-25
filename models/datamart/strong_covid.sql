select
    new_recovered,
    new_tested,
    total_deceased,
    new_deceased,
    new_confirmed,
    total_confirmed,
    total_tested,
    total_recovered,
from {{ ref('covid_epidemiology') }}
-- covid_epidemiology from {{ source('public', '_airbyte_raw_covid_epidemiology') }}
where 1 = 1
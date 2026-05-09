-- In dbt usiamo le CTE per rendere il codice leggibile e modulare
WITH raw_employees AS (
    -- Simuliamo la lettura dalla tabella grezza di BigQuery
    SELECT * FROM {{ source('raw_data', 'employees') }}
)

SELECT
    CAST(employee_id AS INT64) AS employee_id,
    TRIM(employee_name) AS employee_name,
    LOWER(department) AS department,
    CAST(hourly_rate AS NUMERIC) AS hourly_rate,
    -- Gestiamo i dati mancanti con un valore di default
    COALESCE(status, 'active') AS employment_status
FROM raw_employees

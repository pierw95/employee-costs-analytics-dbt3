WITH raw_timesheets AS (
    SELECT * FROM {{ source('raw_data', 'timesheets') }}
)

SELECT
    CAST(timesheet_id AS INT64) AS timesheet_id,
    CAST(employee_id AS INT64) AS employee_id,
    CAST(work_date AS DATE) AS work_date,
    CAST(hours_worked AS FLOAT64) AS hours_worked,
    -- Identifichiamo se le ore sono straordinarie (overtime)
    CASE 
        WHEN hours_worked > 8 THEN TRUE 
        ELSE FALSE 
    END AS is_overtime
FROM raw_timesheets

WITH employees AS (
    SELECT * FROM {{ ref('stg_employees') }}
),

timesheets AS (
    SELECT * FROM {{ ref('stg_timesheets') }}
),

-- Raggruppiamo le ore per dipendente e mese usando le funzioni di data
monthly_hours_calculated AS (
    SELECT
        employee_id,
        DATE_TRUNC(work_date, MONTH) AS cost_month,
        SUM(hours_worked) AS total_hours,
        -- Calcoliamo le ore ordinarie e straordinarie
        SUM(CASE WHEN is_overtime THEN 8 ELSE hours_worked END) AS regular_hours,
        SUM(CASE WHEN is_overtime THEN hours_worked - 8 ELSE 0 END) AS overtime_hours
    FROM timesheets
    GROUP BY 1, 2
),

-- Calcoliamo il costo totale applicando la logica di business
final_costs AS (
    SELECT
        h.employee_id,
        e.employee_name,
        e.department,
        h.cost_month,
        h.total_hours,
        -- Straordinari pagati a tariffa maggiorata del 25%
        (h.regular_hours * e.hourly_rate) + (h.overtime_hours * e.hourly_rate * 1.25) AS calculated_labor_cost
    FROM monthly_hours_calculated h
    INNER JOIN employees e ON h.employee_id = e.employee_id
)

SELECT * FROM final_costs

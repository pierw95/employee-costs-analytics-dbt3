WITH monthly_costs AS (
    SELECT * FROM {{ ref('int_employee_monthly_costs') }}
),

-- Usiamo una Window Function per confrontare il costo con il mese precedente
costs_with_trends AS (
    SELECT
        employee_id,
        employee_name,
        department,
        cost_month,
        calculated_labor_cost,
        LAG(calculated_labor_cost) OVER (
            PARTITION BY employee_id 
            ORDER BY cost_month
        ) AS previous_month_cost
    FROM monthly_costs
)

SELECT
    employee_id,
    employee_name,
    department,
    cost_month,
    calculated_labor_cost,
    previous_month_cost,
    -- Calcoliamo lo scostamento percentuale
    ROUND(
        ((calculated_labor_cost - COALESCE(previous_month_cost, calculated_labor_cost)) 
        / NULLIF(previous_month_cost, 0)) * 100, 2
    ) AS month_on_month_variance_pct
FROM costs_with_trends

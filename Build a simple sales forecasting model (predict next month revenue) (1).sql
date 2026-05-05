CREATE OR REPLACE MODEL `sales_dataset.sales_model`
OPTIONS(
  model_type='linear_reg',
  input_label_cols=['monthly_revenue']
) AS
SELECT
  month_no,
  monthly_revenue
FROM `sales_dataset.mart_monthly_revenue`;


SELECT
  *
FROM
  ML.PREDICT(MODEL `sales_dataset.sales_model`,
    (
      SELECT 13 AS month_no
    )
  );


SELECT
  *
FROM
  ML.EVALUATE(MODEL `sales_dataset.sales_model`);
-- execução da stored procedure
EXEC pr_top_bottom_churn @ano = 2023, @mes = 3;

-- execução da function
SELECT dbo.fn_churn_rate_mensal(2023, 3, 1) AS ChurnRatePlano1;
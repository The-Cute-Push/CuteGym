CREATE PROCEDURE pr_top_bottom_churn (
    @ano INT,
    @mes INT
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Tabela temporária para armazenar os churn rates por plano
    CREATE TABLE #ChurnRates (
        id_plan TINYINT,
        name VARCHAR(50),
        churn_rate DECIMAL(5,2)
    );

    -- Preencher a tabela com os resultados por plano
    INSERT INTO #ChurnRates (id_plan, name, churn_rate)
    SELECT
        p.id_plan,
        p.name,
        dbo.fn_churn_rate_mensal(@ano, @mes, p.id_plan)
    FROM plans p;

    PRINT 'Top 3 maiores taxas de cancelamento (Churn Rate):';
    SELECT TOP 3 * FROM #ChurnRates ORDER BY churn_rate DESC;

    PRINT 'Top 3 menores taxas de cancelamento (Churn Rate):';
    SELECT TOP 3 * FROM #ChurnRates ORDER BY churn_rate ASC;

    DROP TABLE #ChurnRates;
END;
GO
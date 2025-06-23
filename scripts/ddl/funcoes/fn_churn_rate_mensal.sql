CREATE FUNCTION fn_churn_rate_mensal (
    @ano INT,
    @mes INT,
    @id_plano TINYINT
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @clientes_inicio INT;
    DECLARE @cancelamentos INT;

    -- Quantidade de clientes ativos no início do mês
    SELECT @clientes_inicio = COUNT(*)
    FROM subscriptions
    WHERE id_plan = @id_plano
      AND dt_start < DATEFROMPARTS(@ano, @mes, 1)
      AND (dt_end IS NULL OR dt_end >= DATEFROMPARTS(@ano, @mes, 1));

    -- Quantidade de cancelamentos no mês
    SELECT @cancelamentos = COUNT(*)
    FROM subscriptions
    WHERE id_plan = @id_plano
      AND dt_end IS NOT NULL
      AND YEAR(dt_end) = @ano
      AND MONTH(dt_end) = @mes;

    IF @clientes_inicio = 0
        RETURN 0;

    RETURN CAST(@cancelamentos AS DECIMAL(5,2)) / @clientes_inicio * 100;
END;
GO

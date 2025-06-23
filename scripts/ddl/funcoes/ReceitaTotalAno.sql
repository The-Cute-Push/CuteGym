DROP FUNCTION IF EXISTS ReceitaTotalAno
GO

CREATE FUNCTION ReceitaTotalAno(@Plano NVARCHAR(100), @Ano INT)
RETURNS NUMERIC(18, 2)
AS
BEGIN
    DECLARE @ReceitaTotal NUMERIC(18, 2);

    SELECT @ReceitaTotal = COALESCE(SUM(PA.price), 0)
    FROM plans P
    JOIN subscriptions S ON P.id_plan = S.id_plan
    JOIN payments PA ON S.id_subscriptions = PA.id_subscriptions
    WHERE P.[name] = @Plano
      AND YEAR(S.dt_start) = @Ano

    RETURN @ReceitaTotal;
END;
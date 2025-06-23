WITH AssinaturasAtivas AS (
    SELECT
        id_plan,
        COUNT(*) AS TotalAssinaturas
    FROM subscriptions
    WHERE active = 1
    GROUP BY id_plan
),

ReceitaPorPlano AS (
    SELECT
        S.id_plan,
        SUM(P.price) AS TotalPago
    FROM payments P
    JOIN subscriptions S ON P.id_subscriptions = S.id_subscriptions
    GROUP BY S.id_plan
)

SELECT
    PL.name AS NomePlano,
    COALESCE(AA.TotalAssinaturas, 0) AS TotalAssinaturasAtivas,
    COALESCE(RP.TotalPago, 0) AS TotalPago
FROM plans PL
LEFT JOIN AssinaturasAtivas AA ON PL.id_plan = AA.id_plan
LEFT JOIN ReceitaPorPlano RP ON PL.id_plan = RP.id_plan
ORDER BY TotalAssinaturasAtivas DESC;
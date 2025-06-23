-- Clientes que se inscreveram em Janeiro de 2023 se comportam de maneira diferente daqueles que se inscreveram em Junho de 2023? Queremos ver a taxa de retenção baseada no mês em que fizeram a primeira assinatura.

WITH UserRetention AS (
    SELECT
        FORMAT(dt_start, 'yyyy-MM') AS MesInicial,
        DATEDIFF(MONTH, dt_start, ISNULL(dt_end, GETDATE())) AS RetencaoEmMeses
    FROM
        subscriptions
)
SELECT
    MesInicial,
    AVG(RetencaoEmMeses) AS RetencaoMediaEmMeses
FROM
    UserRetention
WHERE
    MesInicial IN ('2023-01', '2023-06')
GROUP BY
    MesInicial;
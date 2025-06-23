CREATE PROCEDURE CalcularTaxaRetencaoAcumulada
AS
BEGIN

    WITH RetencaoClientes AS (
    
        SELECT
            p.name AS plan_name,
            s.id_user,
            MONTH(s.dt_start) AS mes_inicio,
            COUNT(DISTINCT s.id_user) AS total_iniciaram
        FROM
            subscriptions s
        JOIN
            plans p ON s.id_plan = p.id_plan
        WHERE
            s.active = 1 
        GROUP BY
            p.name, s.id_user, MONTH(s.dt_start)
    ),

    ClientesAtivos AS (
    
        SELECT
            p.name AS plan_name,
            s.id_user,
            MONTH(s.dt_start) AS mes_inicio,
            COUNT(DISTINCT s.id_user) AS total_ativos
        FROM
            subscriptions s
        JOIN
            plans p ON s.id_plan = p.id_plan
        WHERE
            s.active = 1 AND s.dt_end IS NULL 
        GROUP BY
            p.name, s.id_user, MONTH(s.dt_start)
    )

    SELECT
        r.plan_name,
        r.mes_inicio,
        r.total_iniciaram,
        c.total_ativos,

        SUM(CASE
                WHEN r.total_iniciaram > 0 
                    THEN CAST(c.total_ativos AS FLOAT) / r.total_iniciaram * 100
                ELSE 0
            END) OVER (PARTITION BY r.plan_name ORDER BY r.mes_inicio) AS taxa_retencao_acumulada
    FROM
        RetencaoClientes r
    JOIN
        ClientesAtivos c ON r.plan_name = c.plan_name AND r.mes_inicio = c.mes_inicio
    ORDER BY
        r.plan_name, r.mes_inicio;

END;

exec CalcularTaxaRetencaoAcumulada
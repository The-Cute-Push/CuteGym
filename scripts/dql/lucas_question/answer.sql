WITH CalculoDias AS (
    SELECT
        U.id_user,
        U.nm_user,
        U.email,
        P.name AS NomePlano,
        DATEDIFF(day, S.dt_start,
            CASE
                -- Se ainda está assinando na nossa academia
                WHEN S.active = 1 THEN GETDATE() -- active é BIT, logo 1 = TRUE
                -- Se ainda não está mais assinando na nossa academia e terminou hoje ou no passado
                WHEN S.active = 0 AND DATEADD(month, P.duration_mnth, S.dt_start) <= GETDATE() THEN DATEADD(month, P.duration_mnth, S.dt_start)
                -- Se terminou a assinatura no futuro, algo que não deveria ter como
                ELSE S.dt_start
            END9
        ) AS DiasAtivo
    FROM users U
    JOIN user_types UT ON U.id_user_type = UT.id_user_type
    JOIN subscriptions S ON U.id_user = S.id_user
    JOIN plans P ON S.id_plan = P.id_plan
    WHERE UT.name = 'Member'
),
RankingLealdade AS (
    SELECT
        nm_user,
        email,
        NomePlano,
        DiasAtivo,
        ROW_NUMBER() OVER (ORDER BY DiasAtivo DESC) AS RNK
    FROM CalculoDias
)
SELECT
    nm_user,
    email,
    NomePlano,
    DiasAtivo
FROM RankingLealdade
WHERE RNK <= 5
ORDER BY DiasAtivo DESC;
go

-- Agora adicionar os índices ddl/indices/idx_pergunta_lucas.sql e repetir o select para comparar no plano de execução com e sem os índices.
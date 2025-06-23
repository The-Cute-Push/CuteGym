WITH UsersLeais AS (
    SELECT
        U.id_user,
        U.nm_user,
        U.email,
        S.dt_start,
        P.name AS NomePlano,
        P.duration_mnth,
        S.active,
        DATEDIFF(day, S.dt_start,
            CASE
                WHEN S.active = 1 THEN GETDATE() -- Active é BIT, logo, 1 = TRUE
                -- Se inativa, a data final é a dt_start + duration_mnth, mas apenas se for no passado
                WHEN S.active = 0 AND DATEADD(month, P.duration_mnth, S.dt_start) < GETDATE() THEN DATEADD(month, P.duration_mnth, S.dt_start)
                ELSE S.dt_start -- Caso a assinatura inativa tenha terminado no futuro, ou seja, um caso atípico
            END
        ) AS DiasAtivo,
        ROW_NUMBER() OVER (ORDER BY
            DATEDIFF(day, S.dt_start,
                CASE
                    WHEN S.active = 1 THEN GETDATE()
                    WHEN S.active = 0 AND DATEADD(month, P.duration_mnth, S.dt_start) < GETDATE() THEN DATEADD(month, P.duration_mnth, S.dt_start)
                    ELSE S.dt_start
                END
            ) DESC
        ) AS RNK
    FROM users U
    JOIN user_types UT ON U.id_user_type = UT.id_user_type
    JOIN subscriptions S ON U.id_user = S.id_user
    JOIN plans P ON S.id_plan = P.id_plan
    WHERE UT.name = 'Member'
)
SELECT
    UL.nm_user,
    UL.email,
    UL.NomePlano,
    UL.DiasAtivo
FROM UsersLeais UL
WHERE UL.RNK <= 5
ORDER BY UL.DiasAtivo DESC;
go

-- Now add the index and the select again in the same script with execution plan active to see the difference
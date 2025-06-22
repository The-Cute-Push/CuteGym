DECLARE @ano INT = 2;
DECLARE @ano_base INT = YEAR(GETDATE()) - @ano;
DECLARE @ano_anterior INT = YEAR(GETDATE()) - (@ano + 1);

WITH ReceitaCrescimento AS (
    SELECT
        P.[name],
        @ano_base AS Ano,
        dbo.ReceitaTotalAno(P.[name], @ano_base) AS ReceitaTotal,
        dbo.ReceitaTotalAno(P.[name], @ano_base) - dbo.ReceitaTotalAno(P.[name], @ano_anterior) AS CrescimentoReceita
    FROM plans P
    GROUP BY P.[name]
)
SELECT
    RC.[name],
    RC.Ano,
    RC.ReceitaTotal,
    RC.CrescimentoReceita
FROM ReceitaCrescimento RC
ORDER BY RC.CrescimentoReceita DESC; 
go

CREATE INDEX IX_plans_name_covering ON dbo.plans(name)
INCLUDE (id_plan);
go

CREATE INDEX IX_subscriptions_active_dt_start_covering ON dbo.subscriptions(active, dt_start)
INCLUDE (id_plan, id_subscriptions);
go

CREATE INDEX IX_payments_id_subscriptions_price ON dbo.payments(id_subscriptions)
INCLUDE (price);
go

WITH ReceitaCrescimento AS (
    SELECT
        P.[name],
        @ano_base AS Ano,
        dbo.ReceitaTotalAno(P.[name], @ano_base) AS ReceitaTotal,
        dbo.ReceitaTotalAno(P.[name], @ano_base) - dbo.ReceitaTotalAno(P.[name], @ano_anterior) AS CrescimentoReceita
    FROM plans P
    GROUP BY P.[name]
)
SELECT
    RC.[name],
    RC.Ano,
    RC.ReceitaTotal,
    RC.CrescimentoReceita
FROM ReceitaCrescimento RC
ORDER BY RC.CrescimentoReceita DESC, RC.[name];
go

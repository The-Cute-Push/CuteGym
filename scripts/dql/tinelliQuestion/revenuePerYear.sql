-- This script calculates the total revenue for each plan in the last two years and the growth in revenue from the previous year to the current year.


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

CREATE TRIGGER trg_validate_active_status
ON subscriptions
AFTER INSERT, UPDATE
AS
BEGIN
    -- Verifica se alguma linha viola a regra
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE dt_end IS NULL AND active = 0
    )
    BEGIN
        RAISERROR('Assinaturas com dt_end NULL devem ter active = 1.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;



-- Retornará erro
INSERT INTO subscriptions (id_plan, id_user, active, dt_start)
VALUES (1, 1, 0, '2024-01-01');

-- Retornará certo
INSERT INTO subscriptions (id_plan, id_user, active, dt_start)
VALUES (1, 1, 1, '2024-01-01');
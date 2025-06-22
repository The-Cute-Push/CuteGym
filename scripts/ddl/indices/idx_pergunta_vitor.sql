CREATE INDEX IX_plans_name_covering ON dbo.plans(name)
INCLUDE (id_plan);
go

CREATE INDEX IX_subscriptions_active_dt_start_covering ON dbo.subscriptions(active, dt_start)
INCLUDE (id_plan, id_subscriptions);
go

CREATE INDEX IX_payments_id_subscriptions_price ON dbo.payments(id_subscriptions)
INCLUDE (price);
go

CREATE INDEX IX_user_types_name_covering
ON dbo.user_types(name)
INCLUDE (id_user_type);

CREATE INDEX IX_users_id_user_type_covering
ON dbo.users(id_user_type)
INCLUDE (id_user, nm_user, email);

CREATE INDEX IX_plans_id_plan_covering
ON dbo.plans(id_plan)
INCLUDE (name, duration_mnth);

CREATE INDEX IX_subscriptions_id_user_covering
ON dbo.subscriptions(id_user)
INCLUDE (id_plan, dt_start, active);
go
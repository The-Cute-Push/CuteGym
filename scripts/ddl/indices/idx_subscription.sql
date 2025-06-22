CREATE NONCLUSTERED INDEX idx_subscriptions_user
ON subscriptions (id_user);

CREATE NONCLUSTERED INDEX idx_subscriptions_plan
ON subscriptions (id_plan);

CREATE NONCLUSTERED INDEX idx_subscriptions_active
ON subscriptions (active);
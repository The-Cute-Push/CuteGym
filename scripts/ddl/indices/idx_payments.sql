CREATE NONCLUSTERED INDEX idx_payments_subscription
ON payments (id_subscriptions);

CREATE NONCLUSTERED INDEX idx_payments_dt
ON payments (dt_payment);

CREATE NONCLUSTERED INDEX idx_payments_method
ON payments (id_method);


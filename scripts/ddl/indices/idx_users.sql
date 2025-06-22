CREATE NONCLUSTERED INDEX idx_users_email
ON users (email);

CREATE NONCLUSTERED INDEX idx_users_dt_creation
ON users (dt_creation);

CREATE NONCLUSTERED INDEX idx_users_user_type
ON users (id_user_type);

CREATE NONCLUSTERED INDEX idx_users_address
ON users (id_address);
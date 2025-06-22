CREATE NONCLUSTERED INDEX idx_address_city_state_country
ON address (city, state, country);
-- 20-init_default_secrets.sql
-- This script sets up the secrets nosql table

-- 1) Create the secrets table
CREATE TABLE IF NOT EXISTS secrets (
  secret_key   TEXT    PRIMARY KEY,
  secret_value JSONB   NOT NULL,
  created_at   TIMESTAMPTZ DEFAULT now(),
  modified_at   TIMESTAMPTZ DEFAULT now()
);

-- 2) Grant minimal privileges
GRANT SELECT ON secrets            TO ${SECRETS_READ_USER};
GRANT SELECT, INSERT, UPDATE, DELETE ON secrets TO ${SECRETS_WRITE_USER};

-- (Optional) seed with a placeholder
WITH initial AS (
  SELECT 'example_api_key' AS key, '{"key":"value"}'::jsonb AS val
)
INSERT INTO secrets (secret_key, secret_value)
SELECT key, val FROM initial
ON CONFLICT (secret_key) DO NOTHING;

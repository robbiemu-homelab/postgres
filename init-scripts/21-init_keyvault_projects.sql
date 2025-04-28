-- 30-init_add_project_key.sql

-- 1) Add the namespace column
ALTER TABLE secrets
  ADD COLUMN project_key TEXT NOT NULL DEFAULT '';

-- 2) Make (project_key, secret_key) the primary key
ALTER TABLE secrets
  DROP CONSTRAINT secrets_pkey,
  ADD PRIMARY KEY (project_key, secret_key);

-- 3) Adjust grants (if you rely on SELECT ... TO secrets_reader)
GRANT SELECT (secret_value) ON secrets TO secrets_reader;
GRANT INSERT, UPDATE, DELETE ON secrets TO secrets_writer;

-- init-scripts/00-init_db.tpl

-- create the admin user if it doesn’t already exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = '${DEV_ADMIN_USER}'
  ) THEN
    CREATE ROLE "${DEV_ADMIN_USER}" LOGIN PASSWORD '${DEV_ADMIN_PASSWORD}';
  END IF;
END
$$;
GRANT ALL PRIVILEGES ON DATABASE "${POSTGRES_DB}" TO "${DEV_ADMIN_USER}";

-- create the API access user if it doesn’t already exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = '${API_ACCESS_USER}'
  ) THEN
    CREATE ROLE "${API_ACCESS_USER}" LOGIN PASSWORD '${API_ACCESS_PASSWORD}';
  END IF;
END
$$;
GRANT SELECT, INSERT, UPDATE, DELETE
  ON ALL TABLES IN SCHEMA public
  TO "${API_ACCESS_USER}";

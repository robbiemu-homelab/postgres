-- init-scripts/01-init_keyvault_roles.tpl

-- create the reader/writer roles if they don’t exist
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = 'secrets_reader') THEN
    CREATE ROLE secrets_reader;
  END IF;
END
$$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = 'secrets_writer') THEN
    CREATE ROLE secrets_writer;
  END IF;
END
$$;

-- create the users and assign those roles
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = '${SECRETS_READ_USER}') THEN
    CREATE ROLE "${SECRETS_READ_USER}" LOGIN PASSWORD '${SECRETS_READ_PASSWORD}';
  END IF;
END
$$;
GRANT secrets_reader TO "${SECRETS_READ_USER}";

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = '${SECRETS_WRITE_USER}') THEN
    CREATE ROLE "${SECRETS_WRITE_USER}" LOGIN PASSWORD '${SECRETS_WRITE_PASSWORD}';
  END IF;
END
$$;
GRANT secrets_writer TO "${SECRETS_WRITE_USER}";

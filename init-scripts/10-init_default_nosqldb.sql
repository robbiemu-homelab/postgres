-- Create a specific role for NoSQL-like table access
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = 'nosql_role'
    ) THEN
        CREATE ROLE nosql_role;
    END IF;
END
$$;

-- Create the NoSQL-like table using JSONB if it doesn't already exist
CREATE TABLE IF NOT EXISTS nosql_table (
    id SERIAL PRIMARY KEY,
    document JSONB NOT NULL
);

-- Grant necessary privileges to the nosql_role on this table
GRANT SELECT, INSERT ON TABLE nosql_table TO nosql_role;

-- Define your specific values to be inserted as JSONB documents
WITH documents_to_insert AS (
    SELECT '{"key": "value1"}'::jsonb AS doc UNION ALL
    SELECT '{"key": "value2"}'::jsonb
),
check_existing AS (
    SELECT COUNT(*) AS cnt FROM nosql_table
)
INSERT INTO nosql_table (document)
SELECT doc FROM documents_to_insert
WHERE NOT EXISTS (
    SELECT 1 FROM check_existing WHERE cnt > 0
);

-- Optionally, assign the nosql_role to specific users if needed
-- GRANT nosql_role TO some_user;
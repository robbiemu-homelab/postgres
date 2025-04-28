CREATE ROLE sql_role;

-- Create a table with a UNIQUE constraint on 'data'
CREATE TABLE IF NOT EXISTS postgres_default_table (
    id SERIAL PRIMARY KEY,
    data TEXT NOT NULL UNIQUE  -- Ensure no duplicate entries for the same data value
);

GRANT SELECT, INSERT ON TABLE postgres_default_table TO sql_role;

-- Insert default records only if there are no other existing records
WITH check_existing AS (
    SELECT COUNT(*) AS cnt FROM postgres_default_table
)
INSERT INTO postgres_default_table (data)
SELECT * FROM (VALUES 
    ('default_record_1'),
    ('default_record_2')
) AS new_data(data)
WHERE NOT EXISTS (
    SELECT 1 FROM check_existing WHERE cnt > 0
);

-- Drop old records older than 30 days, for example
-- DELETE FROM postgres_default_table WHERE created_at < NOW() - INTERVAL '30 days';

-- Optionally, assign the sql_role to specific users if needed
-- GRANT sql_role TO some_user;
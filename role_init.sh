#!/bin/bash

#File Name : role_init.sh



# Wait until PostgreSQL is ready

# until psql -h localhost -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q' 2>/dev/null; do
#     echo "Waiting for PostgreSQL..."
#     sleep 2
# done

# Run SQL with dynamic environment variables
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<EOSQL
-- Create user if it doesn't exist
DO
\$do\$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '$ORM_USER') THEN
      EXECUTE 'CREATE USER ' || quote_ident($ORM_USER) || ' WITH PASSWORD ' || quote_literal($ORM_PASSWORD);
   END IF;
END
\$do\$;

-- Grant privileges
GRANT CONNECT ON DATABASE "$POSTGRES_DB" TO "$ORM_USER";
GRANT CREATE ON SCHEMA public TO "$ORM_USER";
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO "$ORM_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO "$ORM_USER";
 
-- Set the database timezone to Asia/Kolkata
ALTER DATABASE "$POSTGRES_DB" SET timezone TO 'Asia/Kolkata';
EOSQL
 
echo "ORM user setup and timezone configuration completed."
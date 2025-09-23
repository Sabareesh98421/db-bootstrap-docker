-- role_init.sql

--create user
DO 
$do$
BEGIN 
    IF NOT EXISTS (SELECT  FROM pg_roles WHERE rolname = :'ORM_USER') THEN
        EXECUTE 'CREATE USER ' || quote_ident(:'ORM_USER') ||  ' WITH PASSWORD ' || quote_literal(:'ORM_PASSWORD');
    END IF;
END
$do$;



-- Grant access to the created user on the specific database.
GRANT CONNECT ON DATABASE :'POSTGRES_DB' TO :'ORM_USER';
\C :'POSTGRES_DB';
GRANT CREATE ON SCHEMA public TO :'ORM_USER';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO :'ORM_USER';


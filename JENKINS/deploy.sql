BEGIN
    CASE
        WHEN '&1' == 'UPDATE-SQL' THEN
            -- liquibase update-sql -changelog-file ../DATABASE/masterChangeLog.sql
            EXECUTE IMMEDIATE 'liquibase update-sql -changelog-file ../DATABASE/masterChangeLog.sql';
        ELSE
            EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL';
    END CASE; 
END;
/
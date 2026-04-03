USE DATABASE SNOWWORK_LAB;
USE SCHEMA OBSERVABILITY;

SELECT
    ID,
    LOG_TEXT,
    SNOWFLAKE.CORTEX.COMPLETE(
        'llama3.1-8b',
        CONCAT(
            'Summarize this agent log in one short sentence: ',
            LOG_TEXT
        )
    ) AS SUMMARY
FROM CORTEX_LOG_LAB
ORDER BY ID;
USE DATABASE SNOWWORK_LAB;
USE SCHEMA OBSERVABILITY;

CREATE OR REPLACE TABLE CORTEX_LOG_ENRICHED AS
SELECT
    ID,
    LOG_TEXT,
    SNOWFLAKE.CORTEX.COMPLETE(
        'llama3.1-8b',
        CONCAT(
            'You are an AI observability assistant. ',
            'Return exactly four lines in this exact format only:\n',
            'ISSUE_TYPE: <one of TIMEOUT, PERMISSION, DATA_QUALITY, SUCCESS, OTHER>\n',
            'SEVERITY: <LOW, MEDIUM, HIGH>\n',
            'ROOT_CAUSE: <short phrase>\n',
            'NEXT_STEP: <short action or NONE>\n',
            'If the log is successful, set ISSUE_TYPE to SUCCESS, use LOW severity, ',
            'set ROOT_CAUSE to Successful execution, and NEXT_STEP to NONE. ',
            'Do not add anything else. ',
            'Log: ',
            LOG_TEXT
        )
    ) AS STRUCTURED_DIAGNOSIS,
    CURRENT_TIMESTAMP() AS ENRICHED_AT
FROM CORTEX_LOG_LAB;
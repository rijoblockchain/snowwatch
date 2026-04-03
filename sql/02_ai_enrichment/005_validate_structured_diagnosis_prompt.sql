USE DATABASE SNOWWORK_LAB;
USE SCHEMA OBSERVABILITY;

WITH DIAGNOSIS_OUTPUT AS (
    SELECT
        ID,
        LOG_TEXT,
        SNOWFLAKE.CORTEX.COMPLETE(
            'llama3.1-8b',
            CONCAT(
                'You are an AI observability assistant for enterprise agent systems. ',
                'Analyze the log and return exactly four lines in this exact format only:\n',
                'ISSUE_TYPE: <one of TIMEOUT, PERMISSION, DATA_QUALITY, SUCCESS, OTHER>\n',
                'SEVERITY: <LOW, MEDIUM, HIGH>\n',
                'ROOT_CAUSE: <short system-focused phrase>\n',
                'NEXT_STEP: <short operational action or NONE>\n',
                'Rules: ',
                'If the log indicates success, return ISSUE_TYPE: SUCCESS, SEVERITY: LOW, ROOT_CAUSE: Successful execution, NEXT_STEP: NONE. ',
                'Do not mention customers or users unless explicitly present in the log. ',
                'Do not add any explanation before or after the four lines. ',
                'Log: ',
                LOG_TEXT
            )
        ) AS STRUCTURED_DIAGNOSIS
    FROM CORTEX_LOG_LAB
)
SELECT *
FROM DIAGNOSIS_OUTPUT
ORDER BY ID;